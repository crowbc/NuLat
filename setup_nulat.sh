#!/bin/bash

# 1. Source the base RATPAC environment
# This sets up ROOT, Geant4, and the standard RATDB/RATSHARE paths
source /home/jack/RATPAC2/ratpac-setup/env.sh

# 2. Get Script Directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 3. Configure Local Environment
# We DO NOT override RATDB or RATSHARE here to avoid breaking standard model lookups.
# Instead, we rely on the user to load local DB files via macros (see usage note).
# This is the safest way to mix standard and local files in RATPAC.

# 4. Set Alias
export NULAT_EXE=$SCRIPT_DIR/build/src/nulat
alias nulat='$NULAT_EXE'

echo "----------------------------------------"
echo "NuLat Environment Setup (Simple/Safe)"
echo "----------------------------------------"
echo "RATPAC_HOME: $RATPAC_HOME"
echo "RATDB:       $RATDB"
echo "RATSHARE:    $RATSHARE"
echo "NULAT_EXE:   $NULAT_EXE"
echo "----------------------------------------"
echo "USAGE NOTE:"
echo "To use local DB/Geometry files, verify they are loaded in your macro."
echo "Example:"
echo "  /rat/db/load $SCRIPT_DIR/ratdb/MATERIALS_NULAT.ratdb"
echo "  /rat/db/set DETECTOR geo_file \"$SCRIPT_DIR/data/NuLat/NULAT5x5x5_instrumented_undoped.geo\""
echo "----------------------------------------"
