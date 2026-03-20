import os
import sys
import json
import time as timer
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
import uproot
import awkward as ak

class NuLatDirectionalAnalyzer:
    """
    Analyzes NuLat directionality using interactive menus. Features:
    1) Root extraction natively via uproot
    2) Loading a previously saved JSON binning matrix
    3) Artificial mock generation for a specified angle
    """
    def __init__(self, fiducial_json="nulat_fiducial_directionality_set.json"):
        # Debug mode
        self.debug = False
        if self.debug:
            self.init_time = timer.time()
     
        # --- Formatting and Plot Settings ---
        self.latex = True
        if self.latex:
            plt.rc('font', family='serif', size=19)
            plt.rcParams['text.usetex'] = True
            plt.rcParams['mathtext.fontset'] = 'cm'

        # --- Directory Configuration ---
        self.base_dir = os.getcwd()
        self.matrices_dir = os.path.join(self.base_dir, "bin_matrices")
        self.plots_dir = os.path.join(self.base_dir, "plots")
        os.makedirs(self.matrices_dir, exist_ok=True)
        os.makedirs(self.plots_dir, exist_ok=True)

        # --- Detector Geometry ---
        self.inch = 25.4
        self.cube_size = 2.5 * self.inch      # 63.5 mm
        self.gap_size = 0.001 * self.inch     # 0.0254 mm
        self.step_size = self.cube_size + self.gap_size
        self.grid_dim = 5

        # --- Smart Search for Fiducial File ---
        script_dir = os.path.dirname(os.path.abspath(__file__))
        possible_paths = [
            os.path.join(self.base_dir, fiducial_json),
            os.path.join(self.base_dir, "..", fiducial_json),
            os.path.join(self.base_dir, "../fiducial", fiducial_json),
            os.path.join(script_dir, fiducial_json),
            os.path.join(script_dir, "..", fiducial_json)
        ]
 
        self.fiducial_path = None
        for p in possible_paths:
            if os.path.exists(p):
                self.fiducial_path = p
                break

        self.fiducial_data = {}
        if self.fiducial_path:
            try:
                with open(self.fiducial_path, 'r') as f:
                    data = json.load(f)
                    self.fiducial_data = data.get("angles", data)
            except Exception as e:
                print(f"Error loading fiducial JSON: {e}")
        else:
            print("Warning: Fiducial JSON not found. Curve fitting against fiducial set will be skipped.")

    def _sanitize_filename(self, tag):
        """Removes spaces and math characters for clean filenames."""
        if self.debug:
            print(f"Tag before sanitizing: {tag}")
        return tag.replace(' ', '_').replace('.', '_').replace('$', '').replace('\\', '').replace('^', '').replace('circ', '_deg').replace('theta', '').replace('(', '').replace(')', '').replace('=', '').strip('()=')

    def extract_root_data(self, file_path):
        """Loads root file and constructs step-by-step energy deposition."""
        print(f"\nLoading ROOT file via uproot: {file_path}")
        try:
            tree = uproot.open(f"{file_path}:output")
            print("Successfully located TTree: 'output'")
        except Exception as e:
            print(f"Error opening tree 'output': {e}")
            return None

        branches_to_load = [
            'trackPDG', 'trackProcess', 'mcx', 'mcy', 'mcz', 
            'trackPosX', 'trackPosY', 'trackPosZ', 'trackTime', 'trackKE'
        ]

        print("Extracting arrays into Pandas DataFrame (this may take a moment)...")
        if self.debug:
            time_start = timer.time()
        try:
            # Extract natively as awkward arrays
            ak_arrays = tree.arrays(branches_to_load)
            # Cleanly expand into a flat DataFrame
            df = ak.to_dataframe(ak_arrays).reset_index()
            # Map the primary event level ('entry') to 'Row' for our analysis
            if 'entry' in df.columns:
                df = df.rename(columns={'entry': 'Row'})
            elif 'Row' not in df.columns:
                df['Row'] = df.index  # Fallback
            print("Calculating voxel coordinates and energy depositions...")

            # 1. Calculate voxel coordinates in all three dimensions
            total_span = self.grid_dim * self.step_size
            df['vx'] = np.floor((df['trackPosX'] + (total_span / 2)) / self.step_size).astype(int) - 2
            df['vy'] = np.floor((df['trackPosY'] + (total_span / 2)) / self.step_size).astype(int) - 2
            df['vz'] = np.floor((df['trackPosZ'] + (total_span / 2)) / self.step_size).astype(int) - 2
            # 2. Sort DataFrame sequentially to preserve step order
            idx_cols = [col for col in ['Row', 'subentry', 'subsubentry', 'subsubsubentry'] if col in df.columns]        
            sort_cols = idx_cols + (['trackPDG'] if 'trackPDG' in df.columns else [])
            df = df.sort_values(by=sort_cols)
            # 3. Shift trackKE down by 1 row within the same track
            if len(idx_cols) > 1:
                group_cols = idx_cols[:-1] 
            else:
                group_cols = ['Row']            
            if 'trackPDG' in df.columns and 'trackPDG' not in group_cols:
                group_cols.append('trackPDG')
            df['KE_prev'] = df.groupby(group_cols)['trackKE'].shift(1)
            # 4. Calculate edep as the difference between previous and current step KE
            df['edep'] = df['KE_prev'] - df['trackKE']
            # 5. Clip edep at 0 to prevent negative fluctuations and fill initial NaN to 0
            df['edep'] = df['edep'].fillna(0).clip(lower=0)

            print("Calculations complete!")
            if self.debug:
                print(f"DataFrame shape: {df.shape}")
                print(f"Sample rows:\n{df.head(15)}")    
            
            print(f"Extraction successful! Loaded {len(df)} total track steps.")
            
        except Exception as e:
            print(f"Error extracting branches: {e}")
            return None

        if self.debug:
            time_to_extract = timer.time() - time_start
            total_running_time = timer.time() - self.init_time
            print(f"Time to extract ROOT file: {time_to_extract:.3f}s")
            print(f"Total running time at end of extraction: {total_running_time:.3f}s")
        return df

    def binEvents(self, df):
        """Converts step data into an event-by-event binning matrix."""
        print("\n--- Starting binning ---")
        if self.debug:
            start_time = timer.time()
        matrix_dict = {}
        for dx in range(-2, 3):
            for dy in range(-2, 3):
                matrix_dict[f"{dx},{dy}"] = 0
        grouped = df.groupby('Row')
        try:
            # 1. Separate Prompt and Delayed Events using PDG Codes and Time as backup
            positron_code = -11
            alpha_code = 1000020040
            triton_code = 1000010030
            # Prompt: Positrons OR events very early in time (< 1000 ns)
            prompt_mask = prompt_mask = (df['trackPDG'] == positron_code) | (df['trackTime'] < 1000)
            prompt_events = df[prompt_mask].copy()
            # Delayed: Alpha/Triton from capture OR events late in time (>= 1000 ns)
            delayed_mask = (df['trackPDG'].isin([alpha_code, triton_code])) | (df['trackTime'] >= 1000)
            delayed_events = df[delayed_mask].copy()
            if self.debug:
                print(f"Found {len(prompt_events)} prompt tracks and {len(delayed_events)} delayed tracks.")
            if prompt_events.empty or delayed_events.empty:
                print("Warning: Missing prompt or delayed events. Cannot correlate.")
                return None
            # 2. PROMPT: Find Voxel with Max True Edep per event
            p_voxel_edeps = prompt_events.groupby(['Row', 'vx', 'vy', 'vz'])['edep'].sum().reset_index()
            p_max_idx = p_voxel_edeps.groupby('Row')['edep'].idxmax()
            p_max_voxels = p_voxel_edeps.loc[p_max_idx]
            # 3. DELAYED: Find Voxel with Max True Edep per event
            d_voxel_edeps = delayed_events.groupby(['Row', 'vx', 'vy', 'vz'])['edep'].sum().reset_index()
            d_max_idx = d_voxel_edeps.groupby('Row')['edep'].idxmax()
            d_max_voxels = d_voxel_edeps.loc[d_max_idx]       
            # 4. MERGE and calculate offsets
            merged = pd.merge(p_max_voxels, d_max_voxels, on='Row', suffixes=('_p', '_d'))
            if merged.empty:
                print("Warning: Merged DataFrame is empty. No rows have BOTH prompt and delayed events.")
                return None                
            # Calculate displacement in voxels
            merged['dx'] = merged['vx_d'] - merged['vx_p']
            merged['dy'] = merged['vy_d'] - merged['vy_p']
            # 4a. Count number of Li-6 captures
            total_li6_raw = df['Row'].nunique() if 'Row' in df.columns else "Unknown"
            # 4b. Count captures that successfully matched a prompt and delayed signal
            initial_matched_captures = len(merged)
            if self.debug:
                print(f"Merged DataFrame constructed for {initial_matched_captures} prompt and delayed events:\n{merged.head(15)}")
            # 4c. Filter the dataframe to only keep deltaX and deltaY between -2 and 2
            merged_filtered = merged[
                (merged['dx'] >= -2) & (merged['dx'] <= 2) &
                (merged['dy'] >= -2) & (merged['dy'] <= 2)
            ]        
            # 4d. Count final binned captures
            binned_captures = len(merged_filtered)
            # 5. BINNING: Count the occurrences of each (deltaX, deltaY) pair
            displacement_counts = merged_filtered.groupby(['dx', 'dy']).size().to_dict()
            # --- Update the dictionary with actual calculated counts ---
            for k, v in displacement_counts.items():
                key_str = f"{int(k[0])},{int(k[1])}"
                # Populate the count if it exists, otherwise it remains 0
                matrix_dict[key_str] = int(v)
            if self.debug:
                time_to_bin = timer.time() - start_time
                total_running_time = timer.time() - self.init_time
                print(f"Time to bin {binned_captures} events: {time_to_bin:.3f}s")
                print(f"Total running time after binning: {total_running_time:.3f}s")
            return matrix_dict
        except Exception as e:
            print(f"Error binning data: {e}\naborting...")
            return None

    def generate_mock_data(self, true_angle=45):
        """Generates mock data by sampling the fiducial set from a specific incident angle and adding statistical noise."""
        print(f"Generating mock data centered at {true_angle} degrees...")
        if str(true_angle) not in self.fiducial_data:
            print("Angle not found in fiducial set. Falling back to angle 0.")
            true_angle = 0
        if self.debug:
            print(f"Dictionary to convert:\n{self.fiducial_data[str(true_angle)]}")
            print(f"Matrix form:\n{self.convert_dict_to_matrix(self.fiducial_data[str(true_angle)])}")
        base_matrix = self.convert_dict_to_matrix(self.fiducial_data[str(true_angle)])
        noisy_data_matrix = np.random.poisson(base_matrix)
        if self.debug:
            print(f"Mock Data Matrix:\n{noisy_data_matrix}")
        matrix_dict = {}
        # Dynamically find the center index to make this invariant to grid size changes (e.g. 5x5 or 7x7)
        mid_row = noisy_data_matrix.shape[0] // 2
        mid_col = noisy_data_matrix.shape[1] // 2
        # Loop over the exact keys present in the original fiducial set and write the counts in the new dictionary
        for key in self.fiducial_data[str(true_angle)].keys():
            dx, dy = map(int, key.split(','))
            row = mid_row + dy
            col = mid_col + dx
            matrix_dict[key] = int(noisy_data_matrix[row, col])
        if self.debug:
            print(f"Dictionary containing Mock Matrix:\n{matrix_dict}")
        return matrix_dict, true_angle

    def convert_dict_to_matrix(self, matrix_dict):
        """Converts string dictionary 'dx,dy' to 5x5 numpy array."""
        matrix = np.zeros((5, 5))
        for key, count in matrix_dict.items():
            try:
                dx_str, dy_str = key.split(',')
                dx, dy = int(dx_str), int(dy_str)
                # Center matrix at [2,2]
                row = dy + 2
                col = dx + 2
                if 0 <= row < 5 and 0 <= col < 5:
                    matrix[row, col] = count
            except ValueError:
                continue
        return matrix

    def normalize_matrix(self, matrix):
        """Normalizes matrix to sum to 1."""
        total = np.sum(matrix)
        if total > 0:
            return matrix / total
        return matrix

    def compute_frobenius_norm(self, m1, m2):
        """Calculates Frobenius norm between two matrices."""
        return np.linalg.norm(m1 - m2, 'fro')

    def plot_binning_matrix(self, matrix, filename, title=""):
        """Plots a 5x5 heatmap of the data distribution."""
        plt.figure(figsize=(8, 6))
        plt.imshow(matrix, cmap='viridis', origin='lower', extent=[-2.5, 2.5, -2.5, 2.5])
        for i in range(5):
            for j in range(5):
                count = int(matrix[i, j])
                y = i - 2
                x = j - 2
                plt.text(x, y, str(count), ha='center', va='center', color='white')
        plt.colorbar(label="Counts")
        plt.xlabel(r"$\Delta x$ (voxels)")
        plt.ylabel(r"$\Delta y$ (voxels)")
        plt.xticks([-2, -1, 0, 1, 2])
        plt.yticks([-2, -1, 0, 1, 2])
        out_path = os.path.join(self.plots_dir, filename)
        plt.savefig(out_path, bbox_inches='tight')
        plt.close()
        print(f"Saved binning matrix plot to {out_path}")

    def run_frobenius_analysis(self, matrix_dict, title_tag):
        """Calculates differences against fiducial data and plots a best fit curve."""
        if not self.fiducial_data:
            print("No fiducial data loaded. Skipping Frobenius analysis.")
            return
 
        print("\nComputing Frobenius norms against fiducial set...")
        raw_data_matrix = self.convert_dict_to_matrix(matrix_dict)
        normalized_data_matrix = self.normalize_matrix(raw_data_matrix)
        angles = []
        norms = []
        for angle_str, fid_dict in self.fiducial_data.items():
            angle_int = int(angle_str)
            fid_matrix = self.convert_dict_to_matrix(fid_dict)
            normalized_fid_matrix = self.normalize_matrix(fid_matrix)
            norm = self.compute_frobenius_norm(normalized_data_matrix, normalized_fid_matrix)
            if angle_int > 180:
                angle_int -= 360
            angles.append(angle_int)
            norms.append(norm)
        sorted_indices = np.argsort(angles)
        angles_sorted = np.array(angles)[sorted_indices]
        norms_sorted = np.array(norms)[sorted_indices]
        # functions for fits
        def gaussian(x, a, x0, sigma, c):
            return a * np.exp(-(x - x0)**2 / (2 * sigma**2)) + c
        def abs_sin(x, a, x0, c):
            return a * np.abs(np.sin(np.radians(x - x0) / 2)) + c
        def sin_sq(x, a, x0, c):
            return a * (np.sin(np.radians(x - x0) / 2))**2 + c
        # exception handling for fits
        try:
            x0_guess = angles_sorted[np.argmin(norms_sorted)]
            c_guess = np.min(norms_sorted)
            a_guess = np.max(norms_sorted) - c_guess
            p0 = [a_guess, x0_guess, c_guess]
            popt, pcov = curve_fit(abs_sin, angles_sorted, norms_sorted, p0=p0)
            fit_err = np.sqrt(np.diag(pcov))
            if self.debug:
                print(f"Fit params: {popt}")
                print(f"Covariance: {pcov}")
                print(f"Fit error: {fit_err}")
            best_fit_angle = popt[1] % 360
            if best_fit_angle > 180: 
                best_fit_angle -= 360
            popt[1] = best_fit_angle
            ang_uncert = fit_err[1]
            print(f"Curve fit successful. Best fit angle: {best_fit_angle:.1f}+/-{ang_uncert:.1f} degrees.")
            log_name = f"frobenius_norm_fit_params{self._sanitize_filename(title_tag)}.log"
            log_path = os.path.join(self.plots_dir, log_name)
            with open(log_path, 'w') as l:
                log_str = f"{title_tag} Best fit angle: {best_fit_angle}+/-{ang_uncert} degrees.\nFit params: {popt}\nCovariance: {pcov}\nFit error: {fit_err}"
                l.write(log_str)
        except Exception as e:
            print("Curve fit failed:", e)
            best_fit_angle = angles_sorted[np.argmin(norms_sorted)]
            popt = None
            pcov = None
        plt.figure(figsize=(10, 6))
        plt.plot(angles_sorted, norms_sorted, 'ko', label="Frobenius Norm Data")
        if popt is not None:
            x_fit = np.linspace(min(angles_sorted), max(angles_sorted), 500)
            plt.plot(x_fit, abs_sin(x_fit, *popt), 'r-', label=rf"Best Fit: $x_0={best_fit_angle:.1f}\pm{ang_uncert:.1f}^\circ$")
        plt.xlabel(r"Azimuthal Angle ($^\circ$)")
        plt.ylabel(r"Frobenius Norm $|| \mathrm{Data} - \mathrm{Fiducial} ||_F$")
        plt.grid(True, linestyle='--', alpha=0.6)
        plt.legend()
        out_name = f"frobenius_norm_{title_tag}.pdf"
        out_path = os.path.join(self.plots_dir, out_name)
        plt.savefig(out_path, bbox_inches='tight')
        plt.close()
        print(f"Saved Frobenius plot to {out_path}")

if __name__ == "__main__":
    analyzer = NuLatDirectionalAnalyzer()
    
    print("\n--- NuLat Directionality Analyzer ---")
    print("1) Extract from ROOT file (via uproot)")
    print("2) Load from JSON Binning Matrix")
    print("3) Generate Mock Data")
    print("0) Exit")
    choice = input("Select an option: ").strip()
    matrix_dict = None
    title_tag = ""
    json_save_path = ""

    if choice == '1':
        default_file = "/home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/output/validation/nulat_validation_test_2.ntuple.root"
        file_path = input(f"Enter path to ROOT file\n[default: {default_file}]: ").strip()
        if not file_path:
            file_path = default_file
            
        if not os.path.exists(file_path):
            print("File not found.")
            sys.exit(1)
        df = analyzer.extract_root_data(file_path)
        if df is not None:
            matrix_dict = analyzer.binEvents(df)
            title_tag = "Extracted ROOT Data"
            json_save_path = os.path.join(analyzer.matrices_dir, "extracted_root_data.json")

    elif choice == '2':
        default_json = os.path.join(analyzer.matrices_dir, "validation_data_2_bin_matrix.json")
        file_path = input(f"Enter path to JSON matrix\n[default: {default_json}]: ").strip()
        if not file_path:
            file_path = default_json
        if os.path.exists(file_path):
            with open(file_path, 'r') as f:
                matrix_dict = json.load(f)
            title_tag = "Loaded JSON Data"
        else:
            print("File not found.")
            sys.exit(1)

    elif choice == '3':
        ang_input = input("\nEnter target angle in degrees (integer only) for mock data [default: 45]: ").strip()
        angle = int(ang_input) if ang_input else 45
        matrix_dict, angle = analyzer.generate_mock_data(true_angle=angle)
        title_tag = rf"Mock Data ($\theta={angle}^\circ$)"

    elif choice == '0':
        print("Exiting...")
        sys.exit(0)
    else:
        print("Invalid option selected.")
        sys.exit(1)

    # Execute final plotting if matrix was created
    if matrix_dict is not None:
        if json_save_path:
            with open(json_save_path, 'w') as f:
                json.dump(matrix_dict, f, indent=4)
            print(f"Matrix successfully saved to {json_save_path}")
        print(f"\n--- Running Plot Analysis ---")
        raw_matrix = analyzer.convert_dict_to_matrix(matrix_dict)
        matrix_filename = f"binning_matrix_{analyzer._sanitize_filename(title_tag)}.pdf"
        if analyzer.debug:
            print(f"Sanitized filename: {matrix_filename}")
        analyzer.plot_binning_matrix(raw_matrix, matrix_filename, f"Binning Matrix - {title_tag}")
        analyzer.run_frobenius_analysis(matrix_dict, title_tag)
        print("\nWorkflow complete! Check the plots/ directory.")
