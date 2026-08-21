#!/usr/bin/env bash
# Builds BOTH forms from the ONE shared source file (oob_select_generator.cpp)
# and runs the shared killing test against each.
#
#   ORIGINAL = compiled WITHOUT any macro           -> uses Halide::select
#   MUTANT   = compiled WITH -DMUTANT_IF_THEN_ELSE   -> uses Call::if_then_else
#
# Usage:
#   HB=/path/to/halide/build ./build_and_test.sh
# (HB defaults to the swsec01 path this was developed against.)
set -euo pipefail
cd "$(dirname "$0")"

HB="${HB:-/dev/shm/ardi_dslmut/halide-build}"
CXX="${CXX:-c++}"

echo "Using Halide build at: $HB"
echo

$CXX -std=c++17 -I"$HB/include" -O0 -g -o original oob_select_generator.cpp \
    -L"$HB/src" -lHalide -Wl,-rpath,"$HB/src" -lpthread -ldl

$CXX -std=c++17 -DMUTANT_IF_THEN_ELSE -I"$HB/include" -O0 -g -o mutant oob_select_generator.cpp \
    -L"$HB/src" -lHalide -Wl,-rpath,"$HB/src" -lpthread -ldl

echo "=== ORIGINAL (select) ==="
set +e
LD_LIBRARY_PATH="$HB/src" ./original
orig_rc=$?
set -e
echo "exit code: $orig_rc"
echo

echo "=== MUTANT (if_then_else) ==="
set +e
LD_LIBRARY_PATH="$HB/src" ./mutant
mut_rc=$?
set -e
echo "exit code: $mut_rc"
echo

if [[ $orig_rc -eq 0 && $mut_rc -ne 0 ]]; then
    echo "VERDICT: mutant KILLED (test passes on original, fails on mutant)."
    exit 0
else
    echo "VERDICT: NOT a valid kill this run (orig_rc=$orig_rc mut_rc=$mut_rc) -- check output above."
    exit 1
fi
