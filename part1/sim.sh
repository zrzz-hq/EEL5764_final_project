#!/bin/bash

${GEM5_PATH}/build/RISCV/gem5.opt \
    ${GEM5_PATH}/configs/deprecated/example/se.py \
    --cmd=./daxpy \
    --cpu-type=TimingSimpleCPU \
    --caches \
    --l1d_size=64kB \
    --l1i_size=32kB
