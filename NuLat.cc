/*
	File: Nulat.cc
	Author: Brian Crow
	Date: 17JUL2024
	Description: This code is for the NuLat detector simulation, which can run in batch mode with multithread run support, or in interactive mode. See README for notes, and change log.
	Version: 1.0.0 Initial Commit
*/
// Included C++ libraries
#include <iostream>
#include <fstream>
// Included Geant4 libriaries
#include "G4UImanager.hh"
#include "G4RunManager.hh"
#include "G4RunManagerFactory.hh"
#ifdef G4MULTITHREADED
#include "G4MTRunManager.hh"
#endif
#include "G4UIExecutive.hh"
#include "G4VisManager.hh"
#include "G4VisExecutive.hh"
// Included simulation libraries -- uncomment action header when class is written
#include "NuLatDetectorConstruction.hh"
#include "NuLatPhysics.hh"
#include "NuLatAction.hh"
using namespace std;
// main()
int main(int argc, char** argv)
{
	// Define the UI session
	G4UIExecutive *ui = 0;
	// Start runmanager in multithread mode if supported
	#ifdef G4MULTITHREADED
		G4MTRunManager *rMan = new G4MTRunManager();
		// Set mandatory initialization classes
		rMan->SetUserInitialization(new NuLatDetectorConstruction());
		rMan->SetUserInitialization(new NuLatPhysicsList());
		rMan->SetUserInitialization(new NuLatActionInitialization());
		// put "/run/numberOfThreads <N>" in macro file, where <N> is the number of cores to use in simulation
		// put "/run/initialize" in macro file
	#else
		// Construct the default run manager
		G4RunManager *rMan = G4RunManagerFactory::CreateRunManager();
		// Set mandatory initialization classes -- uncomment action initialization when class is written
		rMan->SetUserInitialization(new NuLatDetectorConstruction());
		rMan->SetUserInitialization(new NuLatPhysicsList());
		rMan->SetUserInitialization(new NuLatActionInitialization());
		// Initialize G4 kernel if Geant4 environment is defined in single thread mode
		rMan->Initialize();
	#endif
	// Default strings for initializing
	G4String pathCmd = "/control/macroPath ";
	G4String macPath = "/home/jack/Documents/geant4/NuLat/macros/";
	G4String macCmd = "/control/execute ";
	G4String macName = "init_vis.mac";
	// Default UI for interactive mode
	if(argc==1)
	{
		ui = new G4UIExecutive(argc, argv);
	}
	// Construct and initialize the visualization manager
	G4VisManager *vMan = new G4VisExecutive();
	vMan->Initialize();
	// Get the pointer to the UI manager and define session
	G4UImanager *UIman = G4UImanager::GetUIpointer();
	if(ui)
	{
		// Open the viewer and run in interactive mode
		UIman->ApplyCommand(pathCmd+macPath);
		UIman->ApplyCommand(macCmd+macName);
		ui->SessionStart();	
	}
	else
	{
		// Run in batch mode using command line input to execute the specified macro. Runtime environment handles macro exceptions
		UIman->ApplyCommand(pathCmd+macPath);
		macName=argv[1];
		UIman->ApplyCommand(macCmd+macName);
	}
	// job termination
	delete rMan;
	delete vMan;
	delete ui;
	return 0;
}
