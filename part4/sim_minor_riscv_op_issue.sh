#!/bin/bash

# Check for ALL build first, then fall back to X86
if [ -f "${GEM5_PATH}/build/ALL/gem5.opt" ]; then
    GEM5_BIN="${GEM5_PATH}/build/ALL/gem5.opt"
elif [ -f "${GEM5_PATH}/build/RISCV/gem5.opt" ]; then
    GEM5_BIN="${GEM5_PATH}/build/RISCV/gem5.opt"
else
    echo "Error: Could not find gem5.opt in build/ALL or build/X86"
    exit 1
fi

#results file
> m5out/all_results.txt

# test all combinations where opLat + issueLat = 7
for opLat in {1..6}; do
    issueLat=$((7 - opLat))
    OUTDIR="m5out/op${opLat}_issue${issueLat}"
    
    ${GEM5_BIN} --outdir=${OUTDIR} config_minor_riscv_op_issue.py ${opLat} ${issueLat}
    
    echo "opLat=${opLat} issueLat=${issueLat}" >> m5out/all_results.txt
    cat ${OUTDIR}/stats.txt | grep -E "board.processor.cores.core\.(cpi|numCycles)|commitStats0.numInsts|simSeconds" >> m5out/all_results.txt
    echo -e "\n\n" >> m5out/all_results.txt
done