#!/usr/bin/env python3
"""O3 performance oracle sweep over the 110 unresolved schedule mutants.

Reads a targets CSV (app,mutator,file,line,col) grouped by app, builds each
app's instrumented generator once, measures baseline noise, then for every
targeted mutant: emits artifacts, links a driver, times it, and records
peak RSS / .stmt line count / vector-instruction count / .text size relative
to baseline. Streams results to CSV as it goes (one flush per row).

Usage: sched_o3_sweep.py <targets.csv> <out.csv> [app1,app2,...]
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
from halidemut.pipeline import Pipeline, PipelineError, Mutant  # noqa: E402

ROOT = Path(REPO)
BUILD = Path("/dev/shm/ardi_dslmut/halide16-build")
MULL_OUT = Path("/mnt/scratch1/ardi/dsl_mut/mull-ps/output")
LLVM = Path("/mnt/scratch1/ardi/dsl_mut/llvm14full")
WORK = Path("/mnt/scratch1/ardi/dsl_mut/sched-o3/work")

HL_NUM_THREADS = os.environ.get("O3_THREADS", "8")
REPS_BASELINE = int(os.environ.get("O3_REPS_BASELINE", "31"))
REPS_MUTANT = int(os.environ.get("O3_REPS_MUTANT", "15"))

pipeline = Pipeline(halide_root=ROOT, halide_build=BUILD, mull_output=MULL_OUT,
                    llvm_prefix=LLVM, workdir=WORK)

FIELDS = [
    "app", "mutator", "file", "line", "col",
    "stage2", "build_ok",
    "baseline_median_s", "baseline_iqr_s", "baseline_n",
    "mutant_median_s", "mutant_iqr_s", "mutant_n",
    "delta_s", "delta_pct", "threshold_s", "o3_verdict",
    "baseline_maxrss_kb", "mutant_maxrss_kb", "rss_delta_pct",
    "baseline_stmt_lines", "mutant_stmt_lines", "stmt_lines_differ",
    "baseline_vecinsn", "mutant_vecinsn", "vecinsn_differ",
    "baseline_text_bytes", "mutant_text_bytes", "text_bytes_delta_pct",
    "note",
]


def run_timed(argv, cwd, env):
    started = time.monotonic()
    try:
        proc = subprocess.Popen(argv, cwd=cwd, env=env,
                                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except OSError:
        return 0.0, -1, 0
    try:
        pid, status, rusage = os.wait4(proc.pid, 0)
    except ChildProcessError:
        return time.monotonic() - started, -1, 0
    wall = time.monotonic() - started
    exit_code = os.WEXITSTATUS(status) if os.WIFEXITED(status) else -1
    return wall, exit_code, rusage.ru_maxrss


def median_iqr(xs):
    xs = sorted(xs)
    n = len(xs)
    med = statistics.median(xs)
    if n < 4:
        return med, 0.0
    q1 = statistics.median(xs[: n // 2])
    q3 = statistics.median(xs[(n + 1) // 2:])
    return med, q3 - q1


def measure(driver, rundir, app, reps):
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
    for _ in range(reps):
        w, code, maxrss = run_timed(argv, str(rundir), env)
        times.append(w)
        rss.append(maxrss)
    return times, rss


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


def load_targets(path):
    by_app = defaultdict(list)
    for r in csv.DictReader(open(path)):
        by_app[r["app"]].append(r)
    return by_app


def process_app(app_name, targets, writer, outfh, threshold_multiplier):
    app = APPS[app_name]
    appwork = WORK / app_name
    appwork.mkdir(parents=True, exist_ok=True)

    print(f"[{app_name}] stage1: instrumenting...", flush=True)
    generator, mutants = pipeline.stage1(app, "schedule", ARMS["schedule"], route=ARM_ROUTE["schedule"])
    by_key = {}
    for m in mutants:
        by_key[(Path(m.path).name, str(m.line), str(m.column), m.mutator)] = m
    print(f"[{app_name}] stage1 done: {len(mutants)} mutants embedded", flush=True)

    # baseline
    bdest = appwork / "baseline"
    st2 = pipeline.stage2(app, generator, bdest, None)
    if st2 != "OK":
        print(f"[{app_name}] BASELINE stage2 FAILED: {st2}", flush=True)
        return
    driver_obj = appwork / "driver.o"
    if not pipeline.compile_driver_object(app, bdest, driver_obj):
        print(f"[{app_name}] baseline driver object compile FAILED", flush=True)
        return
    bdriver = appwork / "baseline.driver"
    if not pipeline.build_driver(app, bdest, bdriver, driver_object=driver_obj):
        print(f"[{app_name}] baseline driver link FAILED", flush=True)
        return
    base_header_sig = pipeline.header_signature(app, bdest)

    btimes, brss = measure(bdriver, appwork / "baseline_run", app, REPS_BASELINE)
    bmed, biqr = median_iqr(btimes)
    b_vec = count_vector_insns(bdriver)
    b_txt = text_bytes(bdriver)
    b_rss = statistics.median(brss) if brss else 0
    threshold = max(threshold_multiplier * biqr, 0.02 * bmed)  # floor: 2% of median
    print(f"[{app_name}] baseline median={bmed:.4f}s iqr={biqr:.4f}s "
          f"threshold={threshold:.4f}s n={len(btimes)}", flush=True)

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
            row["note"] = "mutant not found in this stage1 census (key mismatch or NOT_RUN upstream)"
            writer.writerow(row)
            outfh.flush()
            continue
        mdest = appwork / f"m_{r['mutator']}_{r['line']}_{r['column']}"
        st2 = pipeline.stage2(app, generator, mdest, mutant)
        row["stage2"] = st2
        if st2 != "OK":
            row["note"] = "generation failed or timed out"
            writer.writerow(row)
            outfh.flush()
            continue
        mheader_sig = pipeline.header_signature(app, mdest)
        use_obj = driver_obj if mheader_sig == base_header_sig else None
        mdriver = appwork / f"m_{r['mutator']}_{r['line']}_{r['column']}.driver"
        ok = pipeline.build_driver(app, mdest, mdriver, driver_object=use_obj)
        row["build_ok"] = "1" if ok else "0"
        if not ok:
            row["note"] = "driver link failed"
            writer.writerow(row)
            outfh.flush()
            continue

        mtimes, mrss = measure(mdriver, appwork / f"run_{r['mutator']}_{r['line']}_{r['column']}",
                               app, REPS_MUTANT)
        mmed, miqr = median_iqr(mtimes)
        delta = mmed - bmed
        m_vec = count_vector_insns(mdriver)
        m_txt = text_bytes(mdriver)
        m_rss = statistics.median(mrss) if mrss else 0
        m_stmt = stmt_lines(mdest, app.function_name)
        b_stmt = stmt_lines(bdest, app.function_name)

        verdict = "KILLED_O3" if abs(delta) > threshold else "SURVIVED_O3"

        row.update(
            mutant_median_s=f"{mmed:.5f}", mutant_iqr_s=f"{miqr:.5f}", mutant_n=len(mtimes),
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
        )
        writer.writerow(row)
        outfh.flush()
        print(f"[{app_name}] {r['mutator']:<32} {r['line']}:{r['column']:<4} "
              f"delta={delta:+.4f}s ({100*delta/bmed:+.1f}%) -> {verdict}", flush=True)


def main():
    targets_path, out_path = sys.argv[1], sys.argv[2]
    only_apps = set(sys.argv[3].split(",")) if len(sys.argv) > 3 else None
    threshold_multiplier = float(os.environ.get("O3_THRESHOLD_MULT", "3.0"))

    by_app = load_targets(targets_path)
    mode = "a" if (len(sys.argv) > 4 and sys.argv[4] == "append") else "w"
    with open(out_path, mode, newline="") as outfh:
        writer = csv.DictWriter(outfh, fieldnames=FIELDS)
        if mode == "w":
            writer.writeheader()
            outfh.flush()
        for app_name, targets in by_app.items():
            if only_apps and app_name not in only_apps:
                continue
            try:
                process_app(app_name, targets, writer, outfh, threshold_multiplier)
            except PipelineError as e:
                print(f"[{app_name}] PIPELINE ERROR: {e}", flush=True)
            except Exception:
                print(f"[{app_name}] UNEXPECTED ERROR:\n{traceback.format_exc()}", flush=True)


if __name__ == "__main__":
    main()
