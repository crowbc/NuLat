#ifndef NULATPHYSICS_HH
#define NULATPHYSICS_HH
// include Geant4 Physics packages
#include "G4VModularPhysicsList.hh"
#include "G4EmStandardPhysics.hh"
#include "G4OpticalPhysics.hh"
#include "G4DecayPhysics.hh"
#include "G4RadioactiveDecayPhysics.hh"
// write the class
class NuLatPhysicsList : public G4VModularPhysicsList
{
public:
	// Constructor
	NuLatPhysicsList();
	// Destructor
	~NuLatPhysicsList();
};
#endif
