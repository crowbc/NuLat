// Start conditional to define class only once
#ifndef NAIPMTHIT_HH
#define NAIPMTHIT_HH
// Included Geant4 header files
#include "G4VHit.hh"
#include "G4THitsCollection.hh"
#include "G4Allocator.hh"
#include "G4LogicalVolume.hh"
#include "G4AttDefStore.hh"
#include "G4AttDef.hh"
#include "G4AttValue.hh"
#include "G4SystemOfUnits.hh"
#include "G4UnitsTable.hh"
#include "G4VVisManager.hh"
#include "G4VisAttributes.hh"
#include "G4UIcommand.hh"
// included C++ header files
#include "vector"
using namespace std;
// make the class - it should record PMT ID, energy deposition and location
class NaIPMTHit : public G4VHit
{
public:
	// Constructors
	NaIPMTHit();
	NaIPMTHit(G4int z);
	NaIPMTHit(const NaIPMTHit &right);
	// Destructor
	~NaIPMTHit();
	// Operators
	const NaIPMTHit& operator=(const NaIPMTHit &right);
	int operator==(const NaIPMTHit &right) const;
	inline void *operator new(size_t);
	inline void operator delete(void *aHit);
	// Function declarations
	virtual void Draw();
	virtual void Print();
	virtual const std::map<G4String,G4AttDef>* GetAttDefs() const;
	virtual std::vector<G4AttValue>* CreateAttValues() const;
	// Methods for PMT ID
	void SetPMTID(G4int z) { fPMTID = z; }
	G4int GetPMTID() const { return fPMTID; }
	// Photocathode Hits (not actually simulated in build 2)
	void SetPEHits(G4int de) { peHits = de; }
	void AddPEHits(G4int de) { peHits += de; }
	G4double GetPEHits() const { return peHits; }
	// Wavelength for MC truth
	G4double GetWlen() const { return wlen; }
	// Position of Hit
	void SetPos(G4ThreeVector xyz) { fPos = xyz; }
	G4ThreeVector GetPos() const { return fPos; }
	void SetRot(G4RotationMatrix rmat) { fRot = rmat; }
	G4RotationMatrix GetRot() const { return fRot; }
	// Logical volume of hit
	void SetLogV(G4LogicalVolume* vol) { fPLogV = vol; }
	const G4LogicalVolume* GetLogV() const { return fPLogV; }
	// Data being saved in containers when hit occurs
	void PushPMTHitPID(G4int ID) { PMTHitPIDVec.push_back(ID); }
	void PushPMTHitEnergyVec(G4double energy) { PMTHitEnergyVec.push_back(energy); }
	void PushPMTHitWlenVec(G4double wavelen) { PMTHitWlenVec.push_back(wavelen); }
	/*void PushxPosPMTHitVec(G4double X) { xPosPMTHitVec.push_back(X); }
	void PushyPosPMTHitVec(G4double Y) { yPosPMTHitVec.push_back(Y); }
	void PushzPosPMTHitVec(G4double Z) { zPosPMTHitVec.push_back(Z); }*/
	void PushPMTHitTimeVec(G4double time) { PMTHitTimeVec.push_back(time); }
	std::vector<G4int> GetPMTHitPIDVec() { return PMTHitPIDVec; }
	std::vector<G4double> GetPMTHitEnergyVec() { return PMTHitEnergyVec; }
	std::vector<G4double> GetPMTHitWlenVec() { return PMTHitWlenVec; }
	/*std::vector<G4double> GetxPosPMTHitVec() { return xPosPMTHitVec; }
	std::vector<G4double> GetyPosPMTHitVec() { return yPosPMTHitVec; }
	std::vector<G4double> GetzPosPMTHitVec() { return zPosPMTHitVec; }*/
	std::vector<G4double> GetPMTHitTimeVec() { return PMTHitTimeVec; }
	void ClearPMTHitPID() { PMTHitPIDVec.clear(); }
	void ClearPMTHitEnergyVec() { PMTHitEnergyVec.clear(); }
	void ClearPMTHitWlenVec() { PMTHitWlenVec.clear(); }
	/*void ClearxPosPMTHitVec() { xPosPMTHitVec.clear(); }
	void ClearyPosPMTHitVec() { yPosPMTHitVec.clear(); }
	void ClearzPosPMTHitVec() { zPosPMTHitVec.clear(); }*/
	void ClearPMTHitTimeVec() { PMTHitTimeVec.clear(); }
private:
	// variables used to identify hit information
	G4int fPMTID;
	G4double peHits, wlen;
	// variable to toggle feedback
	G4bool fbOn = false;
	// data containers
	static std::vector<G4int> PMTHitPIDVec;
	static std::vector<G4int> PMTPEVec;
	/*static std::vector<G4int> PMTXPEVec;
	static std::vector<G4int> PMTYPEVec;
	static std::vector<G4int> PMTZPEVec;*/
	static std::vector<G4double> PMTHitWlenVec;
	static std::vector<G4double> PMTHitEnergyVec;
	/*static std::vector<G4double> xPosPMTHitVec;
	static std::vector<G4double> yPosPMTHitVec;
	static std::vector<G4double> zPosPMTHitVec;*/
	static std::vector<G4double> PMTHitTimeVec;
	// location and volume objects
	G4ThreeVector fPos;
	G4RotationMatrix fRot;
	const G4LogicalVolume *fPLogV;
};
// Define PMT Hits Collection
typedef G4THitsCollection<NaIPMTHit> NaIPMTHitsCollection;
// Define Allocator
extern G4ThreadLocal G4Allocator<NaIPMTHit>* NaIPMTHitAllocator;
// Define new operator
inline void* NaIPMTHit::operator new(size_t)
{
	if (!NaIPMTHitAllocator)
		NaIPMTHitAllocator = new G4Allocator<NaIPMTHit>;
	return (void*)NaIPMTHitAllocator->MallocSingle();
}
// Define delete operator
inline void NaIPMTHit::operator delete(void* aHit)
{
	NaIPMTHitAllocator->FreeSingle((NaIPMTHit*) aHit);
}
// End of conditional to define class only once
#endif
