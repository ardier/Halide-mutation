#!/bin/bash
# TARGET 1: AST mutator x Halide GENERATOR source, with oracles.
#
# Apps are ordered by the number of halide_* generator points recorded in the
# census, cheapest first, so that an interruption leaves the largest number of
# COMPLETE apps behind rather than one big half-finished one. Each app writes
# its own CSV and its own log; a failing app never blocks the next one.
#
# Cores: 0-11,120-127 only. Track A's worker processes take 12-119.
export LD_LIBRARY_PATH=
set -u

G=/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen1
ROOT=/mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c
BUILD=/mnt/scratch1/ardi/dsl_mut/HM-armc-fix/build
TOOL=/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/bin/tool-c5b488d
PIN="taskset -c 0-11,120-127"

# app:jobs -- the four biggest generators compile a lot of Halide IR per run,
# so they get fewer concurrent generator processes.
APPS="conv_layer:6 stencil_chain:6 blur:6 iir_blur:6 nl_means:6 max_filter:6
      depthwise_separable_conv:6 hist:6 interpolate:5 unsharp:6
      bilateral_grid:5 harris:5 local_laplacian:3 lens_blur:3 bgu:4
      camera_pipe:3"

mkdir -p "$G/out" "$G/logs"
echo "=== $(date -Is) TARGET 1 START ==="

for entry in $APPS; do
    app="${entry%%:*}"
    jobs="${entry##*:}"
    csv="$G/out/${app}-gen.csv"
    log="$G/logs/${app}-gen.log"
    if [ -s "$csv" ] && grep -q "^wall " "$log" 2>/dev/null; then
        echo "--- $app: already complete, skipping"
        continue
    fi
    echo "--- $(date -Is) $app (jobs=$jobs)"
    $PIN python3 "$G/gen_harness.py" \
        --app "$app" \
        --halide-root "$ROOT" \
        --halide-build "$BUILD" \
        --halidemut "$ROOT/mutation" \
        --tool "$TOOL" \
        --out-csv "$csv" \
        --scratch /dev/shm/genmut79 \
        --jobs "$jobs" > "$log" 2>&1
    rc=$?
    tail -3 "$log" | sed 's/^/      /'
    echo "    rc=$rc  $(df -h /dev/shm | tail -1 | awk '{print "shm "$4" free"}')"
    rm -rf "/dev/shm/genmut79/$app"
done

echo "=== $(date -Is) TARGET 1 END ==="
