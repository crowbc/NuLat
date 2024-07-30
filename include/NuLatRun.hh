// start conditional to define class only once
#ifndef NULATRUN_HH
#define NULATRUN_HH
// Geant4 header files
#include "G4UserRunAction.hh"
#include "G4AnalysisManager.hh"
#include "G4Run.hh"
// C++ header files
#include <vector>
using namespace std;
// define the class
class NuLatRunAction : public G4UserRunAction
{
public:
	// Constructor and Destructor
	NuLatRunAction();
	~NuLatRunAction();
	// User Run actions
	virtual void BeginOfRunAction(const G4Run*);
	virtual void EndOfRunAction(const G4Run*);
};
// end of conditional to define class only once
#endif
