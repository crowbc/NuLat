import random
import os
import csv
import numpy as np

def generate_blind_study(num_datasets=5, events=10000):
    """
    Generates simulation macros with random angles and creates a secret vault.
    """
    vault_file = "secret_truth_vault.csv"
    macro_dir = "blind_macros"
    os.makedirs(macro_dir, exist_ok=True)
    
    # Initialize the vault (if it doesn't exist)
    if not os.path.exists(vault_file):
        with open(vault_file, mode='w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["Dataset_ID", "True_Angle_Deg"])

    print(f"Generating {num_datasets} blind datasets...")
    
    with open(vault_file, mode='a', newline='') as file:
        writer = csv.writer(file)
        
        for i in range(1, num_datasets + 1):
            dataset_id = f"blind_set_{i:03d}"
            
            # Pick a random integer angle (or use random.uniform(0, 360) for floats)
            true_angle = random.randint(0, 359)
            x_mom = np.cos(np.radians(true_angle))
            y_mom = np.sin(np.radians(true_angle))
            
            # 1. Save to the vault
            writer.writerow([dataset_id, true_angle])
            
            # 2. Generate the Macro
            macro_filename = os.path.join(macro_dir, f"{dataset_id}.mac")
            with open(macro_filename, 'w') as mac:
                mac.write("/glg4debug/glg4param omit_muon_processes  1.0\n")
                mac.write("/glg4debug/glg4param omit_hadronic_processes  1.0\n\n")
                mac.write("#set the d parameters\n")
                mac.write("/rat/db/set DETECTOR experiment \"NuLat\"\n")
                mac.write("/rat/db/load /home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/ratdb/MATERIALS_NULAT.ratdb\n")
                mac.write("/rat/db/load /home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/ratdb/PMT_NULAT.ratdb\n")
                mac.write("/rat/db/set DETECTOR geo_file \"/home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/data/NULAT5x5x5_instrumented_Li6.geo\"\n\n")
                mac.write("/tracking/storeTrajectory 1\n")
                mac.write("/rat/proc prune\n")
                mac.write("/rat/procset prune \"mc.track:opticalphoton\"\n\n")
                mac.write("/run/initialize\n\n")
                mac.write(f"/rat/proc count\n\n")
                mac.write(f"/rat/procset update 1000\n\n")
                mac.write("# Use IO.default_output_filename\n")
                mac.write("/rat/proc outroot\n")
                mac.write(f"/rat/procset file \"{dataset_id}.root\"\n")
                mac.write("## OUTPUT PYTHON-LIKE FORMAT\n")
                mac.write("/rat/proc outntuple\n")
                mac.write("/rat/procset include_tracking 1\n")
                mac.write("/rat/procset include_mcparticles 1\n")
                mac.write("/rat/procset include_pmthits 1\n")
                mac.write("/rat/procset include_untriggered_events 1\n\n")
                mac.write("##### GENERATORS #################\n")
                mac.write("/generator/add combo ibd:regexfill:poisson\n")
                mac.write("/generator/ibd/spectrum default\n")
                mac.write(f"/generator/vtx/set {x_mom:.4f} {y_mom:.4f} 0\n")
                mac.write("/generator/pos/set cube*\n")
                mac.write("/generator/rate/set 0.0001476\n\n")
                mac.write("##### RUN ###########\n")
                mac.write(f"/run/beamOn {events}\n\n")
                # ---------------------------------------------------------
            
    print(f"Done! {num_datasets} macros saved to '{macro_dir}/'.")
    print(f"The true angles are locked in '{vault_file}'. DO NOT PEEK!")

if __name__ == "__main__":
    # Generate 30 blind datasets, 10000 events each
    generate_blind_study(num_datasets=30, events=10000)
