#!/bin/bash
set -u
cd /mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c
RESDIR=mutation/results-full-sweep
mkdir -p "$RESDIR"
COMMON="--halide-root /mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c \
  --halide-build /dev/shm/ardi_dslmut/halide16-build \
  --mull-output /mnt/scratch1/ardi/dsl_mut/mull-ps/output \
  --llvm-prefix /usr/lib/llvm-14 \
  --workdir /dev/shm/ardi_dslmut/apps-expansion-workdir"

for app in interpolate local_laplacian stencil_chain; do
  echo "===== FULL SWEEP: $app ====="
  date
  python3 -m mutation.halidemut $COMMON \
    --apps $app --arms all \
    --csv "$RESDIR/$app.csv" --summary "$RESDIR/$app.summary.txt" \
    --workers 16
  echo "===== DONE: $app (exit $?) ====="
done
echo "ALL_SECOND_WAVE_STAGE1_DONE"

for app in resize fft wavelet; do
  echo "===== FULL SWEEP: $app ====="
  date
  python3 -m mutation.halidemut $COMMON     --apps $app --arms all     --csv "$RESDIR/$app.csv" --summary "$RESDIR/$app.summary.txt"     --workers 16
  echo "===== DONE: $app (exit $?) ====="
done
echo "ALL_SECOND_WAVE_ARM_A_DONE"
