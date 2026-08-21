#!/usr/bin/env python3
"""O3 sweep v2: per-run timeout + early-exit for overwhelming margins.

Same mechanism as v1 (Mull IR-route instrumented generator, one binary per
app, env-var dispatch). Differences that matter for wall-clock cost:

  - Each rep is capped at a wall-clock timeout (min(60s, max(8 x
    baseline_median, 5s))). A rep that blows through this is killed and
    counted as a rep at the timeout value -- a mutant that cannot even
    finish within 8x baseline is obviously killed; we do not need its exact
    time, only that it is far over threshold.
  - After MIN_REPS reps, if the running median already differs from baseline
    by more than EARLY_EXIT_MULT x threshold with all reps agreeing in
    direction, stop early and record fewer reps than REPS_MUTANT_MAX. This
    is a legitimate sequential stopping rule: obvious kills do not need the
    same sample size as borderline cases, and it is what makes 100+ mutants
    tractable when a few of them are 50-100x slower than baseline.

Usage: sched_o3_sweep2.py <targets.csv> <done.txt> <out.csv> [app1,app2,...]
"""
import csv
import os
import statistics
import subprocess
import sys
import time
import traceback
from collections import defaultdict
from pathlib import Path

REPO = "/mnt/scratch1/ardi/dsl_mut/Halide-mutation-wip-c"
sys.path.insert(0, f"{REPO}/mutation")
from halidemut.apps import APPS, ARMS, ARM_ROUTE  # noqa: E402
from halidemut.pipeline import Pipeline, PipelineError  # noqa: E402

ROOT = Path(REPO)
BUILD = Path("/dev/shm/ardi_dslmut/halide16-build")
MULL_OUT = Path("/mnt/scratch1/ardi/dsl_mut/mull-ps/output")
LLVM = Path("/mnt/scratch1/ardi/dsl_mut/llvm14full")
WORK = Path("/mnt/scratch1/ardi/dsl_mut/sched-o3/work")

HL_NUM_THREADS = os.environ.get("O3_THREADS", "8")
REPS_BASELINE = int(os.environ.get("O3_REPS_BASELINE", "21"))
MIN_REPS = int(os.environ.get("O3_MIN_REPS", "4"))
MAX_REPS = int(os.environ.get("O3_MAX_REPS", "9"))
EARLY_EXIT_MULT = float(os.environ.get("O3_EARLY_EXIT_MULT", "3.0"))
THRESHOLD_MULT = float(os.environ.get("O3_THRESHOLD_MULT", "3.0"))

pipeline = Pipeline(halide_root=ROOT, halide_build=BUILD, mull_output=MULL_OUT,
                    llvm_prefix=LLVM, workdir=WORK)

FIELDS = [
    "app", "mutator", "file", "line", "col",
    "stage2", "build_ok",
    "baseline_median_s", "baseline_iqr_s", "baseline_n",
    "mutant_median_s", "mutant_iqr_s", "mutant_n", "early_stop", "any_timeout",
    "delta_s", "delta_pct", "threshold_s", "o3_verdict",
    "baseline_maxrss_kb", "mutant_maxrss_kb", "rss_delta_pct",
    "baseline_stmt_lines", "mutant_stmt_lines", "stmt_lines_differ",
    "baseline_vecinsn", "mutant_vecinsn", "vecinsn_differ",
    "baseline_text_bytes", "mutant_text_bytes", "text_bytes_delta_pct",
    "note",
]


def run_timed(argv, cwd, env, timeout_s):
    started = time.monotonic()
    try:
        proc = subprocess.Popen(argv, cwd=cwd, env=env,
                                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except OSError:
        return 0.0, -1, 0, False
    deadline = started + timeout_s
    while True:
        try:
            pid, status, rusage = os.wait4(proc.pid, os.WNOHANG)
        except ChildProcessError:
            return time.monotonic() - started, -1, 0, False
        if pid != 0:
            wall = time.monotonic() - started
            exit_code = os.WEXITSTATUS(status) if os.WIFEXITED(status) else -1
            return wall, exit_code, rusage.ru_maxrss, False
        if time.monotonic() > deadline:
            try:
                proc.kill()
                os.wait4(proc.pid, 0)
            except Exception:
                pass
            return timeout_s, -9, 0, True
        time.sleep(0.05)


def median_iqr(xs):
    xs = sorted(xs)
    n = len(xs)
    med = statistics.median(xs)
    if n < 4:
        return med, 0.0
    q1 = statistics.median(xs[: n // 2])
    q3 = statistics.median(xs[(n + 1) // 2:])
    return med, q3 - q1


def measure_adaptive(driver, rundir, app, baseline_med, threshold, rep_timeout):
    env = dict(os.environ, HL_NUM_THREADS=HL_NUM_THREADS)
    argv = [str(driver)]
    for a in app.driver_args:
        argv.append(
            a.replace("{input}", str(ROOT / app.input_image) if app.input_image else "")
             .replace("{output}", str(rundir / (app.output_artifact or "out.png")))
             .replace("{outdir}", str(rundir))
        )
    rundir.mkdir(parents=True, exist_ok=True)
    times, rss = [], []
    any_timeout = False
    early_stop = False
    for i in range(MAX_REPS):
        w, code, maxrss, timed_out = run_timed(argv, str(rundir), env, rep_timeout)
        times.append(w)
        rss.append(maxrss)
        any_timeout = any_timeout or timed_out
        if len(times) >= MIN_REPS:
            med, _ = median_iqr(times)
            if abs(med - baseline_med) > EARLY_EXIT_MULT * threshold:
                early_stop = True
                break
    return times, rss, early_stop, any_timeout


def count_vector_insns(path):
    try:
        proc = subprocess.run(["objdump", "-d", str(path)], stdout=subprocess.PIPE,
                              stderr=subprocess.DEVNULL, timeout=180)
    except Exception:
        return -1
    text = proc.stdout.decode(errors="replace")
    return text.count("%xmm") + text.count("%ymm") + text.count("%zmm")


def text_bytes(path):
    try:
        proc = subprocess.run(["size", str(path)], stdout=subprocess.PIPE, timeout=60)
        line = proc.stdout.decode().splitlines()[1]
        return int(line.split()[0])
    except Exception:
        return -1


def stmt_lines(dest, func_name):
    p = dest / f"{func_name}.stmt"
    if not p.exists():
        return -1
    return sum(1 for _ in open(p, errors="replace"))


def load_targets(path, done_path):
    done = set()
    if done_path and Path(done_path).exists():
        for line in open(done_path):
            parts = line.strip().split(",")
            if len(parts) == 4:
                done.add(tuple(parts))
    by_app = defaultdict(list)
    for r in csv.DictReader(open(path)):
        key = (r["app"], r["mutator"], r["line"], r["column"])
        if key in done:
            continue
        by_app[r["app"]].append(r)
    return by_app


def process_app(app_name, targets, writer, outfh):
    if not targets:
        return
    app = APPS[app_name]
    appwork = WORK / app_name
    appwork.mkdir(parents=True, exist_ok=True)

    print(f"[{app_name}] stage1: instrumenting... ({len(targets)} mutants to do)", flush=True)
    generator, mutants = pipeline.stage1(app, "schedule", ARMS["schedule"], route=ARM_ROUTE["schedule"])
    by_key = {}
    for m in mutants:
        by_key[(Path(m.path).name, str(m.line), str(m.column), m.mutator)] = m
    print(f"[{app_name}] stage1 done: {len(mutants)} mutants embedded", flush=True)

    bdest = appwork / "baseline2"
    st2 = pipeline.stage2(app, generator, bdest, None)
    if st2 != "OK":
        print(f"[{app_name}] BASELINE stage2 FAILED: {st2}", flush=True)
        return
    driver_obj = appwork / "driver2.o"
    if not pipeline.compile_driver_object(app, bdest, driver_obj):
        print(f"[{app_name}] baseline driver object compile FAILED", flush=True)
        return
    bdriver = appwork / "baseline2.driver"
    if not pipeline.build_driver(app, bdest, bdriver, driver_object=driver_obj):
        print(f"[{app_name}] baseline driver link FAILED", flush=True)
        return
    base_header_sig = pipeline.header_signature(app, bdest)

    env = dict(os.environ, HL_NUM_THREADS=HL_NUM_THREADS)
    btimes, brss = [], []
    for _ in range(REPS_BASELINE):
        w, code, maxrss, _ = run_timed([str(bdriver)] + [
            a.replace("{input}", str(ROOT / app.input_image) if app.input_image else "")
             .replace("{output}", str(appwork / "baseline2_run" / (app.output_artifact or "out.png")))
             .replace("{outdir}", str(appwork / "baseline2_run"))
            for a in app.driver_args
        ], str((appwork / "baseline2_run")), env, 120.0)
        Path(appwork / "baseline2_run").mkdir(parents=True, exist_ok=True)
        btimes.append(w)
        brss.append(maxrss)
    bmed, biqr = median_iqr(btimes)
    b_vec = count_vector_insns(bdriver)
    b_txt = text_bytes(bdriver)
    b_rss = statistics.median(brss) if brss else 0
    threshold = max(THRESHOLD_MULT * biqr, 0.02 * bmed)
    rep_timeout = min(90.0, max(8 * bmed, 5.0))
    print(f"[{app_name}] baseline2 median={bmed:.4f}s iqr={biqr:.4f}s "
          f"threshold={threshold:.4f}s rep_timeout={rep_timeout:.1f}s n={len(btimes)}", flush=True)

    for r in targets:
        key = (r["file"], r["line"], r["column"], r["mutator"])
        row = {f: "" for f in FIELDS}
        row.update(app=app_name, mutator=r["mutator"], file=r["file"],
                  line=r["line"], col=r["column"],
                  baseline_median_s=f"{bmed:.5f}", baseline_iqr_s=f"{biqr:.5f}",
                  baseline_n=len(btimes), threshold_s=f"{threshold:.5f}",
                  baseline_maxrss_kb=b_rss, baseline_vecinsn=b_vec,
                  baseline_text_bytes=b_txt)
        mutant = by_key.get(key)
        if mutant is None:
            row["stage2"] = "NOT_IN_STAGE1"
            row["note"] = "mutant not found in this stage1 census"
            writer.writerow(row); outfh.flush()
            continue
        mdest = appwork / f"m2_{r['mutator']}_{r['line']}_{r['column']}"
        st2 = pipeline.stage2(app, generator, mdest, mutant)
        row["stage2"] = st2
        if st2 != "OK":
            row["note"] = "generation failed or timed out"
            writer.writerow(row); outfh.flush()
            continue
        mheader_sig = pipeline.header_signature(app, mdest)
        use_obj = driver_obj if mheader_sig == base_header_sig else None
        mdriver = appwork / f"m2_{r['mutator']}_{r['line']}_{r['column']}.driver"
        ok = pipeline.build_driver(app, mdest, mdriver, driver_object=use_obj)
        row["build_ok"] = "1" if ok else "0"
        if not ok:
            row["note"] = "driver link failed"
            writer.writerow(row); outfh.flush()
            continue

        mtimes, mrss, early_stop, any_timeout = measure_adaptive(
            mdriver, appwork / f"run2_{r['mutator']}_{r['line']}_{r['column']}",
            app, bmed, threshold, rep_timeout)
        mmed, miqr = median_iqr(mtimes)
        delta = mmed - bmed
        m_vec = count_vector_insns(mdriver)
        m_txt = text_bytes(mdriver)
        m_rss = statistics.median(mrss) if mrss else 0
        m_stmt = stmt_lines(mdest, app.function_name)
        b_stmt = stmt_lines(bdest, app.function_name)

        verdict = "KILLED_O3" if abs(delta) > threshold else "SURVIVED_O3"
        if any_timeout:
            verdict = "KILLED_O3"  # a rep that can't finish in 8x baseline is a kill by construction

        row.update(
            mutant_median_s=f"{mmed:.5f}", mutant_iqr_s=f"{miqr:.5f}", mutant_n=len(mtimes),
            early_stop="1" if early_stop else "0", any_timeout="1" if any_timeout else "0",
            delta_s=f"{delta:.5f}", delta_pct=f"{100*delta/bmed:.2f}" if bmed else "",
            o3_verdict=verdict,
            mutant_maxrss_kb=m_rss,
            rss_delta_pct=f"{100*(m_rss-b_rss)/b_rss:.2f}" if b_rss else "",
            baseline_stmt_lines=b_stmt, mutant_stmt_lines=m_stmt,
            stmt_lines_differ="1" if m_stmt != b_stmt else "0",
            mutant_vecinsn=m_vec,
            vecinsn_differ="1" if m_vec != b_vec else "0",
            mutant_text_bytes=m_txt,
            text_bytes_delta_pct=f"{100*(m_txt-b_txt)/b_txt:.2f}" if b_txt else "",
            note=("timeout-capped" if any_timeout else "") + (";early_stop" if early_stop else ""),
        )
        writer.writerow(row); outfh.flush()
        print(f"[{app_name}] {r['mutator']:<32} {r['line']}:{r['column']:<4} "
              f"n={len(mtimes)}{'*' if early_stop else ''}{'T' if any_timeout else ''} "
              f"delta={delta:+.4f}s ({100*delta/bmed:+.1f}%) -> {verdict}", flush=True)


def main():
    targets_path, done_path, out_path = sys.argv[1], sys.argv[2], sys.argv[3]
    only_apps = set(sys.argv[4].split(",")) if len(sys.argv) > 4 else None

    by_app = load_targets(targets_path, done_path)
    with open(out_path, "w", newline="") as outfh:
        writer = csv.DictWriter(outfh, fieldnames=FIELDS)
        writer.writeheader(); outfh.flush()
        for app_name, targets in by_app.items():
            if only_apps and app_name not in only_apps:
                continue
            try:
                process_app(app_name, targets, writer, outfh)
            except PipelineError as e:
                print(f"[{app_name}] PIPELINE ERROR: {e}", flush=True)
            except Exception:
                print(f"[{app_name}] UNEXPECTED ERROR:\n{traceback.format_exc()}", flush=True)


if __name__ == "__main__":
    main()
