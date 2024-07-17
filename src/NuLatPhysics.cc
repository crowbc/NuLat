// User-Defined Header
#include "NuLatPhysics.hh"
// Constructor
NuLatPhysicsList::NuLatPhysicsList()
{
	RegisterPhysics(new G4EmStandardPhysics());
	RegisterPhysics(new G4OpticalPhysics());
	RegisterPhysics(new G4DecayPhysics());
	RegisterPhysics(new G4RadioactiveDecayPhysics());
}
// Destructor
NuLatPhysicsList::~NuLatPhysicsList()
{}
