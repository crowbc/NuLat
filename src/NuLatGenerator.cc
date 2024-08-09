// included user defined header file
#include "NuLatGenerator.hh"
// Constructor
NuLatPrimaryGenerator::NuLatPrimaryGenerator()
{
	fParticleGun = new G4ParticleGun(1);
	// define the particle
	G4ParticleTable *particleTable = G4ParticleTable::GetParticleTable();
	G4String particleName = "gamma";//"ion";"opticalphoton";"geantino";"e-";"e+";
	G4ParticleDefinition *particle = particleTable->FindParticle(particleName);
	// set ion properties for Na-22 decay source
	Z = 11;
	A = 22;
	charge = 0.*eplus;
	energy = 0.*MeV;
	// Place source on +z face of NaI detector. Set initial momentum straight into the NuLat detector.
	G4ThreeVector pos(0.,0.,-6.25*in-207.5*mm);
	// Initial momentum on random cone into the detector from approximately 20 cm away, centered on the -z face
	// note: to be truly uniform in theta, must use inverse cosine of random number between 1 and cos(cone_angle) -- however, this is close enough for small values of cone_angle
	theta = G4UniformRand()*cone_angle;
	phi = G4UniformRand()*360*deg;
	G4ThreeVector mom(sin(theta)*cos(phi),sin(theta)*sin(phi),cos(theta));
	// set particle gun properties
	G4double eCo60Lo = 1.173*MeV;// deprecated (Z = 27, A = 60 for this source)
	G4double eCo60Hi = 1.332*MeV;// deprecated (Z = 27, A = 60 for this source)
	G4double eNa22 = 1.274*MeV;// Assume annihilation gammas trigger coincidence detector - see Knoll ch 1
	G4double eminusEn = 2.0*MeV;
	G4double eplusEn = 2.0*MeV;
	fParticleGun->SetParticlePosition(pos);
	fParticleGun->SetParticleMomentumDirection(mom);
	fParticleGun->SetParticleDefinition(particle);
	if(particle==G4Geantino::Geantino())
	{
		fParticleGun->SetParticleMomentum(energy);
	}
	if(particleName=="gamma")
	{
		fParticleGun->SetParticleMomentum(eNa22);
	}
	if(particleName=="ion")
	{
		particle = G4IonTable::GetIonTable()->GetIon(Z, A, energy);
		fParticleGun->SetParticleMomentum(0.*MeV);
		fParticleGun->SetParticleCharge(charge);
	}
	if(particleName=="opticalphoton")
	{
		fParticleGun->SetParticleMomentum(2.95*eV);
	}
	if(particleName == "e-")
	{
		fParticleGun->SetParticleMomentum(eminusEn);
	}
	if(particleName == "e+")
	{
		fParticleGun->SetParticleMomentum(eplusEn);
	}
}
// Destructor
NuLatPrimaryGenerator::~NuLatPrimaryGenerator()
{
	delete fParticleGun;
}
// GeneratePrimaries()
void NuLatPrimaryGenerator::GeneratePrimaries(G4Event *NuLatEvent)
{
	//G4ParticleDefinition *particle = fParticleGun->GetParticleDefinition();
	// to be truly uniform in theta, must use inverse cosine of random number between 1 and cos(cone_angle) -- this is close enough for small values of gamma
	/*theta = G4UniformRand()*cone_angle;
	phi = G4UniformRand()*360*deg;
	G4ThreeVector mom(sin(theta)*cos(phi),sin(theta)*sin(phi),cos(theta));
	// Use Randomly Generated Momentum Direction
	fParticleGun->SetParticleMomentumDirection(mom);/**/
	// generate vertex
	fParticleGun->GeneratePrimaryVertex(NuLatEvent);
}
