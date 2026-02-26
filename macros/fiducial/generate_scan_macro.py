import math
import os

def generate_macro():
    # --- Configuration ---
    start_angle = 0
    end_angle = 359   # Inclusive (0 to 359)
    step_size = 1
    events_per_angle = 10000
    
    # Paths (Update these to your actual paths)
    base_macro_dir = "/home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/macros/fiducial"
    base_output_dir = "/home/jack/RATPAC2/ratpac-setup/ratpac/NuLat/output/fiducial"
    
    # Local NuLat Paths for manual loading
    # (Since env vars RATDB/RATSHARE might be tricky, we hardcode absolute paths for safety)
    nulat_home = "/home/jack/RATPAC2/ratpac-setup/ratpac/NuLat"
    db_file_materials = os.path.join(nulat_home, "ratdb/MATERIALS_NULAT.ratdb")
    db_file_pmt = os.path.join(nulat_home, "ratdb/PMT_NULAT.ratdb")
    geo_file = os.path.join(nulat_home, "data/NULAT5x5x5_instrumented_Li6.geo")
    
    # Ensure output directories exist
    if not os.path.exists(base_output_dir):
        os.makedirs(base_output_dir)
        print(f"Created directory: {base_output_dir}")

    # Name of the master shell script
    shell_script_name = "generate_reference_set.sh"
    shell_script_path = os.path.join(base_output_dir, shell_script_name)
    
    print(f"Generating macros in: {base_macro_dir}")
    print(f"Generating shell script: {shell_script_path}")
    
    # Open the shell script for writing
    with open(shell_script_path, "w") as shell:
        shell.write("#!/bin/bash\n")
        shell.write("# Master script to run full angular scan sequentially\n")
        shell.write(f"# Output Directory: {base_output_dir}\n")
        # Source the setup script to ensure 'nulat' alias works -- not necessary if sourced prior to running shell
        #shell.write(f"source {nulat_home}/setup_nulat.sh\n\n")
        shell.write(f"# WARNING: User must run \"source {nulat_home}/setup_nulat.sh\" prior to executing this script.")

        # Loop through angles
        for angle_deg in range(start_angle, end_angle + 1, step_size):
            # Define the filename and full path for the macro
            macro_filename = f"angle_{angle_deg}.mac"
            macro_full_path = os.path.join(base_macro_dir, macro_filename)
            
            # Write the individual macro file
            with open(macro_full_path, "w") as f:
                f.write(f"# --- Macro for Angle {angle_deg} degrees ---\n")
                
                # 1. Setup - Explicitly load DBs and Geometry
                f.write("/glg4debug/glg4param omit_muon_processes  1.0\n")
                f.write("/glg4debug/glg4param omit_hadronic_processes  1.0\n")
                
                # Manual DB Loading
                f.write(f"/rat/db/load {db_file_materials}\n")
                f.write(f"/rat/db/load {db_file_pmt}\n")
                
                f.write("/rat/db/set DETECTOR experiment \"NuLat\"\n")
                f.write(f"/rat/db/set DETECTOR geo_file \"{geo_file}\"\n")
                
                f.write("/tracking/storeTrajectory 1\n")
                f.write("/rat/proc prune\n")
                f.write("/rat/procset prune \"mc.track:opticalphoton\"\n")
                
                f.write("/run/initialize\n\n")
                
                # 2. Output
                f.write("/rat/proc count\n")
                f.write("/rat/procset update 1000\n")
                
                # Output filename (matches angle)
                # We write directly to the target output directory to avoid moving files later
                out_root = os.path.join(base_output_dir, f"nulat_output_angle_{angle_deg}.root")
                f.write("/rat/proc outroot\n")
                f.write(f"/rat/procset file \"{out_root}\"\n")
                
                f.write("/rat/proc outntuple\n")
                f.write("/rat/procset include_tracking 1\n")
                f.write("/rat/procset include_mcparticles 1\n")
                f.write("/rat/procset include_pmthits 1\n")
                f.write("/rat/procset include_untriggered_events 1\n\n")
                
                # 3. Generator Setup
                f.write("/generator/add combo ibd:regexfill:poisson\n")
                f.write("/generator/ibd/spectrum default\n")
                f.write("/generator/pos/set cube*\n")
                f.write("/generator/rate/set 0.0001476\n\n")
                
                # 4. Geometry/Vertex Calculation
                angle_rad = math.radians(angle_deg)
                vx = math.cos(angle_rad)
                vy = math.sin(angle_rad)
                vz = 0.0
                
                f.write(f"/control/echo Running angle {angle_deg} degrees...\n")
                f.write(f"/generator/vtx/set {vx:.6f} {vy:.6f} {vz:.6f}\n")
                f.write(f"/run/beamOn {events_per_angle}\n")
            
            # Add command to shell script
            shell.write(f"echo 'Starting run for angle {angle_deg}...'\n")
            # Use 'nulat' command (user must have alias or path set)
            # We use the full path to the macro
            shell.write(f"$NULAT_EXE -o nulat_output_angle_{angle_deg} -l nulat_output_angle_{angle_deg}.log -m {macro_full_path}\n")
            shell.write("\n")
        
        shell.write("echo 'Reference set generation complete.'\n")

    print(f"Generation complete.")
    print(f"1. Check macros in: {base_macro_dir}")
    print(f"2. Go to output directory: cd {base_output_dir}")
    print(f"3. Run the script: bash {shell_script_name}")

if __name__ == "__main__":
    generate_macro()
