// conditional statement for defining class only once
#ifndef NULATDETECTORCONSTRUCTION_HH
#define NULATDETECTORCONSTRUCTION_HH
// Header files for defining volumes
#include "G4VUserDetectorConstruction.hh"
#include "G4VPhysicalVolume.hh"
#include "G4LogicalVolume.hh"
// Nist manager and units for material properties
#include "G4NistManager.hh"
#include "G4SystemOfUnits.hh"
// Header files for placements
#include "G4PVPlacement.hh"
#include "G4PVParameterised.hh"
// Header files for geometry types
#include "G4Box.hh"
#include "G4Cons.hh"
#include "G4Orb.hh"
#include "G4Sphere.hh"
#include "G4Trd.hh"
#include "G4Tubs.hh"
#include "G4IntersectionSolid.hh"
#include "G4SubtractionSolid.hh"
// Header files for sensitive detector
#include "G4VSensitiveDetector.hh"
#include "G4SDManager.hh"
// Header files for surfaces
#include "G4OpticalSurface.hh"
#include "G4LogicalSkinSurface.hh"
// Header file for messenger control
#include "G4GenericMessenger.hh"
// Header files for visual attribute manager
#include "G4VisAttributes.hh"
#include "G4Colour.hh"
// Header file for user defined libraries
//#include "NuLatPMTsensDet.hh"
//#include "NuLatVoxelSensDet.hh"
// Write the class
class NuLatDetectorConstruction : public G4VUserDetectorConstruction
{
public:
	NuLatDetectorConstruction();
	~NuLatDetectorConstruction();
	// method for looking up scoring volume
	// TODO: ?
	G4LogicalVolume *GetNuLatScoringVolume() const { return fNuLatScoringVolume; }
	// construct function for detector factory
	virtual G4VPhysicalVolume* Construct();
private:
	// Volume declarations - naming convention: solidName for geometry volume definitions, logicName for logical volume definitions and physName for physical volume definitions
	G4Box *solidWorld;
	G4LogicalVolume *logicWorld, *fNuLatScoringVolume;
	G4VPhysicalVolume *physWorld;
	// Material declarations
	G4Element *H, *Be, *C, *O, *Si, *Cr, *Fe, *Ni, *Cu, *Mo, *Pb;
	G4Material *air;
	G4MaterialPropertiesTable *mptAir;
	// useful constants:
	// physical constant for computing photon energies or wavelengths: (note - divide by wavelength in nm to get energy in eV, or divide by energy in eV to get wavelength in nm)
	const G4double HCNM = 1239.841939*eV;
	// conversion factor inches to mm
	const G4double in = 25.4*mm;
	// variable declarations
	// World volume size in x, y and z dimensions
	G4double xWorld, yWorld, zWorld;
	// NuLat Detector Parameters (number of voxels in x, y and z dimensions, length in each dimension, gap size in each dimension
	G4int xVoxels, yVoxels, zVoxels;
	G4double xVoxelSize, yVoxelSize, zVoxelSize;
	G4double xVoxelSpace, yVoxelSpace, zVoxelSpace;
	// function declarations
	void DefineMaterials();
	//virtual void ConstructSDandField();
	// Pointers for SD's: (uncomment when supporting classes are written)
	//NuLatPMTSensitiveDetector *detPMT;
	//NuLatVoxelSensitiveDetector *detVoxel;
	// Pointer to Generic Messenger Object
	G4GenericMessenger *fMessenger;
	// Pointer to Visual Attribute manager object
	G4VisAttributes *attr;
};
// end of conditional for defining class only once
#endif
