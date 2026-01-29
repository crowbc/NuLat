cmake_minimum_required(VERSION 3.11...3.14)
project(nulat VERSION 1.0.0
  DESCRIPTION "Nulat Simulations"
  LANGUAGES C CXX)

###########################################################
# Require out-of-source builds
file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory. Feel free to remove CMakeCache.txt and CMakeFiles.")
endif()


###########################################################
# Set default build type
set(default_build_type "Release")
#set(CMAKE_BUILD_TYPE Debug)
#set(CMAKE_CXX_FLAGS -pg)
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
  set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
      STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
    "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()
add_compile_options(-w)

###########################################################
# Set CMAKE standards
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

###########################################################
# External libraries and dependencies
set(TENSORFLOW_Enabled 0)
find_library(TENSORFLOW_LIBRARIES tensorflow NO_DEFAULT_PATH)
if(TENSORFLOW_LIBRARIES)
  message(STATUS "Compiling with Tensorflow")
  set(TENSORFLOW_Enabled 1)
else()
  set(TENSORFLOW_LIBRARIES "")
endif()

###########################################################
# Options
set(NULAT_BINARY_DIR ${PROJECT_BINARY_DIR}/bin CACHE PATH "Where to output executables")
set(NULAT_LIBRARY_DIR ${PROJECT_BINARY_DIR}/lib CACHE PATH "Where to output library files")
set(NULAT_INCLUDE_DIR ${PROJECT_BINARY_DIR}/include CACHE PATH "Where to collect headers")
set(NULAT_CMAKE_DIR ${PROJECT_BINARY_DIR}/cmake CACHE PATH "Where to cmake configuration")
option(NULAT_RAT "build rat executable" ON)

###########################################################
# Set up third party libraries
if(ROOT_DIR)
  find_package(ROOT NO_DEFAULT_PATH CONFIG REQUIRED COMPONENTS MathMore Minuit2 ROOTTPython)
else()
  find_package(ROOT CONFIG REQUIRED COMPONENTS MathMore Minuit2 ROOTTPython)
endif()
include(${ROOT_USE_FILE})

find_package(Geant4 REQUIRED COMPONENTS qt)
include(${Geant4_USE_FILE})
include_directories(${Geant4_INCLUDE_DIRS})

find_package(Threads REQUIRED)
find_package(Ratpac REQUIRED)

###########################################################
# Configure header with our version information
configure_file(${CMAKE_SOURCE_DIR}/config/Config.hh.in
    ${CMAKE_SOURCE_DIR}/src/include/Config.hh
    @ONLY NEWLINE_STYLE UNIX)

# Configure local scripts
set(NULATROOT ${CMAKE_INSTALL_PREFIX})
set(NULATSHARE ${PROJECT_SOURCE_DIR})
configure_file(${CMAKE_SOURCE_DIR}/config/nulat.sh.in
  ${PROJECT_SOURCE_DIR}/nulat.sh
  @ONLY NEWLINE_STYLE UNIX)

###########################################################
# Compile our libraries and executables
add_subdirectory(src)

###########################################################
# Installation

# Configure global scripts
set(NULATSHARE ${CMAKE_INSTALL_PREFIX}/share/nulat)
configure_file(${CMAKE_SOURCE_DIR}/config/nulat.sh.in
  ${NULAT_BINARY_DIR}/nulat.sh
  @ONLY NEWLINE_STYLE UNIX)

# Install the data files
install(DIRECTORY ratdb/ DESTINATION ${NULATSHARE}/ratdb
  PATTERN "ratdb/*")

install(DIRECTORY models/ DESTINATION ${NULATSHARE}/models
  PATTERN "models/*")

# Install the python files
install(DIRECTORY utilities/ DESTINATION ${NULATSHARE}/utilities
  PATTERN "utilities/*")

# Install the mac files
install(DIRECTORY macros/ DESTINATION ${NULATSHARE}/macros
  PATTERN "macros/*")

# Install env files
install(FILES ${NULAT_BINARY_DIR}/nulat.sh
  DESTINATION bin)
