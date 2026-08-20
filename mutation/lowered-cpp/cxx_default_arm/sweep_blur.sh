#!/usr/bin/env bash
# Sweeps every cxx_default mutant embedded in an instrumented blur test binary
# (one binary, N mutants behind env-var dispatch -- see README.md in this dir
# for how BIN and MUTLIST are produced). O1 only: apps/blur/test.cpp has its
# own internal assert/abort, no separate golden-output artifact for blur.
set -u
BIN=${BIN:?set BIN to the instrumented apps/blur test binary}
MUTLIST=${MUTLIST:?set MUTLIST to the newline-separated mutant-id list}
OUT=${OUT:-blur-cxx_default.csv}
STDERR_SCRATCH=${STDERR_SCRATCH:-/tmp/blur_cxx_default_last.stderr}

echo "mutant_id,mutator,file,line,column,exit_code,killed,wall_seconds" > "$OUT"
n=0
killed=0
while IFS= read -r key; do
  [ -z "$key" ] && continue
  n=$((n+1))
  mutator=$(echo "$key" | cut -d: -f1)
  file=$(echo "$key" | cut -d: -f2)
  line=$(echo "$key" | cut -d: -f3)
  col=$(echo "$key" | cut -d: -f4)
  t0=$(date +%s.%N)
  env "$key=1" timeout 30 "$BIN" > /dev/null 2>"$STDERR_SCRATCH"
  rc=$?
  t1=$(date +%s.%N)
  wall=$(echo "$t1 $t0" | awk '{printf "%.3f", $1-$2}')
  if [ "$rc" -ne 0 ]; then
    killed=$((killed+1))
    k=1
  else
    k=0
  fi
  echo "\"$key\",$mutator,$(basename "$file"),$line,$col,$rc,$k,$wall" >> "$OUT"
  if [ $((n % 50)) -eq 0 ]; then
    echo "progress: $n mutants, $killed killed so far" >&2
  fi
done < "$MUTLIST"
echo "DONE: total=$n killed=$killed survived=$((n-killed))" >&2
