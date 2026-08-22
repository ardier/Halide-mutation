#!/bin/bash
# TARGET 3: Mull's AST route (the Clang plugin frontend) against EMITTED C++.
#
# The expectation is that it finds nothing: Mull's Halide_* AST mutators match
# Halide::Expr constructs -- operator+ on a Halide::Expr, select(), clamp(),
# compute_at -- and none of those survive lowering. Emitted C++ is plain scalar
# C with raw float/int arithmetic and no Halide type in sight.
#
# An expectation is not a result. The run below is paired with a POSITIVE
# CONTROL: the identical plugin, the identical mutator list and the identical
# config are also pointed at a GENERATOR source. If the control finds points
# and the emitted target finds none, the zero is a real property of lowered
# code. If the control ALSO finds none, the plugin is simply not working and
# the zero says nothing at all -- which is the failure mode this control
# exists to catch.
export LD_LIBRARY_PATH=
set -u

MULL_OUT=/mnt/scratch1/ardi/dsl_mut/mull-ps/output
PLUGIN=$MULL_OUT/libmull-cxx-frontend-14.so
CXX=/usr/lib/llvm-14/bin/clang++
ROOT=/mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c
BUILD=/mnt/scratch1/ardi/dsl_mut/HM-armc-fix/build
LOWERED=/mnt/scratch1/ardi/dsl_mut/HM-armc-fix/mutation/lowered-cpp
W=/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/t3
PIN="taskset -c 0-11,120-127"

mkdir -p "$W"

# Every Halide_* mutator mull-ps defines.
MUTATORS=$(grep -rho "Halide_[a-z_0-9]\+" \
    /mnt/scratch1/ardi/dsl_mut/mull-ps/lib \
    /mnt/scratch1/ardi/dsl_mut/mull-ps/include 2>/dev/null \
    | sort -u | grep -v "^Halide_$")

CFG=$W/mull.yml
{
  echo "mutators:"
  for m in $MUTATORS; do echo "  - $m"; done
  echo "timeout: 99999999"
  echo "quiet: true"
  echo "includePaths:"
  echo "  - .*"
} > "$CFG"
echo "mutators enabled: $(echo "$MUTATORS" | wc -l)"
echo "plugin: $PLUGIN"
md5sum "$PLUGIN"
echo

# count_points <label> <source> <extra-includes...>
count_points() {
    local label="$1"; shift
    local src="$1"; shift
    local obj="$W/$(echo "$label" | tr '/ ' '__').o"
    local err="$W/$(echo "$label" | tr '/ ' '__').err"
    MULL_CONFIG="$CFG" $PIN $CXX -std=c++17 \
        -I "$BUILD/include" -I "$ROOT/tools" "$@" \
        -O1 -g -grecord-command-line -Wno-psabi \
        -fplugin="$PLUGIN" -c "$src" -o "$obj" 2>"$err"
    local rc=$?
    if [ $rc -ne 0 ]; then
        echo "$label: COMPILE FAILED rc=$rc -- $(tail -1 "$err" | cut -c1-90)"
        return
    fi
    # Mull embeds one env-var key per mutation point into the object.
    local n
    n=$(strings "$obj" | grep -cE "^Halide_[a-z_0-9]+:/.+:[0-9]+:[0-9]+$")
    local sz
    sz=$(stat -c%s "$obj")
    echo "$label: $n points   (obj $((sz/1024)) KB)"
    rm -f "$obj"
}

echo "=== POSITIVE CONTROL: generator sources (Halide::Expr present) ==="
for app in blur iir_blur nl_means max_filter; do
    src=$(ls "$ROOT/apps/$app"/*_generator.cpp 2>/dev/null | head -1)
    [ -n "$src" ] && count_points "generator/$app" "$src"
done

echo
echo "=== TARGET 3: emitted C++ (already lowered) ==="
for app in blur iir_blur nl_means max_filter harris hist; do
    src=$(ls "$LOWERED/$app"/*.halide_generated.cpp 2>/dev/null | head -1)
    if [ -z "$src" ]; then echo "emitted/$app: NO LOWERED FILE"; continue; fi
    count_points "emitted/$app" "$src" -I "$(dirname "$src")"
done
