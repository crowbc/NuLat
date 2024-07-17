// Included header files written for simulation
#include "NuLatDetectorConstruction.hh"
// Constructor
NuLatDetectorConstruction::NuLatDetectorConstruction()
{
	xWorld = 1.0*m;
	yWorld = 1.0*m;
	zWorld = 1.0*m;
	// Define Detector Construction Materials
	DefineMaterials();
}
// Destructor
NuLatDetectorConstruction::~NuLatDetectorConstruction()
{}
// DefineMaterials()
void NuLatDetectorConstruction::DefineMaterials()
{
	G4NistManager *nist = G4NistManager::Instance();
	// size_t variable for property array lengths
	const size_t nI = 182;
	// Photon energy range for energy dependent material responses - corresponds to a range of 220 nm to 609 nm
	G4double photonEnergy[nI] = {
		2.034*eV, 2.068*eV, 2.103*eV, 2.139*eV, 2.177*eV, 2.216*eV, 2.256*eV, 2.298*eV, 2.341*eV, 2.386*eV, //10
		2.433*eV, 2.481*eV, 2.487*eV, 2.496*eV, 2.506*eV, 2.516*eV, 2.524*eV, 2.531*eV, 2.539*eV, 2.547*eV, //20
		2.554*eV, 2.561*eV, 2.569*eV, 2.577*eV, 2.586*eV, 2.595*eV, 2.605*eV, 2.614*eV, 2.622*eV, 2.630*eV, //30
		2.638*eV, 2.646*eV, 2.653*eV, 2.660*eV, 2.669*eV, 2.676*eV, 2.681*eV, 2.688*eV, 2.693*eV, 2.698*eV, //40
		2.703*eV, 2.706*eV, 2.711*eV, 2.718*eV, 2.723*eV, 2.731*eV, 2.742*eV, 2.755*eV, 2.768*eV, 2.782*eV, //50
		2.793*eV, 2.803*eV, 2.811*eV, 2.819*eV, 2.829*eV, 2.837*eV, 2.845*eV, 2.853*eV, 2.860*eV, 2.867*eV, //60
		2.875*eV, 2.882*eV, 2.888*eV, 2.894*eV, 2.900*eV, 2.907*eV, 2.913*eV, 2.919*eV, 2.924*eV, 2.930*eV, //70
		2.937*eV, 2.942*eV, 2.948*eV, 2.954*eV, 2.960*eV, 2.968*eV, 2.976*eV, 2.983*eV, 2.991*eV, 3.001*eV, //80
		3.008*eV, 3.017*eV, 3.028*eV, 3.038*eV, 3.048*eV, 3.055*eV, 3.070*eV, 3.087*eV, 3.103*eV, 3.121*eV, //90
		3.138*eV, 3.155*eV, 3.173*eV, 3.191*eV, 3.220*eV, 3.250*eV, 3.281*eV, 3.313*eV, 3.344*eV, 3.375*eV, //100
		3.403*eV, 3.439*eV, 3.479*eV, 3.522*eV, 3.566*eV, 3.611*eV, 3.644*eV, 3.684*eV, 3.731*eV, 3.780*eV, //110
		3.831*eV, 3.868*eV, 3.892*eV, 3.910*eV, 3.921*eV, 3.934*eV, 3.946*eV, 3.957*eV, 3.970*eV, 3.994*eV, //120
		4.044*eV, 4.102*eV, 4.160*eV, 4.202*eV, 4.236*eV, 4.267*eV, 4.298*eV, 4.328*eV, 4.357*eV, 4.387*eV, //130
		4.422*eV, 4.455*eV, 4.494*eV, 4.563*eV, 4.607*eV, 4.616*eV, 4.624*eV, 4.627*eV, 4.628*eV, 4.633*eV, //140
		4.640*eV, 4.642*eV, 4.649*eV, 4.656*eV, 4.661*eV, 4.666*eV, 4.678*eV, 4.685*eV, 4.692*eV, 4.699*eV, //150
		4.706*eV, 4.713*eV, 4.720*eV, 4.727*eV, 4.740*eV, 4.751*eV, 4.763*eV, 4.775*eV, 4.788*eV, 4.798*eV, //160
		4.813*eV, 4.828*eV, 4.840*eV, 4.853*eV, 4.869*eV, 4.886*eV, 4.905*eV, 4.928*eV, 4.953*eV, 5.015*eV, //170
		5.099*eV, 5.143*eV, 5.174*eV, 5.202*eV, 5.235*eV, 5.265*eV, 5.294*eV, 5.330*eV, 5.413*eV, 5.493*eV, //180
		5.556*eV, 5.611*eV}; //182
	// Wavelengths in nm
	G4double wlenNM[nI];
	// Arrays for material properties
	G4double rindexAir[nI];
	// Define Elements
	H = nist->FindOrBuildElement("H");
	Be = nist->FindOrBuildElement("Be");
	C = nist->FindOrBuildElement("C");
	O = nist->FindOrBuildElement("O");
	Si = nist->FindOrBuildElement("Si");
	Cr = nist->FindOrBuildElement("Cr");
	Fe = nist->FindOrBuildElement("Fe");
	Ni = nist->FindOrBuildElement("Ni");
	Cu = nist->FindOrBuildElement("Cu");
	Mo = nist->FindOrBuildElement("Mo");
	Pb = nist->FindOrBuildElement("Pb");
	// Define Materials
	air = nist->FindOrBuildMaterial("G4_AIR");
	// Set Material Properties
	for (size_t i = 0; i<nI; i++){
		// Calculate wavelength (in nm) from photon energy
		wlenNM[i] = HCNM/photonEnergy[i];// Energy is input directly above. Note: energy is displayed as a factor of 1E-06 too small in the G4cout statement!
		rindexAir[i] = 1.;
	}
	// Declare material properties tables and populate with values. Assign tables to materials
	mptAir = new G4MaterialPropertiesTable();
	mptAir->AddProperty("RINDEX", photonEnergy, rindexAir, nI);
	air->SetMaterialPropertiesTable(mptAir);
}
// Detector Construct() function
G4VPhysicalVolume* NuLatDetectorConstruction::Construct()
{
	// Define Visual Attributes object for adjusting coloring and visibility of various components - set to false to make components invisible
	attr = new G4VisAttributes(false);
	// World Volume - min size 1m
	if(xWorld<0.5*m)
	{
		xWorld = 0.5*m;
	}
	if(yWorld<0.5*m)
	{
		yWorld = 0.5*m;
	}
	if(zWorld<0.5*m)
	{
		zWorld = 0.5*m;
	}
	solidWorld = new G4Box("solidWorld", xWorld, yWorld, zWorld);
	logicWorld =  new G4LogicalVolume(solidWorld, air, "logicWorld");
	// make world volume invisible
	logicWorld->SetVisAttributes(attr);
	physWorld = new G4PVPlacement(0, G4ThreeVector(0.,0.,0.), logicWorld, "physWorld", 0, false, 0, true);
	// return value
	return physWorld;
}
