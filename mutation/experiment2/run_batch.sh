#!/bin/bash
# Sequential so the runs do not contend with each other or with the other
# agents on this box.
cd /mnt/scratch1/ardi/dsl_mut/HM-arith/mutation/experiment2
export HL_NUM_THREADS=4
COMMON="--halide-build /dev/shm/ardi_dslmut/halide16-build --mull-output /mnt/scratch1/ardi/dsl_mut/mull-ps/output --workdir /dev/shm/ardi_dslmut/arith-work"

run() { echo "=== $* ==="; python3 run_targets.py $COMMON "$@" 2>&1; }

run --app depthwise_separable_conv --arms arithmetic \
    --test-driver apps/depthwise_separable_conv/mutation_test2.cpp \
    --csv results/dwsc-arith-t2.csv > logs/dwsc-t2.log 2>&1

run --app max_filter --arms arithmetic,generated \
    --test-args "[]" --test-output-artifact "" \
    --csv results/max_filter-arith.csv > logs/max_filter-arith.log 2>&1

run --app iir_blur --arms arithmetic \
    --test-args "[]" --test-output-artifact "" \
    --csv results/iir_blur-arith.csv > logs/iir_blur-arith.log 2>&1

run --app lens_blur --arms arithmetic \
    --test-driver apps/lens_blur/mutation_test2.cpp \
    --test-args "[]" --test-output-artifact out.bin \
    --csv results/lens_blur-arith-t2.csv > logs/lens_blur-t2.log 2>&1

run --app conv_layer --arms arithmetic,generated \
    --csv results/conv_layer.csv > logs/conv_layer.log 2>&1

echo BATCH_DONE
