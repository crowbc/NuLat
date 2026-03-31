#!/bin/bash

# Ensure NULATLOC is set so the macro paths resolve correctly
if [ -z "$NULATLOC" ]; then
    echo "Error: NULATLOC environment variable is not set."
    echo "Please source your NuLat environment script first."
    exit 1
fi

# Ensure NULAT_EXE is set so the executable can be found
if [ -z "$NULAT_EXE" ]; then
    echo "Error: NULAT_EXE environment variable is not set."
    echo "Please make sure it points to your NuLat executable."
    exit 1
fi

echo "Starting NuLat blind study batch generation..."
echo "Output directory: $(pwd)"

# Loop through run numbers 1 to 30
for i in {1..30}; do
    # Format the number to be 3 digits, zero-padded (e.g., 001, 002)
    RUN_NUM=$(printf "%03d" $i)
    
    MACRO_FILE="$NULATLOC/macros/blind/blind_macros/blind_set_${RUN_NUM}.mac"
    LOG_FILE="blind_set_${RUN_NUM}.log"
    OUTPUT_FILE="blind_set_${RUN_NUM}"

    echo "--------------------------------------------------------"
    echo "Starting run ${RUN_NUM} at $(date)"
    echo "Executing: $NULAT_EXE -m $MACRO_FILE -l $LOG_FILE"
    
    # Run the NuLat simulation
    $NULAT_EXE -m "$MACRO_FILE" -l "$LOG_FILE" -o $OUTPUT_FILE
    
    echo "Finished run ${RUN_NUM}"
done

echo "--------------------------------------------------------"
echo "All 30 blind study runs have completed!"
