import os
import sys
import glob
import numpy as np
import matplotlib.pyplot as plt
import subprocess

class NuLatPhysicsValidator:
    def __init__(self):
        # Configuration
        self.data_dir = os.getcwd()
        
        # Initialize placeholders (will be set in configure())
        self.test_num = None
        self.root_filename = None
        self.root_file = None
        self.txt_file = None
        
        self.macro_path = os.path.join(self.data_dir, "readValidation.C")
        self.plot_dir = os.path.join(self.data_dir, "validation_plots")
        self.stats_file = os.path.join(self.plot_dir, "validation_statistics.txt")
        
        # Detector Geometry
        self.det_half_width = 160.0 # 5*2.5 inch = 317.5mm, half-width ~ 159mm
        
        # Physics Flags (will be set by user)
        self.has_shielding = False
        self.Li6_doped = False

    def configure(self):
        """Detect files and prompt user for configuration."""
        
        # 1. Detect Root Files
        root_files = glob.glob(os.path.join(self.data_dir, "nulat_validation_test_*.ntuple.root"))
        root_files.sort()
        
        print("\n--- NuLat Physics Validator Configuration ---")
        
        if not root_files:
            print("No 'nulat_validation_test_*.ntuple.root' files found in current directory.")
            user_val = input("Enter the full filename or test number (e.g., '2'): ").strip()
            if user_val.isdigit():
                self.test_num = user_val
                self.root_filename = f"nulat_validation_test_{self.test_num}.ntuple.root"
            else:
                self.root_filename = user_val
                # Try to extract a number for text file naming, else use 'custom'
                import re
                match = re.search(r'test_(\d+)', user_val)
                self.test_num = match.group(1) if match else "custom"
        
        elif len(root_files) == 1:
            self.root_filename = os.path.basename(root_files[0])
            # Extract number
            import re
            match = re.search(r'test_(\d+)', self.root_filename)
            self.test_num = match.group(1) if match else "0"
            print(f"Found one file: {self.root_filename}. Using it.")
            
        else:
            print("Multiple ROOT files found:")
            for i, f in enumerate(root_files):
                print(f"  [{i+1}] {os.path.basename(f)}")
            
            choice = input(f"Select file (1-{len(root_files)}) or enter test number: ").strip()
            if choice.isdigit() and 1 <= int(choice) <= len(root_files):
                self.root_filename = os.path.basename(root_files[int(choice)-1])
                import re
                match = re.search(r'test_(\d+)', self.root_filename)
                self.test_num = match.group(1) if match else "0"
            elif choice.isdigit():
                self.test_num = choice
                self.root_filename = f"nulat_validation_test_{self.test_num}.ntuple.root"
            else:
                print("Invalid selection. Exiting.")
                sys.exit(1)

        # Set derived paths
        self.root_file = os.path.join(self.data_dir, self.root_filename)
        self.txt_file = os.path.join(self.data_dir, f"validation_data_test_{self.test_num}.txt")
        
        print(f"Target ROOT File: {self.root_filename}")
        print(f"Target Text File: {os.path.basename(self.txt_file)}")

        # 2. Physics Flags
        print("\n--- Simulation Parameters ---")
        self.has_shielding = input("Is this run SHIELDED? (y/n) [n]: ").strip().lower() == 'y'
        self.Li6_doped = input("Is this run Li-6 DOPED? (y/n) [n]: ").strip().lower() == 'y'
        
        print("\nConfiguration Complete.")
        print(f"Shielding: {self.has_shielding}")
        print(f"Li-6 Doped: {self.Li6_doped}\n")
        
        if not os.path.exists(self.plot_dir):
            os.makedirs(self.plot_dir)

    def extract_data(self):
        """Run the ROOT macro to dump text data."""
        if os.path.exists(self.txt_file) and os.path.getsize(self.txt_file) > 0:
            print(f"Found existing data: {self.txt_file}")
            ans = input("Overwrite? (y/n) [n]: ").strip().lower()
            if ans != 'y': return True

        if not os.path.exists(self.root_file):
            print(f"Error: {self.root_file} not found.")
            return False

        if self.Li6_doped:
            cuts = "trackPDG == 2112 || trackPDG == -11 || trackPDG == 22 || trackPDG == 1000020040 || trackPDG == 1000010030"
        else:
            cuts = "trackPDG == 2112 || trackPDG == -11 || trackPDG == 22"

        # REMOVED trackID and parentID from columns to avoid TTreeFormula errors
        macro_content = f"""
void readValidation(const char* filename) {{
  TFile *_file0 = TFile::Open(filename);
  if (!_file0 || _file0->IsZombie()) {{ return; }}
  auto T = (TTree*)_file0->Get("output");
  T->SetScanField(-1);
  const char* columns = "trackPDG : trackProcess : mcx : mcy : mcz : trackPosX : trackPosY : trackPosZ : trackTime : trackKE";
  const char* cuts = "{cuts}";
  T->Scan(columns, cuts, "colsize=25 precision=9 col=::20.10");
}}
"""
        with open(self.macro_path, "w") as f:
            f.write(macro_content)

        print("Running extraction...")
        cmd = f'root -l -q -b "{self.macro_path}(\\"{self.root_file}\\")" > "{self.txt_file}"'
        subprocess.run(cmd, shell=True, check=True)
        
        subprocess.run(f"sed -i '1,3d' {self.txt_file}", shell=True)
        subprocess.run(f"sed -i '$d' {self.txt_file}", shell=True)
        subprocess.run(f"sed -i 's/*//g' {self.txt_file}", shell=True)
        return True

    def process_and_plot(self):
        print(f"Streaming data from {self.txt_file}...")
        
        # Metrics
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
        delayed_gamma_all = []
        shielding_backgrounds = [] 
        
        alpha_energies = []
        triton_energies = []

        # Energy Depositions (Total per event)
        edep_positron = []
        edep_gamma_prompt = []  # NEW
        edep_gamma_delayed = [] # NEW
        edep_alpha = []
        edep_triton = []

        sample_traces = [] 
        current_row = None
        evt_steps = []

        try:
            with open(self.txt_file, 'r') as f:
                for line in f:
                    if not line.strip(): continue
                    parts = line.split()
                    try:
                        row = int(parts[0])
                        pdg = int(float(parts[2])) 
                        proc = int(float(parts[3]))
                        # Parse without ID columns
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
                            self._analyze_event(evt_steps, current_row, 
                                              initial_kes, true_capture_dists, true_capture_times, 
                                              thermal_times, true_capture_scatters, all_track_scatters, escape_dists,
                                              scatter_dists, scatter_energies, pos_dists, sample_traces,
                                              prompt_gamma_deposits, delayed_gamma_deposits, delayed_gamma_all, shielding_backgrounds,
                                              alpha_energies, triton_energies,
                                              edep_positron, edep_gamma_prompt, edep_gamma_delayed, edep_alpha, edep_triton)
                        current_row = row
                        evt_steps = []

                    evt_steps.append(vals)

                if current_row is not None:
                    self._analyze_event(evt_steps, current_row,
                                      initial_kes, true_capture_dists, true_capture_times, 
                                      thermal_times, true_capture_scatters, all_track_scatters, escape_dists,
                                      scatter_dists, scatter_energies, pos_dists, sample_traces,
                                      prompt_gamma_deposits, delayed_gamma_deposits, delayed_gamma_all, shielding_backgrounds,
                                      alpha_energies, triton_energies,
                                      edep_positron, edep_gamma_prompt, edep_gamma_delayed, edep_alpha, edep_triton)
        except FileNotFoundError:
            print(f"Error: {self.txt_file} not found.")
            return

        self._generate_plots_and_stats(initial_kes, true_capture_dists, true_capture_times, thermal_times,
                           true_capture_scatters, all_track_scatters, escape_dists, 
                           scatter_dists, scatter_energies, pos_dists, sample_traces,
                           prompt_gamma_deposits, delayed_gamma_deposits, delayed_gamma_all, shielding_backgrounds,
                           alpha_energies, triton_energies,
                           edep_positron, edep_gamma_prompt, edep_gamma_delayed, edep_alpha, edep_triton)

    def _analyze_event(self, steps, row_num,
                      initial_kes, true_capture_dists, true_capture_times, 
                      thermal_times, true_capture_scatters, all_track_scatters, escape_dists,
                      scatter_dists, scatter_energies, pos_dists, sample_traces,
                      prompt_gamma_deposits, delayed_gamma_deposits, delayed_gamma_all, shielding_backgrounds,
                      alpha_energies, triton_energies,
                      edep_positron, edep_gamma_prompt, edep_gamma_delayed, edep_alpha, edep_triton):
        
        neutrons = [s for s in steps if s['pdg'] == 2112]
        positrons = [s for s in steps if s['pdg'] == -11]
        gammas = [s for s in steps if s['pdg'] == 22]
        ions = [s for s in steps if s['pdg'] > 1000000000]

        # --- Energy Deposition Calculation ---
        def sum_energy_loss(particle_steps):
            if not particle_steps: return 0.0
            particle_steps.sort(key=lambda x: x['time'])
            total_loss = 0.0
            for i in range(len(particle_steps) - 1):
                pos = particle_steps[i]['pos']
                in_det = (abs(pos[0]) < self.det_half_width) and \
                         (abs(pos[1]) < self.det_half_width) and \
                         (abs(pos[2]) < self.det_half_width)
                if in_det:
                    delta = particle_steps[i]['ke'] - particle_steps[i+1]['ke']
                    if delta > 0: total_loss += delta
            
            last = particle_steps[-1]
            pos = last['pos']
            if (abs(pos[0]) < self.det_half_width) and \
               (abs(pos[1]) < self.det_half_width) and \
               (abs(pos[2]) < self.det_half_width):
                total_loss += last['ke']
            return total_loss

        # Positron Edep
        e_pos = sum_energy_loss(positrons)
        if e_pos > 0: edep_positron.append(e_pos)
        
        # Identify Annihilation and Capture Times first
        ann_time = None
        if positrons:
            positrons.sort(key=lambda x: x['time'])
            # Assuming last positron step is annihilation
            ann_time = positrons[-1]['time']

        cap_time = None
        is_captured_in_det = False
        if neutrons:
            neutrons.sort(key=lambda x: x['time'])
            end_step = neutrons[-1]
            pos = end_step['pos']
            in_detector = (abs(pos[0]) < self.det_half_width) and \
                          (abs(pos[1]) < self.det_half_width) and \
                          (abs(pos[2]) < self.det_half_width)
            is_valid_end = (end_step['proc'] == 1) or (end_step['ke'] == 0.0 and in_detector)
            if in_detector and is_valid_end:
                is_captured_in_det = True
                cap_time = end_step['time']

        # Gamma Edep Separation
        # Split gammas into Prompt and Delayed lists based on time
        gammas_prompt = []
        gammas_delayed = []
        
        for g in gammas:
            # If we have annihilation time, check if prompt
            is_prompt = False
            if ann_time is not None:
                if abs(g['time'] - ann_time) < 200.0: # Wide window (200ns) to catch all prompt interactions
                    is_prompt = True
                    gammas_prompt.append(g)
            
            # If not prompt, check if delayed (only if we have a capture or it's just late)
            if not is_prompt:
                # If we have a capture time, use it
                if cap_time is not None:
                    if g['time'] > cap_time - 1.0: # Causality
                        gammas_delayed.append(g)
                elif ann_time is not None:
                     # Fallback: if t > 1000ns, assume delayed
                     if g['time'] > ann_time + 1000.0:
                         gammas_delayed.append(g)

        e_gam_prompt = sum_energy_loss(gammas_prompt)
        if e_gam_prompt > 0: edep_gamma_prompt.append(e_gam_prompt)

        e_gam_delayed = sum_energy_loss(gammas_delayed)
        if e_gam_delayed > 0: edep_gamma_delayed.append(e_gam_delayed)

        # Split Ions
        alphas = [i for i in ions if i['pdg'] == 1000020040 or abs(i['pdg']-1000020040)<1]
        tritons = [i for i in ions if i['pdg'] == 1000010030 or abs(i['pdg']-1000010030)<1]
        
        e_alpha = sum_energy_loss(alphas)
        if e_alpha > 0: edep_alpha.append(e_alpha)
        
        e_triton = sum_energy_loss(tritons)
        if e_triton > 0: edep_triton.append(e_triton)

        # --- Neutron Metrics ---
        if neutrons:
            initial_kes.append(neutrons[0]['ke'])
            
            # Scatters
            n_physical_scatters = 0
            n_scatters_to_thermal = 0
            reached_thermal = False
            if len(neutrons) > 1:
                for i in range(len(neutrons) - 1):
                    if abs(neutrons[i]['ke'] - neutrons[i+1]['ke']) > 1.0e-8: 
                        n_physical_scatters += 1
                        if not reached_thermal: n_scatters_to_thermal += 1
                    if neutrons[i+1]['ke'] < 2.5e-8: reached_thermal = True
            all_track_scatters.append(n_physical_scatters)
            
            mc_vtx = np.array(neutrons[-1]['mc'])
            end_pos_arr = np.array(neutrons[-1]['pos'])
            dist = np.linalg.norm(end_pos_arr - mc_vtx)
            general_cap_pos = neutrons[-1]['pos']

            if is_captured_in_det: # Calculated above
                cap_pos = neutrons[-1]['pos']
                true_capture_dists.append(dist)
                true_capture_times.append(cap_time)
                true_capture_scatters.append(n_scatters_to_thermal)
            else:
                escape_dists.append(dist)
            
            # Thermalization
            for step in neutrons:
                if step['ke'] < 2.5e-8:
                    thermal_times.append(step['time'])
                    break
            
            # Scatter Plot Data
            if len(neutrons) > 1:
                for i in range(len(neutrons) - 1):
                    if abs(neutrons[i]['ke'] - neutrons[i+1]['ke']) > 1.0e-8:
                        p1 = np.array(neutrons[i]['pos'])
                        p2 = np.array(neutrons[i+1]['pos'])
                        d = np.linalg.norm(p2 - p1)
                        scatter_dists.append(d)
                        scatter_energies.append(neutrons[i]['ke'])
            
            # Traces
            if len(sample_traces) < 5 and len(neutrons) > 10:
                times = [x['time'] for x in neutrons]
                kes = [x['ke'] for x in neutrons]
                sample_traces.append((times, kes, row_num))

        # --- Positron Metrics ---
        # Already calc'd ann_time/pos above
        if positrons and ann_time:
             mc_vtx = np.array(positrons[-1]['mc'])
             ann_pos_arr = np.array(positrons[-1]['pos'])
             ann_pos = positrons[-1]['pos']
             dist = np.linalg.norm(ann_pos_arr - mc_vtx)
             pos_dists.append(dist)

        # --- Ion Metrics (Initial Energy) ---
        if ions:
            alpha_steps = [x['ke'] for x in ions if x['pdg'] == 1000020040 or abs(x['pdg'] - 1000020040) < 1.0]
            triton_steps = [x['ke'] for x in ions if x['pdg'] == 1000010030 or abs(x['pdg'] - 1000010030) < 1.0]
            if alpha_steps: alpha_energies.append(max(alpha_steps))
            if triton_steps: triton_energies.append(max(triton_steps))

        # --- Gamma Metrics ---
        # 1. Prompt Gammas
        if ann_time: # Re-use calculated ann_time
            # Assuming ann_pos calc'd if positrons exist
            if positrons:
                 ann_pos = positrons[-1]['pos'] # Recalc just in case
                 for g in gammas:
                    if g['time'] >= ann_time:
                        g_pos = np.array(g['pos'])
                        d = np.linalg.norm(g_pos - np.array(ann_pos))
                        if d > 10.0 and (g['time'] - ann_time) < 2.0:
                            prompt_gamma_deposits.append(d)
                            break 

        # 2. Delayed Gammas (All Sources)
        if neutrons: 
            for g in gammas:
                if g['time'] >= neutrons[-1]['time']:
                    g_pos = np.array(g['pos'])
                    d = np.linalg.norm(g_pos - np.array(neutrons[-1]['pos']))
                    if d > 10.0 and (g['time'] - neutrons[-1]['time']) < 5.0:
                        delayed_gamma_all.append(d)
                        if is_captured_in_det: delayed_gamma_deposits.append(d)
                        break

        # 3. Shielding Background Analysis
        if self.has_shielding and neutrons:
             n_end = neutrons[-1]
             # Is outside?
             end_pos = n_end['pos']
             is_outside = not ((abs(end_pos[0]) < self.det_half_width) and 
                               (abs(end_pos[1]) < self.det_half_width) and 
                               (abs(end_pos[2]) < self.det_half_width))
             if is_outside:
                 for g in gammas:
                    if g['time'] >= n_end['time']:
                         g_pos = g['pos']
                         g_in_det = (abs(g_pos[0]) < self.det_half_width) and \
                                    (abs(g_pos[1]) < self.det_half_width) and \
                                    (abs(g_pos[2]) < self.det_half_width)
                         if g_in_det:
                             src_pos = np.array(n_end['pos'])
                             hit_pos = np.array(g['pos'])
                             travel_dist = np.linalg.norm(hit_pos - src_pos)
                             shielding_backgrounds.append(travel_dist)
                             break

    def _generate_plots_and_stats(self, initial_kes, capture_dists, capture_times, thermal_times,
                       true_capture_scatters, all_track_scatters, escape_dists, 
                       scatter_dists, scatter_energies, pos_dists, sample_traces,
                       prompt_gamma_deposits, delayed_gamma_deposits, delayed_gamma_all, shielding_backgrounds,
                       alpha_energies, triton_energies,
                       edep_positron, edep_gamma_prompt, edep_gamma_delayed, edep_alpha, edep_triton):
        
        print(f"Generating plots and statistics in {self.plot_dir}...")
        
        with open(self.stats_file, 'w') as stats:
            stats.write("NuLat Physics Validation Statistics (Detailed Gamma Analysis)\n")
            stats.write("===========================================================\n\n")
            
            n_captures = len(capture_dists)
            n_escapes = len(escape_dists)
            
            stats.write(f"Total Neutron Captures (Inside Detector): {n_captures}\n")
            stats.write(f"Total Neutron Escapes (Outside Detector): {n_escapes}\n")
            if (n_captures + n_escapes) > 0:
                stats.write(f"Capture Efficiency: {n_captures/(n_captures+n_escapes)*100:.2f}%\n")
            stats.write(f"Total Positron Annihilations: {len(pos_dists)}\n")
            stats.write(f"Prompt Gammas Detected: {len(prompt_gamma_deposits)}\n")
            stats.write(f"Delayed Gammas (Internal Capture): {len(delayed_gamma_deposits)}\n")
            stats.write(f"Delayed Gammas (All Sources): {len(delayed_gamma_all)}\n")
            stats.write(f"Li-6 Alphas Detected: {len(alpha_energies)}\n")
            stats.write(f"Li-6 Tritons Detected: {len(triton_energies)}\n")
            if self.has_shielding:
                stats.write(f"Shielding Background Gammas (Entering Detector): {len(shielding_backgrounds)}\n")
            
            stats.write("\n" + "-" * 40 + "\n")

            def plot_hist_stairs(data, bins, xlabel, fname, color='skyblue', logx=False, stat_label="", x_range=None):
                if not data: 
                    if stat_label:
                        stats.write(f"{stat_label}:\n")
                        stats.write(f"  Count: 0\n\n")
                    print(f"Warning: No data for {fname}")
                    return
                
                # --- STATISTICS BLOCK ---
                if stat_label:
                    data_np = np.array(data)
                    mean_val = np.mean(data_np)
                    std_val = np.std(data_np)
                    stats.write(f"{stat_label}:\n")
                    stats.write(f"  Mean: {mean_val:.4g}\n")
                    stats.write(f"  Std Dev: {std_val:.4g}\n")
                    stats.write(f"  Count: {len(data)}\n\n")
                # ------------------------

                plt.figure(figsize=(8,6))
                try:
                    if x_range:
                        data_filtered = [d for d in data if x_range[0] <= d <= x_range[1]]
                        if not data_filtered: data_filtered = data 
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

            # --- Plots ---
            initial_kes_kev = [e * 1000.0 for e in initial_kes]
            plot_hist_stairs(initial_kes_kev, 50, 'Neutron Initial Energy (keV)', 'neutron_initial_ke.png', 
                             stat_label="Neutron Initial Kinetic Energy")
            
            plot_hist_stairs(capture_dists, 50, 'Capture Distance (mm)', 'neutron_capture_dist.png', 'orange', 
                             stat_label="Neutron Capture Distance (Inside Detector)")
            
            plot_hist_stairs(escape_dists, 50, 'Escape Distance (mm)', 'neutron_escape_dist.png', 'gray', 
                             stat_label="Neutron Escape Distance")
            
            plot_hist_stairs(pos_dists, 50, 'Annihilation Distance (mm)', 'pos_annihilation_dist.png', 'green', x_range=(0, 200),
                             stat_label="Positron Annihilation Distance")
            
            # Energy Deposition Plots
            plot_hist_stairs(edep_positron, 50, 'Positron Energy Deposited (MeV)', 'edep_positron.png', 'lime', 
                             stat_label="Positron Energy Deposition")
            
            # Prompt Gamma Energy: Finer binning (10 keV)
            plot_hist_stairs(edep_gamma_prompt, 120, 'Prompt Gamma Energy Deposited (MeV)', 'edep_gamma_prompt.png', 'magenta', x_range=(0, 1.2),
                             stat_label="Prompt Gamma Energy Deposition")
            
            # Delayed Gamma Energy: Finer binning (10 keV)
            plot_hist_stairs(edep_gamma_delayed, 250, 'Delayed Gamma Energy Deposited (MeV)', 'edep_gamma_delayed.png', 'purple', x_range=(0, 2.5),
                             stat_label="Delayed Gamma Energy Deposition")
            
            plot_hist_stairs(edep_alpha, 50, 'Alpha Energy Deposited (MeV)', 'edep_alpha.png', 'red', 
                             stat_label="Alpha Energy Deposition")
            plot_hist_stairs(edep_triton, 50, 'Triton Energy Deposited (MeV)', 'edep_triton.png', 'blue', 
                             stat_label="Triton Energy Deposition")

            # Gammas
            plot_hist_stairs(prompt_gamma_deposits, 50, 'Prompt Gamma Scatter Distance (mm)', 'prompt_gamma_scatter.png', 'red', x_range=(0, 200),
                             stat_label="Prompt Gamma Scatter Distance")
            
            plot_hist_stairs(delayed_gamma_deposits, 50, 'Delayed Gamma Scatter Distance (Internal Only)', 'delayed_gamma_scatter.png', 'darkblue', x_range=(0, 200),
                             stat_label="Delayed Gamma Scatter Distance (Internal)")
            
            plot_hist_stairs(delayed_gamma_all, 50, 'Delayed Gamma Scatter Distance (All)', 'delayed_gamma_all_scatter.png', 'blue', x_range=(0, 200),
                             stat_label="Delayed Gamma Scatter Distance (All Sources)")
            
            # Li-6 Ions
            plot_hist_stairs(alpha_energies, 50, 'Alpha Energy (MeV)', 'li6_alpha_energy.png', 'red', 
                             stat_label="Li-6 Alpha Initial Energy")
            plot_hist_stairs(triton_energies, 50, 'Triton Energy (MeV)', 'li6_triton_energy.png', 'blue', 
                             stat_label="Li-6 Triton Initial Energy")

            # Backgrounds
            if self.has_shielding:
                plot_hist_stairs(shielding_backgrounds, 50, 'Background Gamma Travel Dist (mm)', 'shielding_backgrounds.png', 'black',
                                 stat_label="Shielding Background Gamma Travel")

            # Standard Plots
            if true_capture_scatters:
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
    validator.configure()
    if validator.extract_data():
        validator.process_and_plot()
