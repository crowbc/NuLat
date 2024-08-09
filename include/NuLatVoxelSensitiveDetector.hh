// conditional to define the class only once
#ifndef NULATVOXELSENSITIVEDETECTOR_HH
#define NULATVOXELSENSITIVEDETECTOR_HH
// Header file for Sensitive Detectors
#include "G4VSensitiveDetector.hh"
#include "G4RunManager.hh"
#include "G4SystemOfUnits.hh"
#include "G4AnalysisManager.hh"
#include "G4HCofThisEvent.hh"
#include "G4TouchableHistory.hh"
#include "G4Track.hh"
#include "G4Step.hh"
#include "G4SDManager.hh"
#include "G4TrackingManager.hh"
#include "G4EventManager.hh"
// write the class
class NuLatVoxelSensitiveDetector : public G4VSensitiveDetector
{
public:
	// Constructor and Destructor
	NuLatVoxelSensitiveDetector(G4String name, G4int xVox, G4int yVox, G4int zVox);
	~NuLatVoxelSensitiveDetector();
	// Process Hits in the Sensitive Detector
	virtual G4bool ProcessHits(G4Step* aStep, G4TouchableHistory* ROhist);/**/
	// Convert the Particle String to an integer ID number
	virtual G4int ParticleNameToIDNumber(G4String name);
private:
	// Constant for calculating wavelength in nm from energy
	const G4double HCNM = 1239.841939*eV;
	// Voxel counts in each dimension and total
	G4int xVoxels, yVoxels, zVoxels, nVox;
	// Debug Message Boolean variable (set to true to enable messages)
	G4bool debugMsg = false;
};
// end of conditional to define the class only once
#endif
