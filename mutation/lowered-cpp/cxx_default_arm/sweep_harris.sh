#!/usr/bin/env bash
# Sweeps every cxx_default mutant embedded in an instrumented harris filter
# binary. O1 (exit code) and O2 (byte-compare of out.png against a baseline
# snapshot) -- apps/harris/filter.cpp has no internal correctness assertion
# of its own, see README.md in this dir.
set -u
BIN=${BIN:?set BIN to the instrumented apps/harris filter binary}
MUTLIST=${MUTLIST:?set MUTLIST to the newline-separated mutant-id list}
IMG_IN=${IMG_IN:?set IMG_IN to apps/images/rgba.png}
BASELINE=${BASELINE:?set BASELINE to a golden out.png produced by an unmutated run}
OUT=${OUT:-harris-cxx_default.csv}
MUTOUT=${MUTOUT:-/tmp/harris_cxx_default_mut.png}
STDERR_SCRATCH=${STDERR_SCRATCH:-/tmp/harris_cxx_default_last.stderr}

echo "mutant_id,mutator,file,line,column,exit_code,test1_demo_killed,test2_golden_killed,wall_seconds" > "$OUT"
n=0
n_demo_kills=0
n_gold_kills=0
while IFS= read -r key; do
  [ -z "$key" ] && continue
  n=$((n+1))
  mutator=$(echo "$key" | cut -d: -f1)
  file=$(echo "$key" | cut -d: -f2)
  line=$(echo "$key" | cut -d: -f3)
  col=$(echo "$key" | cut -d: -f4)
  rm -f "$MUTOUT"
  t0=$(date +%s.%N)
  env "$key=1" timeout 30 "$BIN" "$IMG_IN" "$MUTOUT" > /dev/null 2>"$STDERR_SCRATCH"
  rc=$?
  t1=$(date +%s.%N)
  wall=$(echo "$t1 $t0" | awk '{printf "%.3f", $1-$2}')
  if [ "$rc" -ne 0 ]; then
    n_demo_kills=$((n_demo_kills+1))
    k_demo=1
    # Crashed, so nothing was written to compare against the snapshot. This
    # restates the test-1 kill rather than observing anything of its own.
    k_gold=1
  else
    k_demo=0
    if [ -f "$MUTOUT" ] && cmp -s "$MUTOUT" "$BASELINE"; then
      k_gold=0
    else
      k_gold=1
      n_gold_kills=$((n_gold_kills+1))
    fi
  fi
  echo "\"$key\",$mutator,$(basename "$file"),$line,$col,$rc,$k_demo,$k_gold,$wall" >> "$OUT"
  if [ $((n % 50)) -eq 0 ]; then
    echo "progress: $n mutants, test1_demo=$n_demo_kills test2_golden=$n_gold_kills so far" >&2
  fi
done < "$MUTLIST"
echo "DONE: total=$n test1_demo=$n_demo_kills test2_golden=$n_gold_kills" >&2
