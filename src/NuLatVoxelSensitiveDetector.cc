// included user defined header
#include "NuLatVoxelSensitiveDetector.hh"
// Constructor
NuLatVoxelSensitiveDetector::NuLatVoxelSensitiveDetector(G4String name, G4int xVox, G4int yVox, G4int zVox) : G4VSensitiveDetector(name)
{
	xVoxels = xVox;
	yVoxels = yVox;
	zVoxels = zVox;
	nVox = xVoxels*yVoxels*zVoxels;
}
// Destructor
NuLatVoxelSensitiveDetector::~NuLatVoxelSensitiveDetector()
{}
// Process Hits in the Sensitive Detector
G4bool NuLatVoxelSensitiveDetector::ProcessHits(G4Step *aStep, G4TouchableHistory *ROHist)
{
	G4int evt, pID, trkID;
	G4double eDepTot = aStep->GetTotalEnergyDeposit();// this doesn't seem to work. there are multiple tracks for one event, and multiple entries in the histogram for one event
	G4double eDep1st, xPos, yPos, zPos, time, pX0, pY0, pZ0, pMag;
	G4Track *track = aStep->GetTrack();
	trkID = track->GetTrackID();
	G4String pName = track->GetDefinition()->GetParticleName();
	pID = ParticleNameToIDNumber(pName);
	//G4ThreeVector posHit, momHit;
	if (eDepTot == 0.)// TODO: find a more efficient way to do these checks
	{
		return true;
	}
	// don't count hits from optical photons
	if (pID == 100)
	{
		return true;
	}
	const G4VTouchable *touch = aStep->GetPreStepPoint()->GetTouchable();
	G4VPhysicalVolume *physVol = touch->GetVolume();
	G4int copyNo = physVol->GetCopyNo();
	// old code for 1st hit went here... TODO: Get energy deposition for first hit voxel and store in eDep1st
	// populate variables
	evt = G4RunManager::GetRunManager()->GetCurrentEvent()->GetEventID();
	//posHit = aStep->GetTrack()->GetPosition();
	xPos = aStep->GetTrack()->GetPosition().x();
	yPos = aStep->GetTrack()->GetPosition().y();
	zPos = aStep->GetTrack()->GetPosition().z();
	time = aStep->GetTrack()->GetGlobalTime();
	pX0 = aStep->GetTrack()->GetVertexMomentumDirection().x();
	pY0 = aStep->GetTrack()->GetVertexMomentumDirection().y();
	pZ0 = aStep->GetTrack()->GetVertexMomentumDirection().z();
	pMag = aStep->GetTrack()->GetMomentum().mag();
	// old code for hit vector processing went here
	// initialize analysis manager and fill Ntuples
	G4AnalysisManager *aMan = G4AnalysisManager::Instance();
	// Fill Ntuple columns with Voxel energy deposition information - TODO: add columns for other MC information (can I store track objects like in Rat-Pac?)
	aMan->FillNtupleIColumn(2, 0, evt);
	aMan->FillNtupleIColumn(2, 1, pID);
	aMan->FillNtupleIColumn(2, 2, trkID);
	aMan->FillNtupleIColumn(2, 3, copyNo);
	aMan->FillNtupleDColumn(2, 4, eDepTot);
	aMan->FillNtupleDColumn(2, 5, eDep1st);
	aMan->FillNtupleDColumn(2, 6, xPos);
	aMan->FillNtupleDColumn(2, 7, yPos);
	aMan->FillNtupleDColumn(2, 8, zPos);
	aMan->FillNtupleDColumn(2, 9, time);
	aMan->FillNtupleDColumn(2, 10, pX0);
	aMan->FillNtupleDColumn(2, 11, pY0);
	aMan->FillNtupleDColumn(2, 12, pZ0);
	aMan->FillNtupleDColumn(2, 13, pMag);
	aMan->AddNtupleRow(2);
	// Return value
	return true;
}
/* ---------------------------------------------- */
/*  Convert a steps particle name to an ID number */
/*  specific to the NuLat analysis                */
/* ---------------------------------------------- */
G4int NuLatVoxelSensitiveDetector::ParticleNameToIDNumber(G4String name)
{
	G4int num;
	if(name == "gamma"){
		num = 1;
	}
	else if(name == "e"){
		num = 2;
	}
	else if(name == "e+"){
		num = 3;
	}
	else if(name == "neutron"){
		num = 4;
	}
	else if(name == "proton"){
		num = 5;
	}
	else if(name == "mu+"){
		num = 6;
	}
	else if(name == "mu-"){
		num = 7;
	}
	else if(name == "alpha"){
		num = 8;
	}
	else if(name == "Li7"){
		num = 9;
	}
	else if(name == "opticalphoton"){
		num = 100;
	}
	else{
		num = 0;
	}
	return num;
}
