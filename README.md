# EEL5764 Final Project

**Important**: You must set the GEM5_PATH environment variable before executing the commands in the next sections. Use the command shown below.
```bash
export GEM5_PATH=your/gem5/path
```

## Environment Setup
Follow the instructions [here](https://www.gem5.org/documentation/learning_gem5/part1/building/) to install build dependencies

Build the RISCV ISA for gem5
```bash
cd ${GEM5_PATH}
scons build/RISCV/gem5.opt -j$(nproc)
```
Install RISC-V Cross Compiler
```bash
sudo apt update  
sudo apt install gcc-riscv64-linux-gnu g++-riscv64-linux-gnu libc6-dev-riscv64-cross
```
Build m5ops
```bash
cd util/m5
scons riscv.CROSS_COMPILE=riscv-linux-gnu- build/riscv/out/m5
```

## Part1
```bash
cd part1
make
bash sim.sh
```
## Part2
```
cd part2
make
bash sim.sh
```
## Part3
### **TIMING CPU**
```
cd part3
bash sim_timing.sh
```
### **MINOR CPU**
```
cd part3
bash sim_minor.sh
```
## Part4
Use commands in **Part3**
