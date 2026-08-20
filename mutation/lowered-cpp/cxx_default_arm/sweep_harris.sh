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

echo "mutant_id,mutator,file,line,column,exit_code,o1_killed,o2_killed,wall_seconds" > "$OUT"
n=0
o1k=0
o2k=0
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
    o1k=$((o1k+1))
    o1=1
    o2=1   # crashed => no output to compare, and it's already a kill
  else
    o1=0
    if [ -f "$MUTOUT" ] && cmp -s "$MUTOUT" "$BASELINE"; then
      o2=0
    else
      o2=1
      o2k=$((o2k+1))
    fi
  fi
  echo "\"$key\",$mutator,$(basename "$file"),$line,$col,$rc,$o1,$o2,$wall" >> "$OUT"
  if [ $((n % 50)) -eq 0 ]; then
    echo "progress: $n mutants, o1_killed=$o1k o2_killed=$o2k so far" >&2
  fi
done < "$MUTLIST"
echo "DONE: total=$n o1_killed=$o1k o2_killed=$o2k" >&2
