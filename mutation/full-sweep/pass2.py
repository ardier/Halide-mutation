"""Second pass: fill in the cells pass 1 ran out of budget for.

Pass 1 ordered arms novel-first, so the truncation landed almost entirely on
the legacy IR-route families. This pass revisits only the app x family cells
that still have unevaluated mutants, in the reverse order -- biggest gap first
-- so the legacy arms get the budget this time.

Results go to <app>.pass2.csv. Pass 1's CSVs are left alone; the report merges
the two, preferring an evaluated row over a NOT_RUN one for the same mutant.
"""
import csv
import os
import subprocess
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path("/home/ardi/project/dsl_mutants/halide")
HAL = ROOT / "Halide-mutation-wip-c"
BUILD = ROOT / "Halide-mutation" / "build"
WORK = ROOT / "sweep-work"
RES = HAL / "mutation" / "results-full-sweep"
LOGS = WORK / "logs2"
LOGS.mkdir(parents=True, exist_ok=True)

sys.path.insert(0, str(HAL / "mutation"))
from halidemut.apps import APPS  # noqa: E402

ARM_ALL = ["arithmetic", "schedule", "generated",
           "boundary_conditions", "select_clamp", "if_then_else"]

HEAVY = ["bgu", "lens_blur", "camera_pipe"]
BUDGET = 600.0
# Pass 1's 780s backstop was shorter than the 900s a conv_layer or lens_blur
# driver run is allowed to take, so the between-mutant budget check never got a
# turn and those two were killed outright. Give the backstop enough room to let
# the budget do its job.
HARD_KILL = 1020.0
NORMAL_LANE_WIDTH = 3
NORMAL_WORKERS = 3
HEAVY_WORKERS = 2

ENV = dict(os.environ, HL_NUM_THREADS="4")
lock = threading.Lock()


def say(msg):
    with lock:
        print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def gaps():
    """(app -> [arm, ...]) for arms that still hold unevaluated mutants.

    Two shapes of gap, and only the first leaves a trace in the CSV:
      - the arm ran and was cut off part way, leaving NOT_RUN rows
      - the arm was never reached at all, so it has no rows anywhere and the
        stage-1 census is the only evidence it had mutants
    Missing the second kind would silently skip the largest gaps -- pass 1 never
    reached bilateral_grid's 198 arithmetic mutants at all.
    """
    import json
    import re
    census = json.loads((WORK / "census" / "census.json").read_text())

    # Pass 1 instrumented arms the census never reached, and some of those
    # yielded zero mutants. That is a real result but it leaves no row and no
    # census entry, so without reading it back out of pass 1's logs those arms
    # look "unknown" and pass 2 would burn its budget re-proving them empty.
    logged = {}
    for lg in (WORK / "logs").glob("*.log"):
        for m in re.finditer(r"^\[(\S+?)/(\S+?)\] (\d+) mutants$",
                             lg.read_text(errors="replace"), re.M):
            logged[(m.group(1), m.group(2))] = int(m.group(3))

    seen = {}
    for p in sorted(RES.glob("*.csv")):
        if p.name.endswith(".pass2.csv"):
            continue
        for r in csv.DictReader(p.open(newline="")):
            k = (r["app"], r["arm"])
            n, done = seen.get(k, (0, 0))
            seen[k] = (n + 1, done + (r["stage2"] != "NOT_RUN"))

    out = {}
    for app in APPS:
        counts = {}
        for arm in ARM_ALL:
            raw, done = seen.get((app, arm), (0, 0))
            if raw == 0:
                if (app, arm) in logged:
                    raw = logged[(app, arm)]
                    missing = raw - done
                    if missing > 0:
                        counts[arm] = missing
                    continue
                entry = census.get(app, {}).get(arm)
                if entry is None:
                    # Never censused and never run, so there is no evidence
                    # either way. Unknown is not zero: lens_blur's legacy arms
                    # land here because it was hard-killed before reaching them
                    # and the census never got to it. Revisit it.
                    counts[arm] = 10**6  # unknown: prioritise
                    continue
                raw = entry["n"]
            missing = raw - done
            if missing > 0:
                counts[arm] = missing
        if counts:
            out[app] = sorted(counts, key=lambda a: -counts[a])
    return out


GAPS = gaps()


def commit(app, status, dur, arms):
    msg = (f"results: {app} sweep pass 2, refilling truncated families "
           f"({status})\n\nFamilies revisited: {', '.join(arms)}.\n"
           f"Wall clock {dur/60:.1f} min against a {BUDGET/60:.0f} min budget.\n")
    try:
        subprocess.run(["git", "add", "-A", "mutation/results-full-sweep"],
                       cwd=str(HAL), check=True, capture_output=True)
        r = subprocess.run(["git", "-c", "user.name=Ardi Madadi",
                            "-c", "user.email=ardier@gmail.com",
                            "commit", "-q", "-m", msg],
                           cwd=str(HAL), capture_output=True)
        if r.returncode != 0 and b"nothing to commit" not in r.stdout + r.stderr:
            say(f"   commit for {app} failed: "
                f"{(r.stdout + r.stderr).decode()[:200]}")
    except Exception as exc:
        say(f"   commit for {app} errored: {exc}")


def run_app(app, workers):
    arms = GAPS.get(app, [])
    if not arms:
        return app, "NO_GAP", 0.0, []
    cmd = [sys.executable, "-m", "halidemut",
           "--halide-root", str(HAL), "--halide-build", str(BUILD),
           "--mull-output", str(ROOT / "mull-ps" / "output"),
           "--workdir", str(WORK / "run2" / app),
           "--apps", app, "--arms", ",".join(arms),
           "--csv", str(RES / f"{app}.pass2.csv"),
           "--summary", str(RES / f"{app}.pass2.summary.txt"),
           "--workers", str(workers), "--heavy-workers", str(workers),
           "--budget-seconds", str(BUDGET)]
    started = time.monotonic()
    say(f"== {app}: start ({','.join(arms)}, workers={workers})")
    status = "OK"
    with (LOGS / f"{app}.log").open("w") as fh:
        proc = subprocess.Popen(cmd, cwd=str(HAL / "mutation"), env=ENV,
                                stdout=fh, stderr=subprocess.STDOUT,
                                start_new_session=True)
        try:
            proc.wait(timeout=HARD_KILL)
        except subprocess.TimeoutExpired:
            status = "HARD_KILL"
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
    heavy = [a for a in HEAVY if a in GAPS]
    normal = [a for a in GAPS if a not in HEAVY]
    say(f"gaps in {len(GAPS)} apps: "
        + "; ".join(f"{a}:{','.join(v)}" for a, v in GAPS.items()))
    results = []
    with ThreadPoolExecutor(max_workers=2) as top:
        futs = [top.submit(lane, normal, NORMAL_LANE_WIDTH, NORMAL_WORKERS,
                           "normal"),
                top.submit(lane, heavy, 1, HEAVY_WORKERS, "heavy")]
        for f in futs:
            results += f.result()
    print("\n=== pass 2 done ===")
    for app, status, dur, arms in results:
        print(f"  {app:<28}{status:<12}{dur/60:>7.1f} min   {','.join(arms)}")
