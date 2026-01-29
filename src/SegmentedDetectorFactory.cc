#include <SegmentedDetectorFactory.hh>

// --- RATPAC Headers ---
#include <RAT/DB.hh>
// We need to include the base header to get the Register macro
#include <RAT/DetectorFactory.hh> 

// --- Geant4 Headers ---
#include <G4Material.hh>
#include <G4Box.hh>
#include <G4LogicalVolume.hh>
#include <G4PVPlacement.hh>
#include <G4PVReplica.hh>
#include <G4ThreeVector.hh>
#include <G4Tubs.hh>
#include <G4UnitsTable.hh>
#include <G4SystemOfUnits.hh> 

#include <string>


namespace NULAT {

  G4VPhysicalVolume* SegmentedDetectorFactory::Construct(G4LogicalVolume* worldB) {
    G4cout << "SegmentedDetectorFactory: Constructing geometry." << G4endl;

    // Build the grid of cubes first
    G4LogicalVolume* gridLV = ConstructGrid(worldB);

    RAT::DB* db = RAT::DB::Get();
    // GetLink using the "index" from your .ratdb file
    RAT::DBLinkPtr lgeo = db->GetLink("GEO", "SEGMENTEDDETECTOR");

    // Get parameters for the outer acrylic box
    double acrylic_thickness = lgeo->GetD("acrylic_thickness") * 2.54 * cm;
    
    // We get the grid dimensions to calculate the size of the outer box
    double grid_x = lgeo->GetI("n_cubes_x") * (lgeo->GetD("cube_size") + lgeo->GetD("air_gap")) * 2.54 * cm;
    double grid_y = lgeo->GetI("n_cubes_y") * (lgeo->GetD("cube_size") + lgeo->GetD("air_gap")) * 2.54 * cm;
    double grid_z = lgeo->GetI("n_cubes_z") * (lgeo->GetD("cube_size") + lgeo->GetD("air_gap")) * 2.54 * cm;

    // Define the outer "world" volume (the acrylic box)
    double worldX = grid_x + 2.0 * acrylic_thickness;
    double worldY = grid_y + 2.0 * acrylic_thickness;
    double worldZ = grid_z + 2.0 * acrylic_thickness;

    G4Box* worldSolid = new G4Box("world", worldX / 2.0, worldY / 2.0, worldZ / 2.0);

    // Get materials directly from Geant4
    G4Material* acrylic = G4Material::GetMaterial("acrylic_uva_McMaster");
    G4LogicalVolume* worldLV = new G4LogicalVolume(worldSolid, acrylic, "world");

    // Place the grid of cubes (gridLV) inside the acrylic box (worldLV)
    new G4PVPlacement(0, G4ThreeVector(0, 0, 0), gridLV, "grid", worldLV, false, 0);

    // Place the completed detector (worldLV) into the main Geant4 world (worldB)
    G4VPhysicalVolume* worldPV = new G4PVPlacement(
        0, G4ThreeVector(0, 0, 0), worldLV, "segmented_detector_phys", worldB, false, 0);

    return worldPV;
  }

  G4LogicalVolume* SegmentedDetectorFactory::ConstructGrid(G4LogicalVolume* worldB) {
    RAT::DB* db = RAT::DB::Get();
    RAT::DBLinkPtr lgeo = db->GetLink("GEO", "SEGMENTEDDETECTOR");

    // Get grid parameters
    int n_cubes_x = lgeo->GetI("n_cubes_x");
    int n_cubes_y = lgeo->GetI("n_cubes_y");
    int n_cubes_z = lgeo->GetI("n_cubes_z");
    double cube_size = lgeo->GetD("cube_size") * 2.54 * cm;
    double air_gap = lgeo->GetD("air_gap") * 2.54 * cm;

    // Dimensions of a single "cell" (PVT cube + its air gap)
    double cell_x = cube_size + air_gap;
    double cell_y = cube_size + air_gap;
    double cell_z = cube_size + air_gap;

    // Total dimensions of the entire grid
    double grid_x_size = n_cubes_x * cell_x;
    double grid_y_size = n_cubes_y * cell_y;
    double grid_z_size = n_cubes_z * cell_z;
    
    // Get materials
    G4Material* pvt = G4Material::GetMaterial("pvt");
    // --- THIS IS THE FIX for G_4Material ---
    G4Material* air = G4Material::GetMaterial("air");

    // 1. The innermost volume: a single PVT cube
    G4Box* cubeSolid = new G4Box("cube", cube_size / 2.0, cube_size / 2.0, cube_size / 2.0);
    G4LogicalVolume* cubeLV = new G4LogicalVolume(cubeSolid, pvt, "cube_log");

    // 2. The "cell": a PVT cube placed inside an air-gap box
    G4Box* cellSolid = new G4Box("cell", cell_x / 2.0, cell_y / 2.0, cell_z / 2.0);
    G4LogicalVolume* cellLV = new G4LogicalVolume(cellSolid, air, "cell_log");
    new G4PVPlacement(0, G4ThreeVector(0, 0, 0), cubeLV, "cube_phys", cellLV, false, 0);

    // 3. Build the 3D grid using nested replicas (the efficient Geant4 way)
    //    We build a row, then replicate the row to make a plane, then replicate the plane.
    
    // A. A logical volume for one row (replicating cells along X)
    G4Box* rowSolid = new G4Box("rowSolid", grid_x_size / 2.0, cell_y / 2.0, cell_z / 2.0);
    G4LogicalVolume* rowLV = new G4LogicalVolume(rowSolid, air, "row_log");
    new G4PVReplica("cell_replica_x", cellLV, rowLV, kXAxis, n_cubes_x, cell_x);

    // B. A logical volume for one plane (replicating rows along Y)
    G4Box* planeSolid = new G4Box("planeSolid", grid_x_size / 2.0, grid_y_size / 2.0, cell_z / 2.0);
    G4LogicalVolume* planeLV = new G4LogicalVolume(planeSolid, air, "plane_log");
    new G4PVReplica("row_replica_y", rowLV, planeLV, kYAxis, n_cubes_y, cell_y);

    // C. The final grid (replicating planes along Z)
    G4Box* gridSolid = new G4Box("gridSolid", grid_x_size / 2.0, grid_y_size / 2.0, grid_z_size / 2.0);
    G4LogicalVolume* gridLV = new G4LogicalVolume(gridSolid, air, "grid_log");
    new G4PVReplica("plane_replica_z", planeLV, gridLV, kZAxis, n_cubes_z, cell_z);

    // Return the final, fully-built grid logical volume
    return gridLV;
  }

} // namespace NULAT
