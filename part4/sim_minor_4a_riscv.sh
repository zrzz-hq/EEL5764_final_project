#!/bin/bash

if [ -f "${GEM5_PATH}/build/ALL/gem5.opt" ]; then
    GEM5_BIN="${GEM5_PATH}/build/ALL/gem5.opt"
elif [ -f "${GEM5_PATH}/build/RISCV/gem5.opt" ]; then
    GEM5_BIN="${GEM5_PATH}/build/RISCV/gem5.opt"
else
    echo "Error: Could not find gem5.opt in build/ALL or build/RISCV"
    exit 1
fi

#results file
> m5out/all_results_4a_riscv.txt

# test all combinations where opLat + issueLat = 7
for opLat in {1..6}; do
    issueLat=$((7 - opLat))
    OUTDIR="m5out/op${opLat}_issue${issueLat}"
    
    ${GEM5_BIN} --outdir=${OUTDIR} config_minor_4a_riscv.py ${opLat} ${issueLat}
    
    echo "opLat=${opLat} issueLat=${issueLat}" >> m5out/all_results_4a_riscv.txt
    cat ${OUTDIR}/stats.txt | grep -E "board.processor.cores.core\.(cpi|numCycles)|commitStats0.numInsts|simSeconds" >> m5out/all_results_4a_riscv.txt
    echo -e "\n\n" >> m5out/all_results_4a_riscv.txt
done