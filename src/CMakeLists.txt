# This file is in your src/ directory

# --- BEGIN BRUTE FORCE FIX (Modern) ---
# We are hardcoding all paths because the top-level
# CMakeLists.txt is failing to find RATPAC and ROOT.

# 1. Define the Object Library
add_library( nulatobj OBJECT
  # Append each .cc file
  Nulat.cc
  SegmentedDetectorFactory.cc
)

# 2. Add include directories DIRECTLY to the nulatobj target.
# This is more robust than the global include_directories() command.
# The PUBLIC keyword will propagate these paths to 'nulat'.
target_include_directories(nulatobj PUBLIC
  # Path to your project's headers (e.g., SegmentedDetectorFactory.hh)
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  
  # Path to Geant4 (this variable *was* working)
  ${Geant4_INCLUDE_DIRS}
  
  # Hardcoded path to ROOT's includes (and Vdt, etc.)
  /home/jack/RATPAC2/ratpac-setup/local/include
    
  # Hardcoded path to RATPAC's includes (fixes "fatal error")
  /home/jack/RATPAC2/ratpac-setup/ratpac/install/include
)
# --- END INCLUDE FIX ---

# 3. Define the executable
add_executable(nulat nulat.cpp)

# --- BEGIN BRUTE FORCE LINKER FIX ---
# 4. Link all libraries explicitly to the final executable:
target_link_libraries(nulat PUBLIC 
  nulatobj # This links the object files
  
  # Hardcoded path to the RATPAC library (this path is correct)
  /home/jack/RATPAC2/ratpac-setup/ratpac/install/lib/libRATPAC.so
  
  # Geant4 libraries (this variable *was* working)
  ${Geant4_LIBRARIES}
  
  # Hardcoded paths to the ROOT libraries RATPAC needs.
  /home/jack/RATPAC2/ratpac-setup/local/lib/libCore.so
  /home/jack/RATPAC2/ratpac-setup/local/lib/libRIO.so
  /home/jack/RATPAC2/ratpac-setup/local/lib/libHist.so
  /home/jack/RATPAC2/ratpac-setup/local/lib/libGraf.so
  /home/jack/RATPAC2/ratpac-setup/local/lib/libMatrix.so
  /home/jack/RATPAC2/ratpac-setup/local/lib/libPhysics.so
  /home/jack/RATPAC2/ratpac-setup/local/lib/libMathCore.so
  /home/jack/RATPAC2/ratpac-setup/local/lib/libThread.so

  Threads::Threads
)
# --- END LINKER FIX ---

set_target_properties(nulatobj nulat
  PROPERTIES
  CXX_STANDARD 17
  CXX_STANDARD_REQUIRED YES
)
