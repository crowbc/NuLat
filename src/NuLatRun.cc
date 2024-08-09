// user defined header file for class
#include "NuLatRun.hh"
// Constructor
NuLatRunAction::NuLatRunAction()
{
	// initialize analysis manager
	G4AnalysisManager *Aman = G4AnalysisManager::Instance();
	// create N tuple for photon truth information in NuLat PMT hits
	Aman->CreateNtuple("NuLat_PMT_Truth", "NuLat_PMT_Truth");// Ntuple 0
	Aman->CreateNtupleIColumn("fEvent");// col 0
	Aman->CreateNtupleDColumn("fX");// col 1
	Aman->CreateNtupleDColumn("fY");// col 2
	Aman->CreateNtupleDColumn("fZ");// col 3
	Aman->CreateNtupleDColumn("fWlen");// col 4
	Aman->FinishNtuple(0);
	// create N tuple for PMT hit information
	Aman->CreateNtuple("NuLat_PMT_Hits", "NuLat_PMT_Hits");// Ntuple 1
	Aman->CreateNtupleIColumn("fEvent");// col 0
	// PMT ID
	Aman->CreateNtupleIColumn("fID");// col 1
	// PMT coords
	Aman->CreateNtupleDColumn("fX");// col 2
	Aman->CreateNtupleDColumn("fY");// col 3
	Aman->CreateNtupleDColumn("fZ");// col 4
	// time of hit
	Aman->CreateNtupleDColumn("fT");// col 5
	// TODO: figure out if I can get waveforms from the simulation, and if so, how.
	Aman->FinishNtuple(1);
	// create N tuple for energy deposition tracking (MC truth)
	Aman->CreateNtuple("NuLat_Scoring", "NuLat_Scoring");// Ntuple 2
	Aman->CreateNtupleIColumn("fEvent");// col 0
	// columns for particle ID and track ID
	Aman->CreateNtupleIColumn("fPID");// col 1
	Aman->CreateNtupleIColumn("fTrkID");// col 2
	// Voxel ID - can use to validate whether or not coordinates are true
	Aman->CreateNtupleIColumn("fID");// col 3
	// scoring value for energy deposition
	Aman->CreateNtupleDColumn("fTotEdep");// col 4
	// scoring for first hit
	Aman->CreateNtupleDColumn("fFirstHitEdep");// col 5
	// Voxel coords
	Aman->CreateNtupleDColumn("fX");// col 6
	Aman->CreateNtupleDColumn("fY");// col 7
	Aman->CreateNtupleDColumn("fZ");// col 8
	// time of hit
	Aman->CreateNtupleDColumn("fT");// col 9
	// columns for momentum components
	Aman->CreateNtupleDColumn("fPX0");// col 10
	Aman->CreateNtupleDColumn("fPY0");// col 11
	Aman->CreateNtupleDColumn("fPZ0");// col 12
	Aman->CreateNtupleDColumn("fPmag");// col 13
	Aman->FinishNtuple(2);
	// TODO: get trajectory info stored in Ntuple
}
// Destructor
NuLatRunAction::~NuLatRunAction()
{}
// Beginning of Run
void NuLatRunAction::BeginOfRunAction(const G4Run* NuLatRun)
{
	G4AnalysisManager *Aman = G4AnalysisManager::Instance();
	G4int rNum = NuLatRun->GetRunID();
	std::stringstream sRunID;
	sRunID << rNum;
	G4String name = "NuLat_run";
	G4String ext = "_output.root";
	G4String fName = name + sRunID.str() + ext;
	Aman->OpenFile(fName);
	Aman->SetVerboseLevel(1);
}
// End of Run
void NuLatRunAction::EndOfRunAction(const G4Run* NuLatRun)
{
	G4AnalysisManager *Aman = G4AnalysisManager::Instance();
	// write and close the ROOT file !IMPORTANT!
	Aman->Write();
	Aman->CloseFile();
}
