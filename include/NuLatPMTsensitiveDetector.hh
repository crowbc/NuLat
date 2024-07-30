#ifndef NULATPMTSENSITIVEDETECTOR_HH
#define NULATPMTSENSITIVEDETECTOR_HH
// Header file for Sensitive Detectors
#include "G4VSensitiveDetector.hh"
#include "G4RunManager.hh"
#include "G4SystemOfUnits.hh"
#include "G4AnalysisManager.hh"
#include "G4TouchableHistory.hh"
#include "G4Track.hh"
#include "G4Step.hh"
#include "G4SDManager.hh"
#include "G4TrackingManager.hh"
#include "G4EventManager.hh"
// Define the class
class NuLatPMTSensitiveDetector : public G4VSensitiveDetector
{
public:
	NuLatPMTSensitiveDetector(G4String, G4int xVox, G4int yVox, G4int zVox);
	~NuLatPMTSensitiveDetector();
	// ProcessHits()
	virtual G4bool ProcessHits(G4Step *, G4TouchableHistory *);
	// get particle ID from name
	virtual G4int ParticleNameToIDNumber(G4String name);
private:
	const G4double HCNM = 1239.841939*eV;
	// Boolean switch for debug messages
	//G4bool debugMsg;
	// Voxels in each dimension, total number of PMTs
	G4int xVoxels, yVoxels, zVoxels, numPMT;
	// Variables for particle information
	G4int pID, fEvt, fID;
	G4String pName;
	// MC truth
	G4double xpos, ypos, zpos, pX0, pY0, pZ0, wlen, queff;
	G4ThreeVector posPhoton, momPhoton;
	// PMT location
	G4double fX, fY, fZ, fT;
	G4ThreeVector posDet;
};
#endif
