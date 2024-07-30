// user defined header file for class
#include "NuLatEvent.hh"
// Constructor
NuLatEventAction::NuLatEventAction(NuLatRunAction* aRun) : G4UserEventAction()
{
	// initialize with 0 energy
	fEdepNuLat=0.;
	// assume 5x5x5 array. Set a way to pass these from detector construction
	xVoxels = 5;
	yVoxels = 5;
	zVoxels = 5;
	nPMT = yVoxels*zVoxels + xVoxels*zVoxels + xVoxels*yVoxels;// ()*2 for fully instrumented detector
	nVox = xVoxels*yVoxels*zVoxels;
}
// Destructor
NuLatEventAction::~NuLatEventAction()
{}
// Begin of Event Action
void NuLatEventAction::BeginOfEventAction(const G4Event* anEvent)
{
	// Set energy to 0 at beginning of every event
	fEdepNuLat=0.;
	// Get event number, print event number for every 1000th event
	fEvent = anEvent->GetEventID();
	//G4int rNum;// = anEvent->command to get the run->GetRunID();
	if(fEvent%1000 == 0)
	{
		if (fEvent == 0) G4cout << "Beginning of run... "/*# " << rNum*/ << G4endl << G4endl;
		G4cout << "Beginning of event # " << fEvent << G4endl;
	}
}
// End of Event Action
void NuLatEventAction::EndOfEventAction(const G4Event* anEvent)
{
	// Initialize analysis manager and fill N tuple with energy depositions
	//G4AnalysisManager *Aman = G4AnalysisManager::Instance();
	// Fill NuLat scoring N-tuple
	//Aman->FillNtupleIColumn(2, 0, fEvent);
	// finish NuLat Scoring
	//Aman->AddNtupleRow(2);
	// TODO: ...
}
