#!/bin/bash
set -u
cd /mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c
OUT=mutation/generator-source-cxx_default_arm
MULLPS=/mnt/scratch1/ardi/dsl_mut/mull-ps
HB=/dev/shm/ardi_dslmut/halide16-build
mkdir -p "$OUT"

declare -A GEN=(
  [interpolate]="apps/interpolate/interpolate_generator.cpp"
  [local_laplacian]="apps/local_laplacian/local_laplacian_generator.cpp"
  [stencil_chain]="apps/stencil_chain/stencil_chain_generator.cpp"
  [resize]="apps/resize/resize_generator.cpp"
  [fft]="apps/fft/fft_generator.cpp"
  [wavelet_haar_x]="apps/wavelet/haar_x_generator.cpp"
  [linear_to_srgb]="apps/linear_blur/linear_to_srgb_generator.cpp"
  [simple_blur]="apps/linear_blur/simple_blur_generator.cpp"
  [srgb_to_linear]="apps/linear_blur/srgb_to_linear_generator.cpp"
  [linear_blur]="apps/linear_blur/linear_blur_generator.cpp"
)

for app in "${!GEN[@]}"; do
  src="${GEN[$app]}"
  echo "===== ARM B: $app ($src) ====="
  /usr/lib/llvm-14/bin/clang++ \
    -std=c++17 -fsyntax-only -g -grecord-command-line \
    -fplugin="$MULLPS/output/libmull-cxx-frontend-14.so" \
    -I "$HB/include" -I tools \
    -c "$src" \
    > "$OUT/${app}_points.txt" 2> "$OUT/${app}_points.err"
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "  COMPILE FAILED (rc=$rc), see ${app}_points.err"
    tail -5 "$OUT/${app}_points.err"
    continue
  fi
  python3 "$OUT/classify.py" "$OUT/${app}_points.txt" \
    "$(pwd)/$src" "$OUT/${app}_classified.csv"
done
echo "ARM_B_SECOND_WAVE_DONE"
