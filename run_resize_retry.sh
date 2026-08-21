#!/bin/bash
set -u
cd /mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c
python3 -m mutation.halidemut \
  --halide-root /mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c \
  --halide-build /dev/shm/ardi_dslmut/halide16-build \
  --mull-output /mnt/scratch1/ardi/dsl_mut/mull-ps/output \
  --llvm-prefix /usr/lib/llvm-14 \
  --workdir /dev/shm/ardi_dslmut/apps-expansion-workdir3 \
  --apps resize --arms all \
  --csv mutation/results-full-sweep/resize.csv \
  --summary mutation/results-full-sweep/resize.summary.txt \
  --workers 16
echo "RESIZE_RETRY_DONE (exit $?)"
