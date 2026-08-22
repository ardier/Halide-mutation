#!/bin/bash
# TARGET 2 continued: wavelet.
# apps.py registers wavelet as haar_x only -- "4 independent registered
# generator classes compiled together; only haar_x (the one with a
# BoundaryConditions call) is instrumented and built here. Representative of
# 1 of 4." The added mutation_driver.cpp rearranges the 2-channel haar_x
# output into a single clamped image, so this app DOES have a real output
# artifact and gets an output-comparison test, unlike fft.
export LD_LIBRARY_PATH=
set -u
P=/mnt/scratch1/ardi/dsl_mut/.priv-79c69961
G=$P/gen2
A=$P/gap-lower/repo/mutation/lowered-cpp
ROOT=/mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c
BUILD=/mnt/scratch1/ardi/dsl_mut/HM-armc-fix/build

while pgrep -u "$(whoami)" -f "run_harness.py --app resize" >/dev/null 2>&1; do sleep 20; done
echo "=== $(date -Is) wavelet (haar_x) START ==="
taskset -c 0-11,120-127 python3 $P/b1/run_harness.py \
    --app wavelet --halide-root $ROOT --halide-build $BUILD \
    --halidemut $ROOT/mutation --tool $P/bin/tool-c5b488d \
    --emitted $A/wavelet/haar_x.halide_generated.cpp \
    --lowered-dir $A/wavelet --runtime-a $P/gen1/bin/runtime.a \
    --ops=cxx_arith_swap,cxx_rel_swap \
    --out-csv $G/out/wavelet-emitted.csv --scratch /dev/shm/emitmut79 \
    --jobs 6 > $G/logs/wavelet-emitted.log 2>&1
echo "    rc=$?"
tail -9 $G/logs/wavelet-emitted.log | sed "s/^/      /"
rm -rf /dev/shm/emitmut79/wavelet
echo "=== $(date -Is) wavelet END ==="
