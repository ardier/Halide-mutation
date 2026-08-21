#!/usr/bin/env bash
# Full-corpus arm-C driver for swsec01. Phase 1 (lower) and phase 2
# (instrument+link) are embarrassingly parallel across apps and mostly
# single-threaded per app, so they run 8-wide; phase 3 (sweep) is already
# internally parallel, so apps go one at a time there.
set -u
cd "$(dirname "$0")"
LOG=/mnt/scratch1/ardi/dsl_mut/logs
mkdir -p "$LOG"
ALL="blur harris unsharp hist iir_blur max_filter bilateral_grid conv_layer depthwise_separable_conv nl_means lens_blur"
BROKEN="camera_pipe bgu"

echo "### phase 1: lower ($(date))"
printf "%s\n" $ALL $BROKEN | xargs -P 8 -I{} sh -c \
  "python3 arm_c_swsec.py lower {} > $LOG/lower-{}.log 2>&1; echo \"lower {} rc=\$?\""

echo "### phase 2: instrument + link ($(date))"
printf "%s\n" $ALL | xargs -P 8 -I{} sh -c \
  "python3 arm_c_swsec.py build {} > $LOG/build-{}.log 2>&1; echo \"build {} rc=\$?\""

echo "### phase 3: sweep ($(date))"
for a in $ALL; do
  python3 arm_c_swsec.py sweep "$a" > "$LOG/sweep-$a.log" 2>&1
  echo "sweep $a rc=$? :: $(tail -3 "$LOG/sweep-$a.log" | head -1)"
done

echo "### phase 4: re-verify the two C-backend-broken apps ($(date))"
python3 arm_c_swsec.py verify $BROKEN > "$LOG/verify.log" 2>&1
tail -20 "$LOG/verify.log"
echo "### done ($(date))"
