#!/bin/bash

if [ -f "${GEM5_PATH}/build/ALL/gem5.opt" ]; then
    GEM5_BIN="${GEM5_PATH}/build/ALL/gem5.opt"
elif [ -f "${GEM5_PATH}/build/X86/gem5.opt" ]; then
    GEM5_BIN="${GEM5_PATH}/build/X86/gem5.opt"
else
    echo "Error: Could not find gem5.opt in build/ALL or build/X86"
    exit 1
fi

# Clear results file
> m5out/all_results_4b_x86.txt

# Function to run a test configuration
run_test() {
    local int_opLat=$1
    local float_opLat=$2
    
    OUTDIR="m5out/int_opLat${int_opLat}_float_opLat${float_opLat}"
    
    ${GEM5_BIN} --outdir=${OUTDIR} config_minor_4b_x86.py ${int_opLat} ${float_opLat}
    
    echo "int_opLat=${int_opLat} float_opLat=${float_opLat}" >> m5out/all_results_4b_x86.txt
    cat ${OUTDIR}/stats.txt | grep -E "board.processor.cores.core\.(cpi|numCycles)|commitStats0.numInsts|simSeconds" >> m5out/all_results_4b_x86.txt
    echo -e "\n\n" >> m5out/all_results_4b_x86.txt
}

# Baseline: int=2 cycles, float=4 cycles
run_test 2 4

# Option 1: Halve integer latency
run_test 1 4

# Option 2: Halve float latency
run_test 2 2