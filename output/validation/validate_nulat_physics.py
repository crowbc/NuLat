import os
import sys
import numpy as np
import matplotlib.pyplot as plt
import subprocess

class NuLatPhysicsValidator:
    def __init__(self):
        # Configuration
        self.data_dir = "/home/jack/RATPAC2/ratpac-setup/ratpac/RatpacExperiment/output/validation"
        self.test_num = 1
        self.root_file = os.path.join(self.data_dir, f"nulat_validation_test_{self.test_num}.ntuple.root")
        self.macro_path = os.path.join(self.data_dir, "readValidation.C")
        self.txt_file = os.path.join(self.data_dir, f"validation_data_test_{self.test_num}.txt")
        self.plot_dir = os.path.join(self.data_dir, "validation_plots")
        self.stats_file = os.path.join(self.plot_dir, "validation_statistics.txt")
        
        # Detector Bounds (approx +/- 160mm)
        # 5 * 2.5 inch = 12.5 inch = 317.5 mm total width
        # Half-width ~ 159 mm. Using 160.0 to be slightly tighter/more precise.
        self.det_half_width = 160.0 
        
        if not os.path.exists(self.plot_dir):
            os.makedirs(self.plot_dir)

    def extract_data(self):
        """Run the ROOT macro to dump text data."""
        if os.path.exists(self.txt_file) and os.path.getsize(self.txt_file) > 0:
            print(f"Validation data found at {self.txt_file}. Skipping extraction.")
            return True

        if not os.path.exists(self.root_file):
            print(f"Error: ROOT file not found at {self.root_file}")
            return False

        print(f"Extracting validation data (incl. Gammas) from {self.root_file}...")
        cmd = f'root -l -q -b "{self.macro_path}(\\"{self.root_file}\\")" > "{self.txt_file}"'
        subprocess.run(cmd, shell=True, check=True)
        
        print("Cleaning output file...")
        subprocess.run(f"sed -i '1,3d' {self.txt_file}", shell=True)
        subprocess.run(f"sed -i '$d' {self.txt_file}", shell=True)
        subprocess.run(f"sed -i 's/*//g' {self.txt_file}", shell=True)
        
        return True

    def process_and_plot(self):
        print("Streaming data and analyzing...")
        
        # --- Metrics ---
        initial_kes = []
        true_capture_dists = [] 
        true_capture_times = []
        true_capture_scatters = [] 
        all_track_scatters = [] 
        escape_dists = []
        thermal_times = []
        scatter_dists = [] 
        scatter_energies = [] 
        pos_dists = []
        prompt_gamma_deposits = [] 
        delayed_gamma_deposits = [] 
        sample_traces = [] 

        # --- Diagnostic Counters ---
        diag_thermal_no_capture = 0
        diag_printed = 0

        # --- Stream Variables ---
        current_row = None
        evt_neutrons = [] 
        evt_positrons = [] 
        evt_gammas = [] 

        try:
            with open(self.txt_file, 'r') as f:
                for line in f:
                    if not line.strip(): continue
                    parts = line.split()
                    try:
                        row = int(parts[0])
                        pdg = int(float(parts[2])) 
                        proc = int(float(parts[3]))
                        vals = {
                            'pdg': pdg, 'proc': proc,
                            'mc': (float(parts[4]), float(parts[5]), float(parts[6])),
                            'pos': (float(parts[7]), float(parts[8]), float(parts[9])),
                            'time': float(parts[10]), 'ke': float(parts[11])
                        }
                    except (ValueError, IndexError):
                        continue

                    if row != current_row:
                        if current_row is not None:
                            # Pass diag counter by reference-ish (list)
                            self._analyze_event(evt_neutrons, evt_positrons, evt_gammas, current_row, 
                                              initial_kes, true_capture_dists, true_capture_times, 
                                              thermal_times, true_capture_scatters, all_track_scatters, escape_dists,
                                              scatter_dists, scatter_energies, pos_dists, sample_traces,
                                              prompt_gamma_deposits, delayed_gamma_deposits, diag_counter=[diag_thermal_no_capture, diag_printed])
                            # Update counters from list hack
                            diag_thermal_no_capture = self.last_diag[0]
                            diag_printed = self.last_diag[1]

                        current_row = row
                        evt_neutrons = []
                        evt_positrons = []
                        evt_gammas = []

                    if pdg == 2112: evt_neutrons.append(vals)
                    elif pdg == -11: evt_positrons.append(vals)
                    elif pdg == 22: evt_gammas.append(vals)

                if current_row is not None:
                    self._analyze_event(evt_neutrons, evt_positrons, evt_gammas, current_row,
                                      initial_kes, true_capture_dists, true_capture_times, 
                                      thermal_times, true_capture_scatters, all_track_scatters, escape_dists,
                                      scatter_dists, scatter_energies, pos_dists, sample_traces,
                                      prompt_gamma_deposits, delayed_gamma_deposits, diag_counter=[diag_thermal_no_capture, diag_printed])
        except FileNotFoundError:
            print(f"Error: {self.txt_file} not found.")
            return

        self._generate_plots_and_stats(initial_kes, true_capture_dists, true_capture_times, thermal_times,
                           true_capture_scatters, all_track_scatters, escape_dists, 
                           scatter_dists, scatter_energies, pos_dists, sample_traces,
                           prompt_gamma_deposits, delayed_gamma_deposits, diag_thermal_no_capture)

    def _analyze_event(self, neutrons, positrons, gammas, row_num,
                      initial_kes, true_capture_dists, true_capture_times, 
                      thermal_times, true_capture_scatters, all_track_scatters, escape_dists,
                      scatter_dists, scatter_energies, pos_dists, sample_traces,
                      prompt_gamma_deposits, delayed_gamma_deposits, diag_counter):
        
        # --- Neutron Analysis ---
        cap_pos = None
        cap_time = None
        is_captured_in_det = False
        is_thermalized = False
        
        if neutrons:
            neutrons.sort(key=lambda x: x['time'])
            initial_kes.append(neutrons[0]['ke'])
            
            # Count Physical Scatters & Scatters to Thermalization
            # Threshold lowered to 0.01 eV (1e-8 MeV) to capture thermalization steps
            n_physical_scatters = 0
            n_scatters_to_thermal = 0
            reached_thermal = False

            if len(neutrons) > 1:
                for i in range(len(neutrons) - 1):
                    # Check scatter
                    if abs(neutrons[i]['ke'] - neutrons[i+1]['ke']) > 1.0e-8: 
                        n_physical_scatters += 1
                        if not reached_thermal:
                            n_scatters_to_thermal += 1
                    
                    # Update thermal status based on destination energy
                    if neutrons[i+1]['ke'] < 2.5e-8:
                        reached_thermal = True

            all_track_scatters.append(n_physical_scatters)
            
            # Check Thermalization (for thermal_times stats)
            for step in neutrons:
                if step['ke'] < 2.5e-8:
                    thermal_times.append(step['time'])
                    is_thermalized = True
                    break

            # --- Robust Capture Identification ---
            end_step = neutrons[-1]
            pos = end_step['pos']
            in_detector = (abs(pos[0]) < self.det_half_width) and \
                          (abs(pos[1]) < self.det_half_width) and \
                          (abs(pos[2]) < self.det_half_width)
            
            # Valid End Criteria:
            is_valid_end = (end_step['proc'] == 1) or (end_step['ke'] == 0.0 and in_detector)
            
            mc_vtx = np.array(end_step['mc'])
            end_pos_arr = np.array(end_step['pos'])
            dist = np.linalg.norm(end_pos_arr - mc_vtx)

            if in_detector and is_valid_end:
                is_captured_in_det = True
                cap_pos = end_step['pos'] 
                cap_time = end_step['time'] 
                true_capture_dists.append(dist)
                true_capture_times.append(end_step['time'])
                # Store scatters ONLY until thermalization for captured events
                true_capture_scatters.append(n_scatters_to_thermal)
            else:
                escape_dists.append(dist)
                
                # --- Diagnostic: Thermalized but not captured? ---
                if is_thermalized and in_detector:
                    diag_counter[0] += 1
                    if diag_counter[1] < 10: 
                        print(f"DIAGNOSTIC: Row {row_num} thermalized but NOT captured.")
                        print(f"  Final Pos: {pos}")
                        print(f"  Final KE: {end_step['ke']}")
                        print(f"  Final Proc: {end_step['proc']}")
                        diag_counter[1] += 1

            
            # Step Distances/Energies (Using same threshold as scatter count)
            if len(neutrons) > 1:
                for i in range(len(neutrons) - 1):
                    if abs(neutrons[i]['ke'] - neutrons[i+1]['ke']) > 1.0e-8:
                        p1 = np.array(neutrons[i]['pos'])
                        p2 = np.array(neutrons[i+1]['pos'])
                        d = np.linalg.norm(p2 - p1)
                        scatter_dists.append(d)
                        scatter_energies.append(neutrons[i]['ke'])
            
            if len(sample_traces) < 5 and len(neutrons) > 10:
                times = [x['time'] for x in neutrons]
                kes = [x['ke'] for x in neutrons]
                sample_traces.append((times, kes, row_num))

        # --- Positron Analysis ---
        ann_pos = None
        ann_time = None
        if positrons:
            positrons.sort(key=lambda x: x['time'])
            ann_step = positrons[-1]
            for step in positrons:
                if step['proc'] == 4: ann_step = step
            
            mc_vtx = np.array(ann_step['mc'])
            ann_pos_arr = np.array(ann_step['pos'])
            ann_pos = ann_step['pos'] 
            ann_time = ann_step['time'] 
            dist = np.linalg.norm(ann_pos_arr - mc_vtx)
            pos_dists.append(dist)

        # --- Gamma Matching ---
        if ann_pos and ann_time:
            for g in gammas:
                if g['time'] >= ann_time:
                    g_pos = np.array(g['pos'])
                    d = np.linalg.norm(g_pos - np.array(ann_pos))
                    if d > 10.0: 
                        if (g['time'] - ann_time) < 2.0:
                            prompt_gamma_deposits.append(d)
                            break 

        if is_captured_in_det:
            for g in gammas:
                if g['time'] >= cap_time:
                    g_pos = np.array(g['pos'])
                    d = np.linalg.norm(g_pos - np.array(cap_pos))
                    if d > 10.0:
                        if (g['time'] - cap_time) < 5.0: 
                            delayed_gamma_deposits.append(d)
                            break
        
        self.last_diag = diag_counter

    def _generate_plots_and_stats(self, initial_kes, capture_dists, capture_times, thermal_times,
                       true_capture_scatters, all_track_scatters, escape_dists, 
                       scatter_dists, scatter_energies, pos_dists, sample_traces,
                       prompt_gamma_deposits, delayed_gamma_deposits, diag_thermal_no_capture):
        
        print(f"Generating plots and statistics in {self.plot_dir}...")
        
        with open(self.stats_file, 'w') as stats:
            stats.write("NuLat Physics Validation Statistics (Diagnostic)\n")
            stats.write("================================================\n\n")
            
            n_captures = len(capture_dists)
            n_escapes = len(escape_dists)
            total_simulated = 10000 
            
            stats.write(f"Total Neutron Captures (Inside Detector): {n_captures}\n")
            stats.write(f"Total Neutron Escapes (Outside Detector): {n_escapes}\n")
            stats.write(f"Capture Efficiency: {n_captures/total_simulated*100:.2f}%\n")
            stats.write(f"Thermalized but NOT Captured: {diag_thermal_no_capture}\n")
            stats.write(f"Total Positron Annihilations: {len(pos_dists)}\n")
            stats.write(f"Prompt Gammas Detected: {len(prompt_gamma_deposits)}\n")
            stats.write(f"Delayed Gammas Detected: {len(delayed_gamma_deposits)}\n\n")
            stats.write("-" * 40 + "\n")

            def plot_hist_stairs(data, bins, xlabel, fname, color='skyblue', logx=False, stat_label="", x_range=None):
                if not data: 
                    print(f"Warning: No data for {fname}")
                    return
                
                data_np = np.array(data)
                mean_val = np.mean(data_np)
                std_val = np.std(data_np)
                
                if stat_label:
                    stats.write(f"{stat_label}:\n")
                    stats.write(f"  Mean: {mean_val:.4g}\n")
                    stats.write(f"  Std Dev: {std_val:.4g}\n")
                    stats.write(f"  Count: {len(data)}\n\n")

                plt.figure(figsize=(8,6))
                try:
                    # Apply explicit range if provided
                    if x_range:
                        # Filter data for better histogram display
                        data_filtered = [d for d in data if x_range[0] <= d <= x_range[1]]
                        if not data_filtered: data_filtered = data # Fallback
                        counts, edges = np.histogram(data_filtered, bins=bins, range=x_range)
                    else:
                        counts, edges = np.histogram(data, bins=bins)
                        
                    plt.stairs(counts, edges, fill=True, color=color, edgecolor='black', alpha=0.7)
                    plt.xlabel(xlabel)
                    plt.ylabel('Counts')
                    if logx: plt.xscale('log')
                    plt.grid(True, alpha=0.3)
                    plt.tight_layout()
                    plt.savefig(os.path.join(self.plot_dir, fname))
                except Exception as e:
                    print(f"Plot error {fname}: {e}")
                plt.close()

            # Plots
            
            # Neutron Initial KE: Convert MeV to keV for plotting
            initial_kes_kev = [e * 1000.0 for e in initial_kes]
            plot_hist_stairs(initial_kes_kev, 50, 'Neutron Initial Energy (keV)', 'neutron_initial_ke.png', 
                             stat_label="Neutron Initial Kinetic Energy (keV)")
            
            plot_hist_stairs(capture_dists, 50, 'Capture Distance (mm)', 'neutron_capture_dist.png', 'orange', 
                             stat_label="Neutron Capture Distance (Inside Detector)")
            plot_hist_stairs(escape_dists, 50, 'Escape Distance (mm)', 'neutron_escape_dist.png', 'gray', 
                             stat_label="Neutron Escape Distance")
            
            # Positron Annihilation Distance: Limit range to see main population (e.g. 0-200mm)
            plot_hist_stairs(pos_dists, 50, 'Annihilation Distance (mm)', 'pos_annihilation_dist.png', 'green', 
                             stat_label="Positron Annihilation Distance", x_range=(0, 200))
            
            # Prompt Gamma Scatter Distance: Limit range (e.g. 0-200mm)
            plot_hist_stairs(prompt_gamma_deposits, 50, 'Prompt Gamma Scatter Distance (mm)', 
                             'prompt_gamma_scatter.png', 'red', 
                             stat_label="Prompt Gamma Scatter Distance", x_range=(0, 200))
            
            # Delayed Gamma Scatter Distance: Limit range (e.g. 0-200mm)
            plot_hist_stairs(delayed_gamma_deposits, 50, 'Delayed Gamma Scatter Distance (mm)', 
                             'delayed_gamma_scatter.png', 'darkblue', 
                             stat_label="Delayed Gamma Scatter Distance", x_range=(0, 200))

            if true_capture_scatters:
                # Removed hard x_range limit as requested
                # Changed label to reflect "Scatters to Thermalization"
                # Use integer bins to avoid gaps
                mx = max(true_capture_scatters)
                bins_scat = np.arange(0, mx + 2) - 0.5
                plot_hist_stairs(true_capture_scatters, bins_scat, 'Number of Scatters to Thermalization', 'neutron_scatters_captured.png', 'purple', 
                                 stat_label="Neutron Scatters to Thermalization (Captured Events)")

            plot_hist_stairs(thermal_times, np.logspace(0, 6, 50), 'Thermalization Time (ns)', 'therm_time.png', 'teal', logx=True, 
                             stat_label="Time to Thermalization")
            plot_hist_stairs(capture_times, np.logspace(2, 6, 50), 'Capture Time (ns)', 'capture_time.png', 'brown', logx=True, 
                             stat_label="Neutron Capture Time (Inside Detector)")

            if sample_traces:
                plt.figure(figsize=(10,6))
                for t, ke, row in sample_traces:
                    plt.plot(t, ke, marker='o', markersize=2, alpha=0.6, label=f"Event {row}")
                plt.axhline(y=2.5e-8, color='r', linestyle='--', label='Thermal (~0.025 eV)')
                plt.yscale('log')
                plt.xscale('log')
                plt.xlabel('Time (ns)')
                plt.ylabel('Kinetic Energy (MeV)')
                plt.legend()
                plt.grid(True, alpha=0.3)
                plt.tight_layout()
                plt.savefig(os.path.join(self.plot_dir, 'neutron_trace.png'))
                plt.close()

            if scatter_energies and scatter_dists:
                plt.figure(figsize=(10,8))
                try:
                    # Extend energy range down to 1e-9 MeV (1 meV) to see thermal spot
                    plt.hist2d(scatter_dists, scatter_energies, 
                               bins=[np.logspace(-2, 3, 50), np.logspace(-9, 0, 50)], 
                               cmap='plasma', norm='log')
                    plt.xscale('log')
                    plt.yscale('log')
                    plt.ylabel('Neutron KE (MeV)')
                    plt.xlabel('Step Length (mm)')
                    plt.colorbar(label='Counts')
                    plt.tight_layout()
                    plt.savefig(os.path.join(self.plot_dir, 'energy_vs_step.png'))
                except Exception as e:
                    print(f"2D Plot Error: {e}")
                plt.close()
                
        print(f"Statistics saved to: {self.stats_file}")

if __name__ == "__main__":
    validator = NuLatPhysicsValidator()
    if validator.extract_data():
        validator.process_and_plot()
