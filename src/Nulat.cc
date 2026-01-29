#include "Nulat.hh"
#include "SegmentedDetectorFactory.hh" 
#include <RAT/ProducerBlock.hh>
#include <G4ios.hh>

// --- FIX: Include for sensitive detector registration ---
#include <RAT/GLG4PMTSD.hh>
#include <G4SDManager.hh>
// --- END FIX ---

namespace NULAT {

Nulat::Nulat(RAT::AnyParse* parse, int argc, char **argv)
  : RAT::Rat(parse, argc, argv)
{
  G4cout << "Nulat: Registering custom factories" << G4endl;
  
  // The geometry factory is usually handled by the macro/library loading, 
  // but we need to ensure the Sensitive Detector exists for our .geo file to find it.
  
  // --- FIX: Register the Sensitive Detector ---
  // This tells Geant4/RATPAC that "/NuLat/pmt/inner" is a valid SD name.
  // This allows the "dumb" geometry file to attach this detector to the PMT volumes.
  G4SDManager* fSDman = G4SDManager::GetSDMpointer();
  GLG4PMTSD* pmtSD = new GLG4PMTSD("/NuLat/pmt/inner");
  fSDman->AddNewDetector(pmtSD);
  // --- END FIX ---
}

} // namespace NULAT
