# Ratpac 2 NuLat Simulation

## Description

This is a simulation of the 5 by 5 by 5 NuLat demonstrator detector using the RATPAC2 
framework. Some analysis scripts are included for validation of the detector simulation. 
This repository was cloned from the [RatpacExperiment](https://github.com/rat-pac/RatpacExperiment) repository found on GitHub and 
modified to create a simulation for the NuLat experiment.

## Usage

### Prerequisites

- RATPAC2 must be installed to use this simulation. Follow the instructions [here](https://github.com/rat-pac/ratpac-two/tree/main) to install RATPAC2.
- Once RATPAC2 is installed and configured on your system, clone this repository in your RATPAC2 installation directory.

### Setup and Running the Simulation

1. Once this repository is cloned in your RATPAC2 installation directory, note the installation path for it. You will need to modify your scripts to use this path.
2. Modify the `setup_nulat.sh` script in your current working directory. If you installed RATPAC2 in the default location, the line under the first comment should be changed to `source /home/your_username/RATPAC2/ratpac-setup/env.sh`. The Python script in the `macros/fiducial/` subdirectory will also need to be modified. It will be helpful to use a search and replace feature in your text editor of choice to change `jack` to `your_username` in this file. The analysis scripts in `output/analysis/`, `output/gamma_test/`, and `output/validation/` subdirectories use `os.getcwd()` commands to identify directories. Therefore, they will not need to be similarly modified.
3. Run the executable `setup_nulat.sh` script from your command line.
4. *Optional* To keep data files organized, it may be helpful to change your working directory to the `output/` subdirectory or even make a subdirectory therein and change to that directory.
5. *Optional* Prior to executing a production simulation, it may be helpful to verify detector geometry and behavior performs as desired by running the simulation in visual mode. The `output/vis_test/` subdirectory exists for this purpose. To run, type `nulat --vis -m <your_path_to_NuLat>/macros/vis_qt_nulat.mac (optional) -l log_file_name.log (optional) -o output_file_name`.
6. Run the simulation in batch mode with your desired macro file to generate the desired number of events and event types. Information on writing macros can be found in the [RATPAC2 documentation](https://ratpac.readthedocs.io/en/latest/users_guide/command_interface.html#controlling-ratpac-two-via-macro-files).
7. Several sample analysis code scripts have been included in this simulation and can be found in the `output/analysis`, `output/gamma_test/`, and `output/validation` subdirectories. To use the directional analysis, it will be necessary to generate a fiducial data set for each reference angle first. This can be done by following the for instructions below to generate a fiducial set.

### Generating a Fiducial Matrix Data Set
1. Change your current working directory to the `macros/fiducial` subdirectory.
2. Use your text editor of choice to change or verify the parameters in `generate_scan_macro.py` prior to running. The default number of events per angle is 10000, and the default angle increment is 1 degree.
3. Run the `generate_scan_macro.py` script by typing `python3 generate_scan_macro.py` in the command prompt. This script does not take parameters.
4. The necessary path to run the simulation `output/fiducial` should be created along with the scan macros. Verify that the needed macros now exist in the `macros/fiducial/` subdirectory and that the `output/fiducial` subdirectory contains the `generate_reference_set.sh` script.
5. Change the current working directory to `output/fiducial` and run the `generate_reference_set.sh` script. This will sequentially execute the simulations for each reference angle and name the output and log files appropriately.
6. When the batch execution of the simulations is complete, run the `createNuLatFiducialSet.py` script to generate the reference binning matrices for all the angles for directional analysis. These will be stored in the current working directory by default.

___ 

# Version History

### Current Version

13AUG2026 -- v. 1.3.2: Hotfix 6.  

*Minor Fixes*:  
- Changed `setup_nulat.sh` to executable permission.
- Added setup and usage requirements to `readme.md`.
- Added usage instructions to `readme.md`.
- Added `/macros/angle_*.mac` files to `.gitignore` to remove problematic path naming from scripts. See instructions on generating a fiducial set for details on usage of included scripts.
**Updates**:
- Removed local uproot virtual environment path located in `output/analysis/nulat_env/` and moved the uproot installation to a general virtual environment. See Python documentation in your local `path/to/python/pythonx.yy/README.venv` where `path/to/python/` is your local installation directory and `pythonx.yy` is the version you have installed. You can also attempt to install uproot using `pip install uproot` and follow the instructions on the system message it produces. **Note**: Older Python builds (earlier than 3.3) may still process `pip install foo` commands to install `python foo` package. **Note**: User can configure a virtual environment to run all required packages. See Python 3.xx documentation for details.
- Added `nulat_env.sh` script to base directory to setup the required Python environment to run the `nulatDirectionalAnalyzer.py` script in the `output/analysis/` subdirectory. Also added command `source nulat_env.sh` to the `setup_nulat.sh` shell script.
- Changed `generate_reference_set.sh` to use `os.getcwd()` command and modify `readme.md` instructions to eliminate the need for user to rewrite the script to point to the correct path.
**TODO**
- Add `requirements.txt` for loading the required virtual environment to execute the `nulatDirectionalAnalyzer.py` script. This is machine-specific and will not work in someone else's environment so add it to .gitignore.

### Previous Versions

08MAY2026 -- v. 1.3.1: Hotfix 5.  

*Minor Fixes*:  
- Corrected markdown language syntax in `readme.md` file.
- Corrected text in `readme.md` stating incorrect binning matrix size.  

27APR2026 -- v. 1.3.0: Sodium-22 Simulation.  

- Added sodium-22 decay simulation macro and gamma energy analysis script.  

31MAR2026 -- v. 1.2.1: Hotfix 4.  

- Added blinded study analysis method to `nulatDirectionalAnalyzer.py`. Added 
a macro generator for a multi-run blind directionality study and the macro 
files it created.
- Added an unblinding analysis script.  

20MAR2026 -- v. 1.2.0: Fiducial Set Creator and Directional Analyzer.  

- Added `createNuLatFiducialSet.py` to create directional binning matrices for 
angles 0 through 359 degrees by binning the separation between prompt and 
delayed vertices in a 5 x 5 matrix.
- Output fiducial matrices to `nulat_fiducial_directionality_set.json` 
Validation Analysis Script (`validate_nulat_physics.py`) script updates: 
Corrected the energy deposition calculation for gammas originating outside 
the detector.
- Added a method for determining if a vertex is inside the detector. 
Corrected the method for counting unfiltered gamma scatters and other 
particle events.
- Added `nulatDirectionalAnalyzer.py` for directional reconstruction using 
energy deposition calculation as a proxy for energy and vertex 
reconstruction. Options to use previously calculated binning matrices from 
JSON files included in the script.  
                      
25FEB2026 -- v. 1.1.1: Hotfix 3.  

- Added an energy deposition calculation for gammas originating outside 
the detector to the validation script.  
*Note*: This calculation does not add the energy of gammas known to come  
from background sources in `validation_test_1` data. Further corrections  
are necessary to the energy deposition logic.
- Additional plots added to the validation script, and statistical summary  
ordering now reflects whether the plots and statistics are for filtered  
or unfiltered data.
- Added directional analysis fiducial data set generation macros located in  
the `macros/fiducial` subdirectory.  

09FEB2026 -- v. 1.1.0: Energy depositions.  

- Added logic for analysis of energy depositions in MC tracks to 
validation script.  
*Note*: this logic needs refinement.  
- Added shell script for customized RATPAC2 environment for the 
NuLat experiment.  
*Note*: this requires using absolute paths in macro files.  

03FEB2026 -- v. 1.0.2: Hotfix 2.  

- Added missing logic for alpha and triton tracks analysis to 
validation script.
- Added a configuration subroutine to scan for ROOT files and set Boolean 
flags for shielding and doping to validation script.  

30JAN2026 -- v. 1.0.1: Hotfix 1.  

- Added Li-6 dopant definition to `MATERIALS_NULAT.ratdb`.
- Added path support to data validation analysis script 
(`output/validation/validate_nulat_physics.py`)
- Added alpha and triton tracks analysis to validation script.
- Updated gamma tracking to monitor for accidentals from shielding-captured  
gammas.

### First Commit

28JAN2026 -- v. 1.0.0: Initial commit.  

- Detector geometry uses the script found in the `ratdb/` subdirectory. 
- Segmented detector factory class is implemented and overridden for 
creation of detector geometry using the `RAT::DetectorFactory()` method.
