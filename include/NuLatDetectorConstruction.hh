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
#include "NuLatPMTsensitiveDetector.hh"
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
	G4Box *solidWorld, *solidVCBox, *solidVoxel, *solidAcrylicBoxOuter, *solidAcrylicBoxInner, *solidLGBox/*, *solidSSPlate/**/;
	G4Trd *solidLGTrd;
	G4Tubs *solidPMT;
	G4Cons *solidLGCone;
	G4SubtractionSolid *solidAcrylicBox;
	G4IntersectionSolid *solidLG;
	G4LogicalVolume *logicWorld, *logicVCBox, *logicVoxel, *fNuLatScoringVolume, *logicAcrylicBox, *logicLGBox, *logicLG, *logicPMT/*, *logicSSPanel/**/;
	G4VPhysicalVolume *physWorld, *physVCBox, *physVoxel, *physAcrylicBox, *physLGBox, *physLG, *physPMT/*, *physSSPanel/**/;
	// Declare optical surfaces
	G4OpticalSurface *surface_Al, *surface_SS;
	// Material declarations
	G4Element *H, *Be, *C, *O, *Si, *Cr, *Fe, *Ni, *Cu, *Mo, *Pb;
	G4Material *air, *acrylic, *EJ200, *aluminum, *stainless, *lead;
	G4MaterialPropertiesTable *mpt_air, *mpt_EJ200, *mpt_acrylic, *mpt_Al, *mpt_SS;
	// useful constants:
	// physical constant for computing photon energies or wavelengths: (note - divide by wavelength in nm to get energy in eV, or divide by energy in eV to get wavelength in nm)
	const G4double HCNM = 1239.841939*eV*nm;
	// conversion factor inches to mm
	const G4double in = 25.4*mm;
	// amu in SI:
	const G4double uu = 1.66054E-27*kg;
	// mass of H and C atoms in amu
	const G4double Cmass = 12.011*uu;
	const G4double Hmass = 1.0079*uu;
	// Constants for material properties:
	// air
	const G4double rindexConst_air = 1.0;
	// EJ200 - scintillation yield, decay time, rise time, peak emission wavelength (in nm) and full width half maximum:
	const G4double scyld_EJ200 = 10000./MeV;
	const G4double dt_EJ200 = 2.1*ns;
	const G4double rt_EJ200 = 0.9*ns;
	const G4double wlmax_EJ200 = 425*nm;
	const G4double fwhm_EJ200 = 2.5*ns;
	// EJ200 light attenuation length, refractive index, C atom number density, H atom number density and electon number density:
	const G4double aLenConst_EJ200 = 380.*cm;
	const G4double rindexConst_EJ200 = 1.58;
	const G4double nH_EJ200 = 5.17E22/cm3;
	const G4double nC_EJ200 = 4.69E22/cm3;
	const G4double ne_EJ200 = 3.33E22/cm3;
	const G4double rho_EJ200 = 1.023*g/cm3;
	// Acrylic material properties
	const G4double rho_acrylic = 1.180*g/cm3;
	const G4double rindexConst_acrylic = 1.492;
	const G4double aLenConst_acrylic = 10.*m;
	// Reflective surface properties
	const G4double refConst_Al = 0.95;
	const G4double refConst_SS = 1.0;
	// variable declarations
	// World volume size in x, y and z dimensions
	G4double xWorld, yWorld, zWorld;
	// NuLat Detector Parameters (number of voxels in x, y and z dimensions, length in each dimension, gap size in each dimension
	G4int xVoxels, yVoxels, zVoxels;
	G4double xVoxelSize, yVoxelSize, zVoxelSize;
	G4double xVoxelSpace, yVoxelSpace, zVoxelSpace;
	G4double xVCBoxSize, yVCBoxSize, zVCBoxSize;
	G4double tAcrylicPanel, lenPMT, lenLGTaper, lenLGSqu, lenLGwPMT;
	// Mass fraction of C and H in EJ200
	G4double totalMass_EJ200 = Cmass*nC_EJ200 + Hmass*nH_EJ200;// mass per cc
	G4double Cfrac_EJ200 = nC_EJ200*Cmass/totalMass_EJ200;
	G4double Hfrac_EJ200 = nH_EJ200*Hmass/totalMass_EJ200;
	// function declarations
	void DefineMaterials();
	void BuildVCBox();
	void BuildAcrylicBox();
	void BuildLGandPMT();
	virtual void ConstructSDandField();
	// Pointers for SD's: (uncomment when supporting classes are written)
	NuLatPMTSensitiveDetector *detPMT;
	//NuLatVoxelSensitiveDetector *detVoxel;
	// Pointer to Generic Messenger Object
	G4GenericMessenger *fMessenger;
	// Pointer to Visual Attribute manager object
	G4VisAttributes *attr;
};
// end of conditional for defining class only once
#endif
