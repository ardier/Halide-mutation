#!/bin/bash
# Persist sweep output to git as it lands, unattended, overnight.
#
# The sweeps run under nohup and will outlive the session that started them.
# Committing by hand after each app is therefore not possible: nobody is here
# to do it. This does it instead -- every cycle it regenerates the derived
# artifacts, copies every CSV into the worktree, and commits and pushes if
# anything changed. A long app gets snapshot commits on the way through rather
# than one commit hours later, so an interruption costs one cycle rather than
# a whole app.
#
# It exits on its own once the sweeps are finished and one final commit has
# been made, so it does not linger.
export LD_LIBRARY_PATH=
set -u

P=/mnt/scratch1/ardi/dsl_mut/.priv-79c69961
G1=$P/gen1
G2=$P/gen2
WT=$P/wt/repo
D=$WT/mutation/ast-generator-route
INTERVAL="${1:-240}"
LOG=$G1/logs/autocommit.log

# Matches the sweep workers only. It deliberately does NOT match this script's
# own command line, which is autocommit.sh -- a pattern that matched itself
# would make this loop believe work was still running forever, and a pkill on
# such a pattern would kill the session that launched it.
SWEEP_RE='gen_harness\.py|run_harness\.py|run_gen_all\.sh|run_target2b?\.sh'

say() { echo "[$(date -Is)] $*" >> "$LOG"; }

idle_cycles=0
say "autocommit started, interval ${INTERVAL}s"

while true; do
    python3 "$G1/report.py"     > "$G1/logs/report.txt"     2>&1
    python3 "$G1/divergence.py" > "$G1/logs/divergence.txt" 2>&1

    mkdir -p "$D/results" "$D/scripts"
    cp "$G1"/out/*-gen.csv        "$D/results/" 2>/dev/null
    cp "$G2"/out/*-emitted.csv    "$D/results/" 2>/dev/null
    cp "$G1"/out/SUMMARY.csv      "$D/results/" 2>/dev/null
    cp "$G1"/out/COMPILER_DIVERGENCE.csv "$D/results/" 2>/dev/null
    cp "$G1"/logs/report.txt      "$D/results/report.txt" 2>/dev/null
    cp "$G1"/logs/divergence.txt  "$D/results/divergence.txt" 2>/dev/null
    cp "$G1"/gen_harness.py "$G1"/report.py "$G1"/status.py \
       "$G1"/divergence.py "$P"/gen2/autocommit.sh "$D/scripts/" 2>/dev/null

    cd "$WT" || { say "worktree missing"; exit 1; }
    git add -A mutation/ast-generator-route 2>/dev/null

    running=$(pgrep -u "$(whoami)" -f "$SWEEP_RE" | wc -l)

    if git diff --cached --quiet 2>/dev/null; then
        idle_cycles=$((idle_cycles + 1))
        say "no change (sweeps running: $running, idle cycles: $idle_cycles)"
        if [ "$running" -eq 0 ] && [ "$idle_cycles" -ge 2 ]; then
            say "sweeps finished and nothing left to commit -- exiting"
            exit 0
        fi
        sleep "$INTERVAL"
        continue
    fi
    idle_cycles=0

    STATUS=$(python3 "$G1/status.py" 2>/dev/null)
    {
        echo "mutation: incremental snapshot"
        echo
        echo "Committed automatically as results land, so nothing sits only on"
        echo "/mnt/scratch1. Sweeps still running: $running."
        echo
        echo "$STATUS"
    } | git -c user.name="ardi" -c user.email="ardi@localhost" \
            commit -q -F - 2>>"$LOG"

    if timeout 300 git push -q 2>>"$LOG"; then
        say "committed+pushed $(git rev-parse --short HEAD) (sweeps: $running)"
    else
        say "commit $(git rev-parse --short HEAD) made but PUSH FAILED; will retry next cycle"
    fi

    if [ "$running" -eq 0 ]; then
        say "sweeps finished; final commit made -- exiting"
        exit 0
    fi
    sleep "$INTERVAL"
done
