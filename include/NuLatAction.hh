// conditional to define the class only once
#ifndef NULATACTION_HH
#define NULATACTION_HH
// Geant4 header file
#include "G4VUserActionInitialization.hh"
// user defined header files
#include "NuLatGenerator.hh"
#include "NuLatRun.hh"
#include "NuLatEvent.hh"
//#include "NuLatStepping.hh"
// define the class
class NuLatActionInitialization : public G4VUserActionInitialization
{
public:
	// Constructor and Destructor
	NuLatActionInitialization();
	~NuLatActionInitialization();
	// Build User Action Methods
	virtual void Build() const;
	virtual void BuildForMaster() const;
};
// end of conditional to define the class only once
#endif
