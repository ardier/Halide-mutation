"""Drive the full 65-operator sweep across the corpus.

Each benchmark is timeboxed. Results stream to CSV as they land, so a benchmark
that runs out of budget still contributes everything it managed to evaluate,
and its unevaluated mutants are recorded as NOT_RUN rather than vanishing.

Two lanes:
  normal  several app-processes at once
  heavy   one app-process at a time (bgu / lens_blur / camera_pipe -- the apps
          the thesis reports needing swap at 32GB)

Arms with zero mutation points for an app (from the stage-1 census) are skipped
rather than paying a pointless instrumentation compile; the census file is the
record that they were zero.
"""
import json
import os
import subprocess
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path("/home/ardi/project/dsl_mutants/halide")
HAL = ROOT / "Halide-mutation-wip-c"
# The Halide build tree is untracked, so it lives in the original worktree
# only and is shared rather than duplicated.
BUILD = ROOT / "Halide-mutation" / "build"
WORK = ROOT / "sweep-work"
RES = WORK / "results"
LOGS = WORK / "logs"
RES.mkdir(parents=True, exist_ok=True)
LOGS.mkdir(parents=True, exist_ok=True)

CENSUS = json.loads((WORK / "census" / "census.json").read_text())

# The app list comes from the pipeline's own config, not from the census: the
# census is incomplete and an app missing from it still has to be swept.
sys.path.insert(0, str(HAL / "mutation"))
from halidemut.apps import APPS  # noqa: E402

HEAVY = [a for a in ["bgu", "lens_blur", "camera_pipe"] if a in APPS]
NORMAL = [a for a in APPS if a not in HEAVY]

# Novel operators first. If a benchmark runs out of budget the truncation lands
# on the legacy arithmetic arm, which is both the largest and the one already
# well characterised, rather than on the families this study is actually about.
ARM_PRIORITY = ["boundary_conditions", "if_then_else", "select_clamp",
                "schedule", "generated", "arithmetic"]

BUDGET = 600.0          # per-benchmark wall-clock budget the runner honours
HARD_KILL = 780.0       # backstop if the runner is wedged somewhere untimed
NORMAL_LANE_WIDTH = 3
NORMAL_WORKERS = 3
HEAVY_WORKERS = 2

ENV = dict(os.environ)
# Cap Halide's runtime thread pool so the .parallel() schedules in the drivers
# do not each try to take all 16 cores while several apps run side by side.
# Applied identically to the baseline and to every mutant, so O2 is unaffected.
ENV["HL_NUM_THREADS"] = "4"

lock = threading.Lock()


def say(msg):
    with lock:
        print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def commit(app, status, dur, arms):
    """One commit per benchmark, as its results land."""
    msg = (
        f"results: {app} full-operator sweep ({status})\n"
        f"\n"
        f"65 Halide-native operators, target=host, {len(arms)} non-empty "
        f"operator families: {', '.join(arms)}.\n"
        f"Wall clock {dur/60:.1f} min against a {BUDGET/60:.0f} min budget.\n"
    )
    if status == "TIMEBOX":
        msg += ("Hit the budget: mutants recorded as NOT_RUN were never "
                "evaluated and are excluded from every rate.\n")
    try:
        subprocess.run(["git", "add", "-A", "mutation/results-full-sweep"],
                       cwd=str(HAL), check=True, capture_output=True)
        r = subprocess.run(
            ["git", "-c", "user.name=Ardi Madadi",
             "-c", "user.email=ardier@gmail.com",
             "commit", "-q", "-m", msg],
            cwd=str(HAL), capture_output=True)
        if r.returncode != 0 and b"nothing to commit" not in r.stdout + r.stderr:
            say(f"   commit for {app} failed: "
                f"{(r.stdout + r.stderr).decode()[:200]}")
    except Exception as exc:
        say(f"   commit for {app} errored: {exc}")


def arms_for(app):
    """Arms worth running for an app.

    A censused arm that recorded zero mutation points is skipped: the census is
    the record that it was zero. An arm with no census entry is *not* assumed
    zero -- it is run. Censusing it separately would cost exactly the same
    instrumentation compile as running it, so there is nothing to save by
    finding out first, and guessing from the source text risks silently
    dropping real mutants.
    """
    census = CENSUS.get(app, {})
    out = []
    for arm in ARM_PRIORITY:
        entry = census.get(arm)
        if entry is None or entry["n"] != 0:
            out.append(arm)
    return out


def run_app(app, workers):
    arms = arms_for(app)
    if not arms:
        say(f"== {app}: no mutants in any arm, skipping")
        return app, "NO_MUTANTS", 0.0, []
    dest = HAL / "mutation" / "results-full-sweep"
    dest.mkdir(parents=True, exist_ok=True)
    cmd = [
        sys.executable, "-m", "halidemut",
        "--halide-root", str(HAL),
        "--halide-build", str(BUILD),
        "--mull-output", str(ROOT / "mull-ps" / "output"),
        "--workdir", str(WORK / "run" / app),
        "--apps", app,
        "--arms", ",".join(arms),
        "--csv", str(dest / f"{app}.csv"),
        "--summary", str(dest / f"{app}.summary.txt"),
        "--workers", str(workers),
        "--heavy-workers", str(workers),
        "--budget-seconds", str(BUDGET),
    ]
    started = time.monotonic()
    say(f"== {app}: start ({len(arms)} arms: {','.join(arms)}, workers={workers})")
    status = "OK"
    with (LOGS / f"{app}.log").open("w") as fh:
        proc = subprocess.Popen(cmd, cwd=str(HAL / "mutation"), env=ENV,
                                stdout=fh, stderr=subprocess.STDOUT,
                                start_new_session=True)
        try:
            proc.wait(timeout=HARD_KILL)
        except subprocess.TimeoutExpired:
            status = "HARD_KILL"
            say(f"== {app}: exceeded {HARD_KILL/60:.0f} min hard limit, killing")
            os.killpg(os.getpgid(proc.pid), 15)
            try:
                proc.wait(timeout=30)
            except subprocess.TimeoutExpired:
                os.killpg(os.getpgid(proc.pid), 9)
    dur = time.monotonic() - started
    if status == "OK":
        if proc.returncode != 0:
            status = f"EXIT{proc.returncode}"
        elif dur > BUDGET:
            status = "TIMEBOX"
    say(f"== {app}: {status} in {dur/60:.1f} min")
    commit(app, status, dur, arms)
    return app, status, dur, arms


def lane(apps, width, workers, name):
    out = []
    with ThreadPoolExecutor(max_workers=width) as pool:
        for res in pool.map(lambda a: run_app(a, workers), apps):
            out.append(res)
    say(f"### lane {name} complete")
    return out


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    results = []
    with ThreadPoolExecutor(max_workers=2) as top:
        futs = []
        if which in ("all", "normal"):
            futs.append(top.submit(lane, NORMAL, NORMAL_LANE_WIDTH,
                                   NORMAL_WORKERS, "normal"))
        if which in ("all", "heavy"):
            futs.append(top.submit(lane, HEAVY, 1, HEAVY_WORKERS, "heavy"))
        for f in futs:
            results += f.result()
    print("\n=== sweep done ===")
    for app, status, dur, arms in results:
        print(f"  {app:<28}{status:<12}{dur/60:>7.1f} min   {','.join(arms)}")
