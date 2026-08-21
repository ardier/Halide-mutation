#!/bin/bash
# Re-run the two sweeps whose CSVs lost rows when a git operation touched the
# results directory mid-write. Sequential, and NO git commands may run while
# this is active.
cd /mnt/scratch1/ardi/dsl_mut/HM-arith/mutation/experiment2
while ! grep -q BATCH_DONE logs/batch.log 2>/dev/null; do sleep 30; done
export HL_NUM_THREADS=4
COMMON="--halide-build /dev/shm/ardi_dslmut/halide16-build --mull-output /mnt/scratch1/ardi/dsl_mut/mull-ps/output"

python3 run_targets.py $COMMON --app iir_blur --arms arithmetic \
  --test-args "[]" --test-output-artifact "" \
  --workdir /dev/shm/ardi_dslmut/rerun-iir \
  --csv results/iir_blur-arith.csv > logs/iir_blur-arith.log 2>&1

python3 run_targets.py $COMMON --app depthwise_separable_conv --arms schedule \
  --test-driver apps/depthwise_separable_conv/mutation_test3.cpp \
  --test-output-artifact out.bin \
  --workdir /dev/shm/ardi_dslmut/rerun-t3 \
  --csv results/dwsc-schedule-t3.csv > logs/dwsc-t3.log 2>&1

echo "=== integrity check (csv effective rows vs log prints) ==="
python3 - <<'PY'
import csv, subprocess
for csvp, logp in (("results/iir_blur-arith.csv","logs/iir_blur-arith.log"),
                   ("results/dwsc-schedule-t3.csv","logs/dwsc-t3.log"),
                   ("results/lens_blur-arith-t2.csv","logs/lens_blur-t2.log"),
                   ("results/conv_layer.csv","logs/conv_layer.log")):
    try:
        rows = list(csv.DictReader(open(csvp)))
    except FileNotFoundError:
        print("%-34s MISSING" % csvp); continue
    log = open(logp).read().splitlines()
    for v in ("before","after"):
        c = sum(1 for x in rows if x["variant"]==v and x["effective"]=="1")
        l = sum(1 for x in log if x.startswith("   "+v))
        print("%-34s %-7s csv_eff=%-4d log_prints=%-4d %s" %
              (csvp, v, c, l, "OK" if c==l else "MISMATCH"))
PY
echo RERUN_DONE
