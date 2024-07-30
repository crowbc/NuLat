#ifndef NULATGENERATOR_HH
#define NULATGENERATOR_HH
// included Geant4 header files
#include "G4VUserPrimaryGeneratorAction.hh"
#include "G4ParticleGun.hh"
#include "G4SystemOfUnits.hh"
#include "G4ParticleTable.hh"
#include "G4Geantino.hh"
#include "G4IonTable.hh"
#include "G4RunManager.hh"
// class definition
class NuLatPrimaryGenerator : public G4VUserPrimaryGeneratorAction
{
public:
	NuLatPrimaryGenerator();
	~NuLatPrimaryGenerator();
	
	virtual void GeneratePrimaries(G4Event*);
	
private:
	G4ParticleGun* fParticleGun;
	// useful constants
	const G4double in = 25.4*mm;
	// constant for cone geometry, equal to 1st quadrant branch of tan^-1(158.8mm/207.5mm)
	const G4double cone_angle = 37.4*deg;
	// variables for randomized direction
	G4double theta, phi;
	// variables for particle properties
	G4double charge, energy;
	// minimum energy (roughly) for IBD positron
	G4double ibdQ = 1.8*MeV;
	G4int Z, A;
};
#endif
