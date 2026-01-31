# Ratpac 2 NuLat Simulation

This is a simulation of the 5 by 5 by 5 NuLat demonstrator detector using the RATPAC2
framework. Some analysis scripts are included for validation of the detector simulation.
This repository was cloned from the RatpacExperiment repository found at 
https://github.com/rat-pac/RatpacExperiment and modified to create the NuLat experiment. 

# version history
30JAN2026 -- v 1.0.1: Hotfix 1.
                      Added Li-6 dopant definition to MATERIALS_NULAT.ratdb.
                      Added path support to data validation analysis script (output/...
                      ...validation/validate_nulat_physics.py)
                      Added alpha and triton tracks analysis to validation script.
                      Updated gamma tracking to monitor for accidentals from shielding-
                      captured gammas.

28JAN2026 -- v 1.0.0: Initial commit. 
                      Detector geometry uses the script found in the ratdb/ subdirectory.
                      Segmented detector factory class is implemented and overridden for 
                      creation of detector geometry using the RAT::DetectorFactory() method.
