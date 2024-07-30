#include "NuLatAction.hh"
// constructor
NuLatActionInitialization::NuLatActionInitialization()
{}
// destructor
NuLatActionInitialization::~NuLatActionInitialization()
{}
// build for master thread
void NuLatActionInitialization::BuildForMaster() const
{
	// Do only Run Action for Master Thread
	/*NuLatRunAction *runAction = new NuLatRunAction();
	SetUserAction(runAction);/**/
}
// build function
void NuLatActionInitialization::Build() const
{
	// Generator Action (uncomment this first)
	NuLatPrimaryGenerator *generator = new NuLatPrimaryGenerator();
	SetUserAction(generator);
	// Run Action
	/*NuLatRunAction *runAction = new NuLatRunAction();
	SetUserAction(runAction);
	// Event Action
	NuLatEventAction *eventAction = new NuLatEventAction(runAction);
	SetUserAction(eventAction);
	// Stepping Action
	/*NuLatSteppingAction *steppingAction = new NuLatSteppingAction(eventAction);
	SetUserAction(steppingAction);/**/
}
