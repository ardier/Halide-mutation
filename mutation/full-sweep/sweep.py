"""Drive the IR-route operator sweep across the corpus on the new stack.

New stack: Mull 0.34.0 (Bazel) + Halide v21.0.0 + LLVM 20. Only the IR-route
operator families are run -- arithmetic (12), schedule directives (8) and the
census-driven expansion (30), 50 operators in all. The AST route is blocked on
this Mull by an upstream ClangASTMutator parent-lookup assertion and is out of
scope here.

Each benchmark is timeboxed, and the box covers mutant evaluation only:
instrumentation and the baseline build are credited back (see Budget in
halidemut/run.py). Results stream to CSV as they land, so a benchmark that runs
out of budget still contributes everything it evaluated and its unevaluated
mutants are recorded as NOT_RUN rather than vanishing.

Paths come from the environment so the driver is not tied to one machine.
"""
import os
import subprocess
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(os.environ.get("DSLMUT_ROOT", "/mnt/scratch1/ardi/dsl_mut"))
HAL = Path(os.environ.get("DSLMUT_RESULTS_REPO", ROOT / "Halide-mutation"))
HALIDE_ROOT = Path(os.environ.get("DSLMUT_HALIDE_ROOT",
                                  ROOT / "upgrade-latest" / "halide-latest"))
BUILD = Path(os.environ.get("DSLMUT_HALIDE_BUILD", HALIDE_ROOT / "build"))
MULL_BIN = Path(os.environ.get("DSLMUT_MULL_BIN",
                               ROOT / "upgrade-latest" / "mull-latest" / "bazel-bin"))
LLVM_PREFIX = Path(os.environ.get("DSLMUT_LLVM_PREFIX",
                                  ROOT / "llvmroot" / "usr" / "lib" / "llvm-20"))
# Build and scratch directories live on tmpfs: this pipeline is dominated by
# short-lived compiler output, and there is no root on this host to mount a
# dedicated one, so /dev/shm is it.
WORK = Path(os.environ.get("DSLMUT_WORK", "/dev/shm/ardi_dslmut/sweep-work"))

RES = HAL / "mutation" / "results-full-sweep"
LOGS = WORK / "logs"
RES.mkdir(parents=True, exist_ok=True)
LOGS.mkdir(parents=True, exist_ok=True)

sys.path.insert(0, str(HAL / "mutation"))
from halidemut.apps import APPS  # noqa: E402

# Novel operators first. If a benchmark runs out of budget the truncation lands
# on the legacy arithmetic arm -- the largest, and the one already best
# characterised -- rather than on the families this study is about.
ARMS = "generated,schedule,arithmetic"

BUDGET = float(os.environ.get("DSLMUT_BUDGET", 600))   # sweep-only wall clock
HARD_KILL = BUDGET + 900          # backstop if the runner wedges somewhere untimed

# Core budget. This is a shared machine and the cap is 100 of its 128 cores, so
# workers x HL_NUM_THREADS is kept under it rather than left to chance.
HL_THREADS = int(os.environ.get("DSLMUT_HL_THREADS", 4))
HEAVY_WORKERS = int(os.environ.get("DSLMUT_HEAVY_WORKERS", 12))   # 12*4 = 48
NORMAL_WORKERS = int(os.environ.get("DSLMUT_NORMAL_WORKERS", 6))  # 3*6*4 = 72
NORMAL_LANE_WIDTH = int(os.environ.get("DSLMUT_LANE_WIDTH", 3))

ENV = dict(os.environ)
# Cap Halide's runtime thread pool so the .parallel() schedules in the drivers
# do not each try to take the whole machine. Applied identically to the baseline
# and to every mutant, so O2 is unaffected.
ENV["HL_NUM_THREADS"] = str(HL_THREADS)

lock = threading.Lock()


def say(msg):
    with lock:
        print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def git(args, **kw):
    return subprocess.run(["git"] + args, cwd=str(HAL), capture_output=True, **kw)


def commit(app, status, dur, setup_note=""):
    """One commit per benchmark, as its results land."""
    msg = (
        f"results: {app} IR-route operator sweep ({status})\n"
        f"\n"
        f"50 Halide-native IR-route operators (arithmetic, schedule directives,\n"
        f"census-driven expansion) on Mull 0.34.0 + Halide v21.0.0 + LLVM 20,\n"
        f"target=host. Wall clock {dur/60:.1f} min against a {BUDGET/60:.0f} min\n"
        f"sweep budget.\n"
    )
    if setup_note:
        msg += setup_note
    if status == "TIMEBOX":
        msg += ("\nHit the budget: mutants recorded as NOT_RUN were never "
                "evaluated and are excluded from every rate.\n")
    git(["add", "-A", "mutation/results-full-sweep", "mutation/halidemut",
         "mutation/full-sweep"])
    r = git(["-c", "user.name=Ardi Madadi", "-c", "user.email=ardier@gmail.com",
             "commit", "-q", "-m", msg])
    if r.returncode != 0 and b"nothing to commit" not in r.stdout + r.stderr:
        say(f"   commit for {app} failed: {(r.stdout + r.stderr).decode()[:200]}")
    else:
        say(f"   committed {app}")


def push():
    r = git(["push", "-q", "origin", "wip-d"])
    say("   pushed" if r.returncode == 0
        else f"   push failed: {(r.stdout + r.stderr).decode()[:200]}")


def run_app(app, workers):
    cmd = [
        sys.executable, "-m", "halidemut",
        "--halide-root", str(HALIDE_ROOT),
        "--halide-build", str(BUILD),
        "--mull-output", str(MULL_BIN),
        "--llvm-prefix", str(LLVM_PREFIX),
        "--workdir", str(WORK / "run" / app),
        "--apps", app,
        "--arms", ARMS,
        "--csv", str(RES / f"{app}.csv"),
        "--summary", str(RES / f"{app}.summary.txt"),
        "--workers", str(workers),
        "--heavy-workers", str(workers),
        "--budget-seconds", str(BUDGET),
    ]
    started = time.monotonic()
    say(f"== {app}: start (workers={workers}, HL_NUM_THREADS={HL_THREADS})")
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
                proc.wait(timeout=60)
            except subprocess.TimeoutExpired:
                os.killpg(os.getpgid(proc.pid), 9)
    dur = time.monotonic() - started
    if status == "OK" and proc.returncode != 0:
        status = f"EXIT{proc.returncode}"
    log = (LOGS / f"{app}.log").read_text(errors="replace")
    if "budget exhausted" in log and status == "OK":
        status = "TIMEBOX"
    setup_note = ""
    for line in log.splitlines():
        if "not charged to the sweep budget" in line:
            setup_note += "\n" + line.split("] ", 1)[-1] + "\n"
    say(f"== {app}: {status} in {dur/60:.1f} min")
    commit(app, status, dur, setup_note)
    return app, status, dur


def lane(apps, width, workers, name):
    out = []
    if width == 1:
        for a in apps:
            out.append(run_app(a, workers))
    else:
        with ThreadPoolExecutor(max_workers=width) as pool:
            for res in pool.map(lambda a: run_app(a, workers), apps):
                out.append(res)
    say(f"### lane {name} complete")
    push()
    return out


if __name__ == "__main__":
    requested = sys.argv[1:]
    if not requested:
        sys.exit("usage: sweep.py <app> [<app> ...] | heavy | normal | all")
    if requested == ["all"]:
        requested = ["heavy", "normal"]
    results = []
    heavy_apps = [a for a in ["bgu", "lens_blur", "camera_pipe"] if a in APPS]
    for token in requested:
        if token == "heavy":
            results += lane(heavy_apps, 1, HEAVY_WORKERS, "heavy")
        elif token == "normal":
            results += lane([a for a in APPS if a not in heavy_apps
                             and a != "c_backend"],
                            NORMAL_LANE_WIDTH, NORMAL_WORKERS, "normal")
        else:
            if token not in APPS:
                sys.exit(f"unknown app {token}")
            w = HEAVY_WORKERS if APPS[token].memory_heavy else NORMAL_WORKERS
            results.append(run_app(token, w))
            push()
    print("\n=== sweep done ===")
    for app, status, dur in results:
        print(f"  {app:<28}{status:<12}{dur/60:>7.1f} min")
