// conditional to define class only once
#ifndef NULATEVENT_HH
#define NULATEVENT_HH
// Geant4 header files
#include "G4UserEventAction.hh"
#include "G4Event.hh"
#include "G4HCofThisEvent.hh"
#include "G4SDManager.hh"
#include "G4AnalysisManager.hh"
#include "G4TrackingManager.hh"
#include "G4VTrajectory.hh"
// user defined header files
#include "NuLatRun.hh"
//#include "NuLatVoxelHit.hh"
//#include "NuLatPMTHit.hh"
// C++ header files
#include <vector>
using namespace std;
// define the class
class NuLatEventAction : public G4UserEventAction
{
public:
	// Constructor and Destructor
	NuLatEventAction(NuLatRunAction* aRun);
	~NuLatEventAction();
	// User Event Actions
	virtual void BeginOfEventAction(const G4Event* anEvent);
	virtual void EndOfEventAction(const G4Event* anEvent);
	// functions to add energy depositions
	void AddEdepNuLat(G4double edep){ fEdepNuLat+=edep; }
private:
	// variable to store energy depositions, hit voxel coordinates, time and momentum components
	G4double fEdepNuLat, fX, fY, fZ, fT, fPX0, fPY0, fPZ0;
	/*
		variables to store event ID, Voxel Hit ID, PMT Hit ID, index of hit voxel, particle ID, track ID, ...
		hit collection ID's for PMT's and Voxels, to set voxel count in x, y, z and total, and number of PMTs
	*/
	G4int fEvent, fID, fPID, fTrkID, xVoxels, yVoxels, zVoxels, nVox, nPMT;
};
// end of conditional to define class only once
#endif
