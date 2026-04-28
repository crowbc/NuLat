import os
import sys
import time as timer
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import uproot
import awkward as ak

class NuLatGammaAnalyzer:
    """
    Analyzes NuLat directionality using interactive menus. Features Root extraction natively via uproot
    """
    def __init__(self):
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
        self.plots_dir = os.path.join(self.base_dir, "plots")
        os.makedirs(self.plots_dir, exist_ok=True)

        # --- Detector Geometry ---
        self.inch = 25.4
        self.cube_size = 2.5 * self.inch      # 63.5 mm
        self.gap_size = 0.001 * self.inch     # 0.0254 mm
        self.step_size = self.cube_size + self.gap_size
        self.grid_dim = 5

        return

    def process_gamma_simulation(self, file_path):
        """Loads root file and constructs step-by-step energy deposition."""
        print(f"\nLoading ROOT file via uproot: {file_path}")
        try:
            tree = uproot.open(f"{file_path}:output")
            print("Successfully located TTree: 'output'")
        except Exception as e:
            print(f"Error opening tree 'output': {e}")
            return None

        branches = [
            'trackPDG', 'trackProcess', 'mcx', 'mcy', 'mcz', 
            'trackPosX', 'trackPosY', 'trackPosZ', 'trackTime', 'trackKE'
        ]
        # Calculate detector boundary
        total_span = self.grid_dim * self.step_size - self.gap_size
        det_half_width = total_span / 2.0
        chunk_counter = 1
        valid_event_energies = []

        print("Extracting arrays into Pandas DataFrame (this may take a moment)...")
        if self.debug:
            time_start = timer.time()
        try:
            # uproot.iterate automatically chunks by entries (Events), so tracks are never split between chunks!
            for ak_arrays in uproot.iterate(f"{file_path}:output", branches, step_size="100 MB"):
                print(f"  -> Processing chunk {chunk_counter}...")
                df = ak.to_dataframe(ak_arrays).reset_index()
                if 'entry' in df.columns:
                    df = df.rename(columns={'entry': 'Row'})
                # 1. EARLY FILTER: Keep ONLY gammas (PDG == 22)
                df = df[df['trackPDG'] == 22].copy()
                if df.empty:
                    chunk_counter += 1
                    continue
                # 2. Flag steps inside the detector bounding box
                df['in_det'] = (df['trackPosX'].abs() <= det_half_width) & \
                               (df['trackPosY'].abs() <= det_half_width) & \
                               (df['trackPosZ'].abs() <= det_half_width)
                # 3. SECOND EARLY FILTER: Drop tracks that NEVER enter the detector
                entered_tracks = df.groupby(['Row', 'subentry'])['in_det'].transform('any')
                df = df[entered_tracks].copy()
                if df.empty:
                    chunk_counter += 1
                    continue
                # 4. Calculate Energy Deposition (edep)
                idx_cols = [col for col in ['Row', 'subentry', 'subsubentry'] if col in df.columns]
                df = df.sort_values(by=idx_cols)
                df['KE_prev'] = df.groupby(['Row', 'subentry'])['trackKE'].shift(1)
                df['edep'] = df['KE_prev'] - df['trackKE']
                df['edep'] = df['edep'].fillna(0).clip(lower=0)
                # 5. Map spatial coordinates to Voxels
                df['vx'] = np.floor((df['trackPosX'] + det_half_width) / self.step_size).astype(int)
                df['vy'] = np.floor((df['trackPosY'] + det_half_width) / self.step_size).astype(int)
                df['vz'] = np.floor((df['trackPosZ'] + det_half_width) / self.step_size).astype(int)
                # 6. Filter for active scatters (energy deposited INSIDE the detector)
                df_hit = df[df['in_det'] & (df['edep'] > 0)].copy()
                if df_hit.empty:
                    chunk_counter += 1
                    continue
                # Sum the energy per distinct voxel per event
                voxel_edep = df_hit.groupby(['Row', 'vx', 'vy', 'vz'])['edep'].sum().reset_index()
                # 7. Apply the Topology Filter (>= 2 distinct voxel hits)
                scatters_per_event = voxel_edep.groupby('Row').size()
                valid_events = scatters_per_event[scatters_per_event >= 2].index
                # 8. Append valid event energies to our master list
                if len(valid_events) > 0:
                    chunk_energies = voxel_edep[voxel_edep['Row'].isin(valid_events)].groupby('Row')['edep'].sum()
                    valid_event_energies.extend(chunk_energies.tolist())
                chunk_counter += 1
                if self.debug:
                    print(f"DataFrame shape: {df.shape}")
                    print(f"Sample rows:\n{df.head(15)}")
                    print(f"Extraction successful! Loaded {len(df)} total track steps.")
        except Exception as e:
            print(f"Error extracting branches: {e}")
            return        
        if not valid_event_energies:
            print("No valid events found. Exiting.")
            return
        print(f"\nSUCCESS: Found {len(valid_event_energies)} events matching the 2-scatter criteria.")
        if self.debug:
            time_to_extract = timer.time() - time_start
            total_running_time = timer.time() - self.init_time
            print(f"Time to extract ROOT file: {time_to_extract:.3f}s")
            print(f"Total running time at end of extraction: {total_running_time:.3f}s")
        # --- Plotting ---
        num_evts = len(valid_event_energies)
        print(f"Generating Energy Spectrum Plot for {num_evts}...")
        plt.figure(figsize=(10, 6))
        plt.hist(valid_event_energies, bins=150, range=(0, 2.0), color='steelblue', edgecolor='black', alpha=0.7, label='Gamma spectrum')
        plt.xlabel(r'Total Deposited Gamma Energy (MeV), filtered for at least 2 scatters')
        plt.ylabel(r'Counts')
        #plt.yscale('log')
        plt.grid(True, alpha=0.3)
        #plt.legend()
        plt.tight_layout()
        output_fname = 'na22_filtered_spectrum.pdf'
        plt.savefig(output_fname)
        plt.show()
        print(f"Done! Spectrum saved to '{output_fname}'")
        return

if __name__ == "__main__":
    analyzer = NuLatGammaAnalyzer()
    FILE_PATH = os.path.join(analyzer.base_dir,"sodium_22_decay_test_001.ntuple.root")
    analyzer.process_gamma_simulation(FILE_PATH)
