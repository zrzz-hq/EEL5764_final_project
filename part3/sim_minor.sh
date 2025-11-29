#!/bin/bash

if [ -f "${GEM5_PATH}/build/ALL/gem5.opt" ]; then
    GEM5_BIN="${GEM5_PATH}/build/ALL/gem5.opt"
elif [ -f "${GEM5_PATH}/build/X86/gem5.opt" ]; then
    GEM5_BIN="${GEM5_PATH}/build/X86/gem5.opt"
else
    echo "Error: Could not find gem5.opt in build/ALL or build/X86"
    exit 1
fi

${GEM5_BIN} $@ ./config_minor.py