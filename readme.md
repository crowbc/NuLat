# Ratpac 2 NuLat Simulation

This is a simulation of the 5 by 5 by 5 NuLat demonstrator detector using the RATPAC2
framework. Some analysis scripts are included for validation of the detector simulation.
This repository was cloned from the RatpacExperiment repository found at 
https://github.com/rat-pac/RatpacExperiment and modified to create the NuLat experiment. 

# version history
27APR2026 -- v 1.3.0: Sodium-22 Simulation.
                      Added sodium-22 decay simulation macro and gamma energy analysis script.

31MAR2026 -- v 1.2.1: Hotfix 4.
                      Added blinded study analysis method to nulatDirectionalAnalyzer.py. Added a 
                      macro generator for a multi-run blind directionality study and the macro files 
                      it created. Added an unblinding analysis script.

20MAR2026 -- v 1.2.0: Fiducial Set Creator and Directional Analyzer.
                      Added createNuLatFiducialSet.py to create directional binning matrices for
                      angles 0 through 359 degrees by binning the separation between prompt and 
                      delayed vertices in a 2 x 2 matrix.
                      Output fiducial matrices to nulat_fiducial_directionality_set.json
                      Validation Analysis Script (validate_nulat_physics.py) script updates:
                      Corrected the energy deposition calculation for gammas originating outside 
                      the detector.
                      Added a method for determining if a vertex is inside the detector. 
                      Corrected the method for counting unfiltered gamma scatters and other 
                      particle events.
                      Added nulatDirectionalAnalyzer.py for directional reconstruction using 
                      energy deposition calculation as a proxy for energy and vertex 
                      reconstruction. Options to use previously calculated binning matrices from
                      JSON files included in the script.
                      --------------------------------------------------------------------------
                      
25FEB2026 -- v 1.1.1: Hotfix 3.
                      Added an energy deposition calculation for gammas originating outside
                      the detector to the validation script. 
                      Note: This calculation does not add the energy of gammas known to come 
                      from background sources in validation_test_1 data. Further corrections 
                      are necessary to the energy deposition logic. 
                      Additional plots added to the validation script, and statistical summary 
                      ordering now reflects whether the plots and statistics are for filtered 
                      or unfiltered data. 
                      Added directional analysis fiducial data set generation macros located in 
                      the macros/fiducial subdirectory.
                      --------------------------------------------------------------------------

09FEB2026 -- v 1.1.0: Energy depositions.
                      Added logic for analysis of energy depositions in MC tracks to
                      validation script. Note: this logic needs refinement.
                      Added shell script for customized RATPAC2 environment for the
                      NuLat experiment. Note: this requires using absolute paths in macro files.
                      --------------------------------------------------------------------------

03FEB2026 -- v 1.0.2: Hotfix 2.
                      Added missing logic for alpha and triton tracks analysis to
                      validation script.
                      Added a configuration subroutine to scan for ROOT files and set Boolean 
                      flags for shielding and doping to validation script.
                      --------------------------------------------------------------------------

30JAN2026 -- v 1.0.1: Hotfix 1.
                      Added Li-6 dopant definition to MATERIALS_NULAT.ratdb.
                      Added path support to data validation analysis script (output/
                      validation/validate_nulat_physics.py)
                      Added alpha and triton tracks analysis to validation script.
                      Updated gamma tracking to monitor for accidentals from shielding-captured 
                      gammas.
                      --------------------------------------------------------------------------

28JAN2026 -- v 1.0.0: Initial commit. 
                      Detector geometry uses the script found in the ratdb/ subdirectory.
                      Segmented detector factory class is implemented and overridden for 
                      creation of detector geometry using the RAT::DetectorFactory() method.
