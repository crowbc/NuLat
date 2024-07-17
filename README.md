# NuLat
This is a Geant4 simulation of a half-instrumented 5x5x5 unlithiated voxel NuLat Detector. The purpose of this simulation is for calibration of each voxel in the unlithiated 5x5x5 array using energy reconstruction. This is also based on the original NuLat simulation which can be found at https://github.com/crowbc/NuLat_archive.git. A previous version can also be found at https://github.com/crowbc/NuLatArchive2.git. All simulations in these repositories are written for Geant4 v11 and are not backwards compatible with older Geant4 builds than v11.0.

# build
Initial build for testing geometry and materials properties, physics of detector medium and supporting components, and PMT's. Build uses v 11.1.0 of Geant4.

Change log (in reverse chronological order starting from most recent version:)
v 1.0.0 -- 17JUL2024
	Initial Commit, created main function for initializing UI or initializing simulation in batch mode. Created physics manager, construction manager, and run manager classes. Created CMakelists file for compiling.
