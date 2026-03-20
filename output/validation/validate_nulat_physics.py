import os
import sys
import glob
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import subprocess

class NuLatPhysicsValidator:
    def __init__(self):
        # Configuration
        self.data_dir = os.getcwd()
        
        # Initialize placeholders
        self.test_num = None
        self.root_filename = None
        self.root_file = None
        self.txt_file = None
        
        self.macro_path = os.path.join(self.data_dir, "readValidation.C")
        self.plot_dir = os.path.join(self.data_dir, "validation_plots")
        self.stats_file = None
        
        # Detector Geometry
        self.inch = 25.4
        self.cube_size = 2.5 * self.inch      # 63.5 mm
        self.gap_size = 0.001 * self.inch     # 0.0254 mm
        self.step_size = self.cube_size + self.gap_size
        self.grid_dim = 5
        
        # Calculate Offset for Voxel Mapping
        total_span = self.grid_dim * self.step_size - self.gap_size
        self.offset = -total_span / 2.0 + self.cube_size / 2.0
        self.det_half_width = total_span / 2.0 #160.0 # 5*2.5 inch = 317.5mm, half-width ~ 159mm
        
        # Physics Flags
        self.has_shielding = False
        self.Li6_doped = False

    def configure(self):
        """Detect files and prompt user for configuration."""
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
        
        # 2. Physics Flags
        print("\n--- Simulation Parameters ---")
        self.has_shielding = input("Is this run SHIELDED? (y/n) [n]: ").strip().lower() == 'y'
        self.Li6_doped = input("Is this run Li-6 DOPED? (y/n) [n]: ").strip().lower() == 'y'
        # 3. User feedback for configuration
        print("\nConfiguration Complete.")
        print(f"Target ROOT File: {self.root_filename}")
        print(f"Target Text File: {os.path.basename(self.txt_file)}")
        print(f"Shielding: {self.has_shielding}")
        print(f"Li-6 Doped: {self.Li6_doped}\n")
        # 4. Create plot subdirectory if not present
        if not os.path.exists(self.plot_dir):
            os.makedirs(self.plot_dir)
        if self.test_num != None:
            self.stats_file = os.path.join(self.plot_dir, f"validation_statistics_test_{self.test_num}.txt")
        else:
            self.stats_file = os.path.join(self.plot_dir, "validation_statistics.txt")

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
        # Clean up headers and '*' separators from ASCII file
        subprocess.run(f"sed -i '1,3d' {self.txt_file}", shell=True)
        subprocess.run(f"sed -i '$d' {self.txt_file}", shell=True)
        subprocess.run(f"sed -i 's/*//g' {self.txt_file}", shell=True)
        return True

    def _is_in_detector(self, x, y, z):
        return (abs(x) <= self.det_half_width and 
                abs(y) <= self.det_half_width and 
                abs(z) <= self.det_half_width)

    def get_voxel_index(self, pos):
        """Map position (x,y,z) to voxel indices (i,j,k). Returns None if out of bounds."""
        idx = [0, 0, 0]
        for dim in range(3):
            # i = round((x - offset) / step)
            val = round((pos[dim] - self.offset) / self.step_size)
            if 0 <= val < self.grid_dim:
                idx[dim] = int(val)
            else:
                return None
        return tuple(idx)

    def process_and_plot(self):
        print(f"Streaming data from {self.txt_file}...")
        
        events_data = []
        current_row = None
        evt_steps = []
        sample_traces = []

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
                    except (ValueError, IndexError) as e:
                        print(f"Error processing {self.txt_file}: {e}")
                        continue

                    if row != current_row:
                        if current_row is not None:
                            evt_data = self._analyze_event(evt_steps, current_row, sample_traces)
                            if evt_data: events_data.append(evt_data)
                        current_row = row
                        evt_steps = []

                    evt_steps.append(vals)

                if current_row is not None:
                    evt_data = self._analyze_event(evt_steps, current_row, sample_traces)
                    if evt_data: events_data.append(evt_data)

        except FileNotFoundError:
            print(f"Error: {self.txt_file} not found.")
            return

        self._generate_plots_and_stats(events_data)

    def _analyze_event(self, steps, row_num, sample_traces):
        
        neutrons = [s for s in steps if s.get('pdg') == 2112]
        positrons = [s for s in steps if s.get('pdg') == -11]
        gammas = [s for s in steps if s.get('pdg') == 22]
        ions = [s for s in steps if s.get('pdg', 0) > 1000000000]

        evt = {
            'row': row_num,
            'is_li6': False,
            'initial_ke': None,
            'capture_dist': None,
            'capture_time': None,
            'escape_dist': None,
            'pos_ann_dist': None,
            'prompt_gamma_dist': None,
            'delayed_gamma_dist': None, # Internal
            'delayed_gamma_dist_all': None, # All sources
            'shield_bg_dist': None,
            'shield_bg_edep': None,
            'scatters_thermal': None,
            'thermal_time': None,
            'edep_pos': None,
            'edep_gam_p': None,
            'edep_gam_d': None,
            'edep_alpha': None,
            'edep_triton': None,
            'alpha_ke': None,
            'triton_ke': None,
            'track_len_alpha': None,
            'track_len_triton': None,
            'voxel_max_p': None, 'voxel_cluster_p': None,
            'voxel_max_d': None, 'voxel_cluster_d': None,
            'trace_time': [], 'trace_ke': [],
            'scatter_kes': [], 'scatter_lens': []
        }

        # --- Voxel Energy Map ---
        voxel_map_p = {}
        voxel_map_d = {}
        
        ann_time = positrons[-1].get('time') if positrons else 0.0
        cap_time = None
        neutron_escape = False
        neutron_cap_in_det = False
        if neutrons:
             n_end = sorted(neutrons, key=lambda x: x.get('time'))[-1]
             pos = n_end.get('pos')
             if self._is_in_detector(pos[0], pos[1], pos[2]) and (n_end.get('proc')==1 or n_end.get('ke')==0):
                 cap_time = n_end.get('time')
                 neutron_cap_in_det = True
             else:
                 neutron_escape = True
        
        split_time = cap_time if cap_time else 1000.0

        def process_edep(particle_steps, p_type="other"):
            if not particle_steps: return 0.0
            particle_steps.sort(key=lambda x: x.get('time'))
            total_loss = 0.0
            
            for i in range(len(particle_steps) - 1):
                s1 = particle_steps[i]
                s2 = particle_steps[i+1]
                delta = s1.get('ke') - s2.get('ke')
                if delta <= 0: continue
                
                pos = s1.get('pos')
                if self._is_in_detector(pos[0], pos[1], pos[2]):
                       total_loss += delta
                       v_idx = self.get_voxel_index(pos)
                       if v_idx:
                           t = s1.get('time')
                           if t < (split_time - 50.0):
                               voxel_map_p[v_idx] = voxel_map_p.get(v_idx, 0.0) + delta
                           else:
                               voxel_map_d[v_idx] = voxel_map_d.get(v_idx, 0.0) + delta

            last = particle_steps[-1]
            pos = last.get('pos')
            if self._is_in_detector(pos[0], pos[1], pos[2]):
                total_loss += last.get('ke')
                v_idx = self.get_voxel_index(pos)
                if v_idx:
                    t = last.get('time')
                    if t < (split_time - 50.0):
                        voxel_map_p[v_idx] = voxel_map_p.get(v_idx, 0.0) + last.get('ke')
                    else:
                        voxel_map_d[v_idx] = voxel_map_d.get(v_idx, 0.0) + last.get('ke')
            return total_loss

        evt['edep_pos'] = process_edep(positrons)
        
        g_prompt = [g for g in gammas if g.get('time') < split_time - 50.0]
        g_delayed = [g for g in gammas if g.get('time') >= split_time - 50.0]
        evt['edep_gam_p'] = process_edep(g_prompt)
        evt['edep_gam_d'] = process_edep(g_delayed)

        alphas = [i for i in ions if i.get('pdg') == 1000020040 or abs(i.get('pdg')-1000020040)<1]
        tritons = [i for i in ions if i.get('pdg') == 1000010030 or abs(i.get('pdg')-1000010030)<1]
        
        evt['edep_alpha'] = process_edep(alphas)
        evt['edep_triton'] = process_edep(tritons)
        
        if (evt['edep_alpha'] > 0 or evt['edep_triton'] > 0) or (alphas and tritons):
            evt['is_li6'] = True
            if alphas: evt['alpha_ke'] = max([x.get('ke') for x in alphas])
            if tritons: evt['triton_ke'] = max([x.get('ke') for x in tritons])

        # --- Ion Track Lengths ---
        def get_track_length(particle_steps):
            if not particle_steps or len(particle_steps) < 2: return 0.0
            particle_steps.sort(key=lambda x: x.get('time'))
            p_start = np.array(particle_steps[0].get('pos'))
            p_end = np.array(particle_steps[-1].get('pos'))
            return np.linalg.norm(p_end - p_start)
            
        if alphas: evt['track_len_alpha'] = get_track_length(alphas)
        if tritons: evt['track_len_triton'] = get_track_length(tritons)

        def get_cluster(v_map):
            if not v_map: return None, None
            max_v = max(v_map, key=v_map.get)
            max_e = v_map[max_v]
            neighbors = [
                (max_v[0]+1, max_v[1], max_v[2]), (max_v[0]-1, max_v[1], max_v[2]),
                (max_v[0], max_v[1]+1, max_v[2]), (max_v[0], max_v[1]-1, max_v[2]),
                (max_v[0], max_v[1], max_v[2]+1), (max_v[0], max_v[1], max_v[2]-1)
            ]
            clus_e = max_e
            for n in neighbors: clus_e += v_map.get(n, 0.0)
            return max_e, clus_e

        evt['voxel_max_p'], evt['voxel_cluster_p'] = get_cluster(voxel_map_p)
        evt['voxel_max_d'], evt['voxel_cluster_d'] = get_cluster(voxel_map_d)

        if neutrons:
            evt['initial_ke'] = neutrons[0].get('ke')
            evt['trace_time'] = [x.get('time') for x in neutrons]
            evt['trace_ke'] = [x.get('ke') for x in neutrons]

            n_phys = 0; n_therm = 0; reached = False
            for i in range(len(neutrons)-1):
                if abs(neutrons[i].get('ke') - neutrons[i+1].get('ke')) > 1.0e-8:
                    n_phys += 1
                    if not reached: n_therm += 1
                if neutrons[i+1].get('ke') < 2.5e-8: reached = True
            
            mc_vtx = np.array(neutrons[-1].get('mc'))
            end_pos_arr = np.array(neutrons[-1].get('pos'))
            dist = np.linalg.norm(end_pos_arr - mc_vtx)
            
            if cap_time: 
                evt['capture_dist'] = dist
                evt['capture_time'] = cap_time
                evt['scatters_thermal'] = n_therm
            else:
                evt['escape_dist'] = dist
            
            for step in neutrons:
                if step.get('ke') < 2.5e-8:
                    evt['thermal_time'] = step.get('time')
                    break
            
            # Scatter Plot Data (Stored in EVT)
            scatter_lens = []
            scatter_kes = []
            if len(neutrons) > 1:
                for i in range(len(neutrons) - 1):
                    if abs(neutrons[i].get('ke') - neutrons[i+1].get('ke')) > 1.0e-8:
                        p1 = np.array(neutrons[i].get('pos'))
                        p2 = np.array(neutrons[i+1].get('pos'))
                        d = np.linalg.norm(p2 - p1)
                        scatter_lens.append(d)
                        scatter_kes.append(neutrons[i].get('ke'))
            evt['scatter_lens'] = scatter_lens
            evt['scatter_kes'] = scatter_kes
            
            # Use passed-in sample_traces list
            if len(sample_traces) < 5 and len(neutrons) > 10:
                times = [x.get('time') for x in neutrons]
                kes = [x.get('ke') for x in neutrons]
                sample_traces.append({'trace_time': times, 'trace_ke': kes, 'row': row_num})

        if positrons and ann_time:
            mc_vtx = np.array(positrons[-1].get('mc'))
            ann_pos_arr = np.array(positrons[-1].get('pos'))
            dist = np.linalg.norm(ann_pos_arr - mc_vtx)
            evt['pos_ann_dist'] = dist

        if ann_time:
            ann_pos = positrons[-1].get('pos') if positrons else None
            if ann_pos is not None:
                for g in gammas:
                    if g.get('time') >= ann_time:
                        d = np.linalg.norm(np.array(g.get('pos')) - np.array(ann_pos))
                        if d > 10.0 and (g.get('time') - ann_time) < 2.0:
                            evt['prompt_gamma_dist'] = d
                            break

        if neutrons: 
            n_end = sorted(neutrons, key=lambda x: x.get('time'))[-1]
            general_cap_time = n_end.get('time')
            general_cap_pos = n_end.get('pos')
            
            for g in gammas:
                if g.get('time') >= general_cap_time:
                    g_pos = np.array(g.get('pos'))
                    d = np.linalg.norm(g_pos - np.array(general_cap_pos))
                    if d > 10.0 and (g.get('time') - general_cap_time) < 5.0:
                        evt['delayed_gamma_dist_all'] = d
                        if evt['is_li6'] == False and cap_time: 
                             evt['delayed_gamma_dist'] = d
                        break

        if self.has_shielding and neutrons:
             n_end = sorted(neutrons, key=lambda x: x.get('time'))[-1]
             end_pos = n_end.get('pos')
             if neutron_escape:
                 for g in gammas:
                    if g.get('time') >= n_end.get('time'):
                         g_pos = g.get('pos')
                         g_in_det = self._is_in_detector(g_pos[0], g_pos[1], g_pos[2])
                         if g_in_det:
                             dist = np.linalg.norm(np.array(g.get('pos')) - np.array(end_pos))
                             evt['shield_bg_dist'] = dist# this is working
                             gsteps = g.get('steps', [])# I don't know about this
                             if gsteps:
                                 edep = process_edep(gsteps)# this isn't working
                                 evt['shield_bg_edep'] = edep# this isn't working either, and is the main problem I'm trying to solve.
                             break
        return evt

    def _generate_plots_and_stats(self, events):
        
        print(f"Generating plots and statistics in {self.plot_dir}...")
        
        def get_list(key, filter_events=False):
            # If filtering is requested:
            # - For Doped: Filter by 'is_li6'
            # - For Undoped: Filter by 'capture_time' (captured in detector)
            if filter_events:
                if self.Li6_doped:
                    return [e.get(key) for e in events if e.get(key) is not None and e.get('is_li6')]
                else:
                    return [e.get(key) for e in events if e.get(key) is not None and e.get('capture_time')]
            else:
                return [e.get(key) for e in events if e.get(key) is not None]

        with open(self.stats_file, 'w') as stats:
            stats.write("NuLat Physics Validation Statistics\n\n")
            stats.write("=========================================================\n\n")
            
            all_cap = get_list('capture_dist')
            li6_cap_count = len([e for e in events if e.get('is_li6')])
            
            stats.write(f"Total Events: {len(events)}\n")
            stats.write(f"Total Captures (Inside): {len(all_cap)}\n")
            
            if self.Li6_doped or li6_cap_count > 0:
                stats.write(f"Li-6 Captures (Alpha/Triton): {li6_cap_count}\n")
                if len(all_cap) > 0:
                    stats.write(f"Li-6 Purity (Li6/Total Cap): {li6_cap_count/len(all_cap)*100:.2f}%\n")
            
            filter_name = "Li-6 Capture" if self.Li6_doped else "Detector Capture"
            stats.write(f"\n--- Filtered Statistics (Only {filter_name} Events) ---\n\n")

            def plot_metric(key, bins, xlabel, fname, color='blue', logx=False, logy=False, x_range=None, filter_events=False, stat_label=None):
                data = get_list(key, filter_events)
                label = key + (" (Filtered)" if filter_events else "")
                if stat_label:
                    label = stat_label + (" (Filtered)" if filter_events else "")
                
                # Check for empty data
                if not data: 
                    # Suppress zero-count stats for Ions if disabled
                    if "alpha" in key or "triton" in key:
                         if not self.Li6_doped: return
                    
                    if stat_label: 
                        stats.write(f"{label}:\n")
                        stats.write(f"  Count: 0\n\n")
                    print(f"Warning: No data for {fname}")
                    return
                
                # --- STATISTICS BLOCK ---
                if stat_label:
                    data_np = np.array(data)
                    mean_val = np.mean(data_np)
                    std_val = np.std(data_np)
                    stats.write(f"{label}:\n")
                    stats.write(f"  Mean: {mean_val:.4g}\n")
                    stats.write(f"  Std:  {std_val:.4g}\n")
                    stats.write(f"  Count: {len(data)}\n\n")
                # ------------------------

                plt.figure(figsize=(8,6))
                try:
                    if x_range:
                        d_filt = [d for d in data if x_range[0] <= d <= x_range[1]]
                        if not d_filt: d_filt = data 
                        counts, edges = np.histogram(d_filt, bins=bins, range=x_range)
                    else:
                        counts, edges = np.histogram(data, bins=bins)
                    
                    plt.stairs(counts, edges, fill=True, color=color, edgecolor='black', alpha=0.7)
                    plt.xlabel(xlabel)
                    plt.ylabel('Count')
                    if logx: plt.xscale('log')
                    if logy: plt.yscale('log')
                    plt.grid(True, alpha=0.3)
                    plt.tight_layout()
                    plt.savefig(os.path.join(self.plot_dir, fname))
                except Exception as e:
                    print(f"Error plotting {fname}: {e}")
                plt.close()

            # 1. Unfiltered Baselines (All Geometries)
            plot_metric('initial_ke', 50, r'Neutron $KE_0$ (MeV)', 'neutron_initial_ke.png', stat_label=r"Neutron Initial KE (MeV)")
            plot_metric('capture_dist', 50, 'Capture Dist (mm)', 'neutron_capture_dist.png', 'orange', stat_label="Capture Dist (mm)")
            plot_metric('escape_dist', 50, 'Escape Dist (mm)', 'neutron_escape_dist.png', 'gray', stat_label="Escape Dist (mm)")
            
            scat_data = get_list('scatters_thermal')
            if scat_data:
                mx_scat = int(max(scat_data))
                bins_scat = np.arange(0, mx_scat + 2) - 0.5
                plot_metric('scatters_thermal', bins_scat, 'Scatters to Thermal', 'neutron_scatters_all.png', 'gray', stat_label="Scatters to Thermal")

            

            # 2. Filtered Metrics (Specific to Geometry)
            
            # Voxels (Filtered)
            plot_metric('voxel_max_p', 50, 'Prompt Max Voxel Energy, filtered (MeV)', 'voxel_prompt_max_filt.png', 'cyan', logy=True, filter_events=True, stat_label="Edep, Prompt Max Voxel (MeV)")
            plot_metric('voxel_cluster_p', 50, 'Prompt Cluster Energy, filtered (MeV)', 'voxel_prompt_cluster_filt.png', 'teal', logy=True, filter_events=True, stat_label="Edep, Prompt Cluster (MeV)")
            
            # Delayed Voxel - Range depends on Physics
            if self.Li6_doped:
                 plot_metric('voxel_max_d', 100, 'Delayed Max Voxel Energy, Li-6 captures (MeV)', 'voxel_delayed_max_li6_cap.png', 'magenta', logy=True, x_range=(0, 6.0), filter_events=True, stat_label="Edep, Delayed Max Voxel (MeV)")
                 plot_metric('voxel_cluster_d', 100, 'Delayed Cluster Energy, Li-6 captures (MeV)', 'voxel_delayed_cluster_li6_cap.png', 'purple', logy=True, x_range=(0, 6.0), filter_events=True, stat_label="Edep, Delayed Cluster (MeV)")
            else:
                 plot_metric('voxel_max_d', 100, 'Delayed Max Voxel Energy, filtered (MeV)', 'voxel_delayed_max_filt.png', 'magenta', logy=True, x_range=(0, 3.0), filter_events=True, stat_label="Edep, Delayed Max Voxel (MeV)")
                 plot_metric('voxel_cluster_d', 100, 'Delayed Cluster Energy, filtered (MeV)', 'voxel_delayed_cluster_filt.png', 'purple', logy=True, x_range=(0, 3.0), filter_events=True, stat_label="Edep, Delayed Cluster (MeV)")

            plot_metric('edep_pos', 50, r'$e^+$ $E_{dep}, filtered$ (MeV)', 'edep_positron_filt.png', 'lime', logy=True, filter_events=True, stat_label="Positron Edep (MeV)")
            plot_metric('pos_ann_dist', 50, 'Annihilation Distance, filtered (mm)', 'pos_annihilation_dist_filt.png', 'green', x_range=(0, 200), filter_events=True, stat_label="Positron Ann Dist (mm)")

            # Capture/Thermal Time (Filtered)
            plot_metric('capture_time', np.logspace(2, 6, 50), r'$t_{cap}, filtered$ (ns)', 'capture_time_filt.png', 'brown', logx=True, filter_events=True, stat_label="Capture Time (ns)")
            plot_metric('thermal_time', np.logspace(0, 6, 50), r'$t_{therm}, filtered$ (ns)', 'therm_time_filt.png', 'teal', logx=True, filter_events=True, stat_label="Thermalization Time (ns)")
            
            # Gamma Scatter (Filtered)
            plot_metric('prompt_gamma_dist', 50, r'Scatter Dist, $\gamma_{prompt}$, filtered (mm)', 'prompt_gamma_scatter_filt.png', 'red', x_range=(0, 200), filter_events=True, stat_label="Prompt Gamma Dist (mm)")
            plot_metric('delayed_gamma_dist', 50, r'Scatter Dist, $\gamma_{delayed}$, filtered (mm)', 'delayed_gamma_scatter_filt.png', 'yellow', x_range=(0, 200), filter_events=True, stat_label="Delayed Gamma Dist (mm)")
            
            # Edep Gammas
            plot_metric('edep_gam_p', 120, r'$E_{dep}$, $\gamma_{prompt}, filtered$ (MeV)', 'edep_gam_p_filt.png', 'pink', x_range=(0, 1.2), logy=True, filter_events=True, stat_label="Prompt gamma Edep (MeV)")
            plot_metric('edep_gam_d', 250, r'$E_{dep}$, $\gamma_{delayed}, filtered$ (MeV)', 'edep_gam_d_filt.png', 'black', x_range=(0, 2.5), logy=True, filter_events=True, stat_label="Delayed gamma Edep (MeV)")
            
            # Ion Plots (Only if Doped)
            if self.Li6_doped:
                a_label_1 = "Alpha Edep (MeV)"
                a_xlab_1 = r'$\alpha$ $E_{dep}$ (MeV)'
                a_label_2 = "Alpha Track Len (mm)"
                a_xlab_2 = r'$\alpha$ Track Length (mm)'
                t_label_1 = "Triton Edep (MeV)"
                t_xlab_1 = r'Triton $E_{dep}$ (MeV)'
                t_label_2 = "Triton Track Len (mm)"
                t_xlab_2 = 'Triton Track Length (mm)'
                plot_metric('edep_alpha', 50, a_xlab_1, 'edep_alpha.png', 'red', x_range=(0, 3.0), logy=True, filter_events=True, stat_label=a_label_1)
                plot_metric('edep_triton', 50, t_xlab_1, 'edep_triton.png', 'blue', x_range=(0, 4.0), logy=True, filter_events=True, stat_label=t_label_1)
                plot_metric('track_len_alpha', 50, a_xlab_2, 'track_len_alpha.png', 'darkred', x_range=(0, 0.1), logy=True, filter_events=True, stat_label=a_label_2)
                plot_metric('track_len_triton', 50, t_xlab_2, 'track_len_triton.png', 'darkblue', x_range=(0, 0.2), logy=True, filter_events=True, stat_label=t_label_2)

            # 3. Unfiltered Comparison (Only for Undoped Runs to see noise vs signal)
            stats.write(f"\n--- Unfiltered Statistics ---\n\n")
            
            # Capture Time (Unfiltered)
            plot_metric('capture_time', np.logspace(2, 6, 50), r'$t_{cap}, unfiltered$ (ns)', 'capture_time_all.png', 'saddlebrown', logx=True, stat_label=r"Capture Time (ns)")
            
            if not self.Li6_doped:
                 # Unfiltered Voxel Energies
                 plot_metric('voxel_max_p', 50, 'Prompt Max Voxel, unfiltered (MeV)', 'voxel_prompt_max_all.png', 'darkcyan', logy=True, stat_label="Prompt Max Voxel Edep (MeV)")
                 plot_metric('voxel_max_d', 100, 'Delayed Max Voxel, unfiltered (MeV)', 'voxel_delayed_max_all.png', 'darkmagenta', logy=True, x_range=(0, 3.0), stat_label="Delayed Max Voxel Edep (MeV)")
                 
                 # Unfiltered Times
                 plot_metric('thermal_time', np.logspace(0, 6, 50), r'$t_{therm}$, unfiltered (ns)', 'therm_time_all.png', 'darkturquoise', logx=True, stat_label="Thermalization Time (ns)")
                 
                 # Unfiltered Gamma Edep
                 plot_metric('edep_gam_d', 250, r'$E_{dep}$, $\gamma_{delayed}$, unfiltered (MeV)', 'edep_gam_d_all.png', 'dimgray', x_range=(0, 2.5), logy=True, stat_label="Delayed Gamma Edep (MeV)")
                 plot_metric('edep_gam_p', 120, r'$E_{dep}$, $\gamma_{prompt}$, unfiltered (MeV)', 'edep_gam_p_all.png', 'lightpink', x_range=(0, 1.2), logy=True, stat_label="Prompt Gamma Edep (MeV)")

                 # Unfiltered Positron
                 plot_metric('edep_pos', 50, r'$e^+$ $E_{dep}$, unfiltered (MeV)', 'edep_positron_all.png', 'forestgreen', logy=True, stat_label="Positron Edep (MeV)")
                 plot_metric('pos_ann_dist', 50, 'Annihilation Dist, unfiltered (mm)', 'pos_annihilation_dist_all.png', 'darkgreen', x_range=(0, 200), stat_label="Positron Ann Dist (mm)")
                 
                 # Unfiltered Gamma Scatter Dist
                 plot_metric('prompt_gamma_dist', 50, r'$\gamma_{prompt}$ Scatter Dist, unfiltered (mm)', 'prompt_gamma_scatter_all.png', 'darkred', x_range=(0, 200), stat_label="Prompt Gamma Dist (mm)")
                 plot_metric('delayed_gamma_dist', 50, r'$\gamma_{delayed}$ Scatter Dist, unfiltered (mm)', 'delayed_gamma_scatter_all.png', 'gold', x_range=(0, 200), stat_label="Delayed Gamma Dist (mm)")

            # Neutron Traces
            # Use 'capture_time' presence for undoped filter
            traces = [e for e in events if e.get('trace_time') and (e.get('is_li6') if self.Li6_doped else e.get('capture_time'))]
            if traces:
                plt.figure(figsize=(10,6))
                for i, evt in enumerate(traces[:5]): # Plot first 5 valid
                    times = np.array(evt['trace_time'])
                    kes = np.array(evt['trace_ke'])
                    
                    # Remove the final capture point if kinetic energy is exactly 0
                    if len(kes) > 0 and kes[-1] == 0.0:
                        times = times[:-1]
                        kes = kes[:-1]
                        
                    plt.plot(times, kes, marker='o', markersize=2, alpha=0.6, label=f"Event {evt['row']}")
                plt.axhline(y=2.5e-8, color='r', linestyle='--', label='Thermal (~0.025 eV)')
                plt.yscale('log')
                plt.xscale('log')
                plt.xlabel('Time (ns)')
                plt.ylabel('Kinetic Energy (MeV)')
                plt.legend()
                plt.grid(True, alpha=0.3)
                plt.tight_layout()
                plt.savefig(os.path.join(self.plot_dir, 'neutron_trace_filt.png'))
                plt.close()
            
            # Also plot Unfiltered Traces for undoped to see "missed" events
            if not self.Li6_doped:
                traces_all = [e for e in events if e.get('trace_time')]
                if traces_all:
                    plt.figure(figsize=(10,6))
                    for i, evt in enumerate(traces_all[:5]):
                        times = np.array(evt['trace_time'])
                        kes = np.array(evt['trace_ke'])
                        # Remove the final capture point if kinetic energy is exactly 0
                        if len(kes) > 0 and kes[-1] == 0.0:
                            times = times[:-1]
                            kes = kes[:-1]
                        plt.plot(times, kes, marker='o', markersize=2, alpha=0.4, linestyle=':', label=f"Event {evt['row']}")
                    plt.axhline(y=2.5e-8, color='r', linestyle='--', label='Thermal (~0.025 eV)')
                    plt.yscale('log')
                    plt.xscale('log')
                    plt.xlabel('Time (ns)')
                    plt.ylabel('Kinetic Energy (MeV)')
                    plt.legend()
                    plt.grid(True, alpha=0.3)
                    plt.tight_layout()
                    plt.savefig(os.path.join(self.plot_dir, 'neutron_trace_all.png'))
                    plt.close()

            # 2D Histogram
            scat_kes = []
            scat_lens = []
            for e in events:
                if e.get('scatter_kes') and e.get('scatter_lens'):
                    min_len = min(len(e['scatter_kes']), len(e['scatter_lens']))
                    scat_kes.extend(e['scatter_kes'][:min_len])
                    scat_lens.extend(e['scatter_lens'][:min_len])
                    
            if scat_kes and scat_lens:
                plt.figure(figsize=(8,6))
                plt.hist2d(scat_lens, scat_kes, bins=[np.logspace(-3, 3, 50), np.logspace(-10, -1, 50)], cmap='viridis', norm=mcolors.LogNorm())
                plt.axhline(y=2.e-8, color='black', linestyle='--', label='Thermal (~0.025 eV)')
                plt.xscale('log')
                plt.yscale('log')
                plt.ylabel('Neutron Kinetic Energy (MeV)')
                plt.xlabel('Scatter Length (mm)')
                plt.legend()
                plt.colorbar(label='Count')
                plt.tight_layout()
                plt.savefig(os.path.join(self.plot_dir, 'neutron_energy_vs_scatter_2d.png'))
                plt.close()

            # Backgrounds
            if self.has_shielding:
                stats.write(f"\n--- Shielding Background Statistics ---\n\n")
                # 1. Plot Dist and Edep
                plot_metric('shield_bg_dist', 50, r'Shielding $\gamma$ Dist (mm)', 'shield_bg_dist.png', 'black', stat_label="Shielding BG Dist (mm)")
                plot_metric('shield_bg_edep', 250, r'Shielding $\gamma$ $E_{dep}$ (MeV)', 'shield_bg_edep.png', 'black', stat_label="Shielding BG Edep (MeV)")
                
                # 2. Extract specific arrays for voxel histograms
                shield_max_d = [e['shield_max_d'] for e in events if 'shield_max_d' in e]
                shield_cluster_d = [e['shield_cluster_d'] for e in events if 'shield_cluster_d' in e]
                
                # 3. Generate the Delayed Max Voxel (Shielding Filter) Histogram
                if shield_max_d:
                    plt.figure(figsize=(8,6))
                    plt.hist(shield_max_d, bins=100, range=(0, 5), color='purple', alpha=0.7)
                    plt.xlabel('Delayed Max Voxel Energy (MeV)')
                    plt.ylabel('Count')
                    plt.grid(True, alpha=0.3)
                    plt.tight_layout()
                    plt.savefig(os.path.join(self.plot_dir, 'shield_voxel_max_d.png'))
                    plt.close()
                    stats.write(f"Shielding Voxel Max D:\n  Mean: {np.mean(shield_max_d):.4g}\n  Std:  {np.std(shield_max_d):.4g}\n  Count: {len(shield_max_d)}\n\n")

                # 4. Generate the Delayed Cluster Voxel (Shielding Filter) Histogram
                if shield_cluster_d:
                    plt.figure(figsize=(8,6))
                    plt.hist(shield_cluster_d, bins=100, range=(0, 5), color='magenta', alpha=0.7)
                    plt.xlabel('Delayed Cluster Energy (MeV)')
                    plt.ylabel('Count')
                    plt.grid(True, alpha=0.3)
                    plt.tight_layout()
                    plt.savefig(os.path.join(self.plot_dir, 'shield_voxel_cluster_d.png'))
                    plt.close()
                    stats.write(f"Shielding Voxel Cluster D:\n  Mean: {np.mean(shield_cluster_d):.4g}\n  Std:  {np.std(shield_cluster_d):.4g}\n  Count: {len(shield_cluster_d)}\n\n")

        print(f"Statistics saved to: {self.stats_file}")

if __name__ == "__main__":
    validator = NuLatPhysicsValidator()
    validator.configure()
    if validator.extract_data():
        validator.process_and_plot()
        
# Code generated with assistance from Google Gemini Pro AI tool
