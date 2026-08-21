#!/bin/bash
set -u
cd /mnt/scratch1/ardi/dsl_mut/HM-armc/mutation/lowered-cpp/cxx_default_arm
export ARMC_BUDGET=1200
export ARMC_HL_THREADS=2
export ARMC_JOBS=24
python3 arm_c_swsec.py all interpolate local_laplacian stencil_chain
echo "ARM_C_SECOND_WAVE_DONE (exit $?)"
