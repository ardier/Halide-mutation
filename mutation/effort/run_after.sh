#!/bin/bash
# Re-run one app's SURVIVING generator mutants under an ADDED driver.
# Both drivers run against the same mutant artifacts, so before/after is a
# measured pair on one mutant.
export LD_LIBRARY_PATH=
set -u
P=/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/eff1
app=$1
drv=$2
art=${3-out.bin}
if [ "$art" = "NONE" ]; then art=""; fi
jobs=${4:-10}
argv=${5:-[]}
uids=${6:-$P/uids/$app.uids}
tag=${7:-after}
taskset -c 12-99 python3 "$P/effort_harness.py" \
  --app "$app" \
  --halide-root "$P/repo" \
  --halide-build /mnt/scratch1/ardi/dsl_mut/HM-armc-fix/build \
  --halidemut "$P/repo/mutation" \
  --tool /mnt/scratch1/ardi/dsl_mut/.priv-79c69961/bin/tool-c5b488d \
  --only-uids "$uids" \
  --after-driver "$drv" --after-args "$argv" --after-artifact "$art" \
  --out-csv "$P/out/$app-$tag.csv" \
  --scratch "/dev/shm/eff79-$app-$tag" --jobs "$jobs" \
  > "$P/logs/$app-$tag.log" 2>&1
rc=$?
echo "rc=$rc  $(grep -E '^mutants killed|^mutants run' "$P/logs/$app-$tag.log" | tr '\n' ' ')"
rm -rf "/dev/shm/eff79-$app-$tag"
