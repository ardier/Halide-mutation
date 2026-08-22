#!/bin/bash
# TARGET 2: the newly-lowered apps, placed in the AST-mutator x emitted-C++ arm.
#
# That arm is chosen over Mull's IR route on cost: ~1.5 s and ~140 MB per
# mutant here, against 6-11 GB per slice there, with ~95% of Mull's instrument
# time going to clang -O2 codegen over the inflated module rather than to Mull.
# For 8k-point apps that difference decides whether the cell gets data at all.
#
# Runs sequentially, one app at a time, because each app's emitted tree lives
# in tmpfs and only one fits comfortably beside the Target 1 sweep.
export LD_LIBRARY_PATH=
set -u

P=/mnt/scratch1/ardi/dsl_mut/.priv-79c69961
G=$P/gen2
ROOT=/mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c
BUILD=/mnt/scratch1/ardi/dsl_mut/HM-armc-fix/build
TOOL=$P/bin/tool-c5b488d
RT=$P/gen1/bin/runtime.a
PIN="taskset -c 0-11,120-127"

# Wait for the fft sweep to release its workers before starting the next app.
while pgrep -u "$(whoami)" -f "run_harness.py --app fft" >/dev/null 2>&1; do
    sleep 20
done

run_app() {  # name  emitted.cpp  lowered_dir  jobs
    local app="$1" emitted="$2" dir="$3" jobs="$4"
    local csv="$G/out/${app}-emitted.csv" log="$G/logs/${app}-emitted.log"
    if [ -s "$csv" ] && grep -q "^wall " "$log" 2>/dev/null; then
        echo "--- $app already complete, skipping"; return
    fi
    echo "--- $(date -Is) $app (jobs=$jobs)"
    $PIN python3 "$P/b1/run_harness.py" \
        --app "$app" \
        --halide-root "$ROOT" --halide-build "$BUILD" \
        --halidemut "$ROOT/mutation" --tool "$TOOL" \
        --emitted "$emitted" --lowered-dir "$dir" --runtime-a "$RT" \
        --ops=cxx_arith_swap,cxx_rel_swap \
        --out-csv "$csv" --scratch /dev/shm/emitmut79 \
        --jobs "$jobs" > "$log" 2>&1
    echo "    rc=$?  $(df -h /dev/shm | tail -1 | awk '{print "shm "$4" free"}')"
    tail -9 "$log" | sed 's/^/      /'
    rm -rf "/dev/shm/emitmut79/$app"
}

echo "=== $(date -Is) TARGET 2 START ==="

# resize: re-lowered locally as resize_box_uint8_down, because the instantiation
# on the corpus-gap-lowering branch is resize_linear_float32_up while apps.py
# registers resize_box_uint8_down and mutation_driver.cpp includes that header.
# Mutating the branch's file would have meant mutating a pipeline no registered
# driver can link.
run_app resize \
    "$G/lower/resize/resize_box_uint8_down.halide_generated.cpp" \
    "$G/lower/resize" 6

echo "=== $(date -Is) TARGET 2 END ==="
