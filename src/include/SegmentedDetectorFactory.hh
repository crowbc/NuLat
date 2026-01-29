#ifndef __NULAT_SegmentedDetectorFactory_hh__
#define __NULAT_SegmentedDetectorFactory_hh__

#include <RAT/DetectorFactory.hh>
#include <G4ThreeVector.hh>

// --- FIX 1: Forward declarations ---
// Tell the compiler that these classes exist, so we can use pointers to them.
class G4VPhysicalVolume;
class G4LogicalVolume;

namespace RAT {
  class DB;
}

namespace NULAT {

  class SegmentedDetectorFactory : public RAT::DetectorFactory {
  public:
    // --- FIX 2: Correct Constructor ---
    // The compiler error said RAT::DetectorFactory() takes ZERO arguments.
    // We also don't need to pass a name to this factory anymore.
    SegmentedDetectorFactory() : RAT::DetectorFactory() {}
    
    virtual ~SegmentedDetectorFactory() {}

    // These lines will now work because of the forward declarations above
    virtual G4VPhysicalVolume* Construct(G4LogicalVolume* worldB);

  private:
    G4LogicalVolume* ConstructGrid(G4LogicalVolume* worldB);
  };

} // namespace NULAT

#endif
