"""Experiment 2 (thesis analog): kill golden-surviving mutants with written tests.

For a chosen benchmark this re-runs a chosen set of mutants twice:

  before   the app's own shipped driver           (what the full sweep scored)
  after    a new, targeted test added by us       (apps/<app>/mutation_test.cpp)

and reports the two verdicts side by side, so a "killed" claim is always a
before/after pair measured on the same mutant with the same toolchain, not an
assertion.

The "after" test is written to be self-checking: it aborts or exits non-zero
when the pipeline is wrong. It is scored as test 2 (written) -- the
hand-authored sub-tier -- and never folded into test 1, which is reserved for
the shipped driver's own verdict. A written test failing is a strictly stronger
claim than a golden byte difference: the test *fails*, it does not merely
produce different bytes.

Everything reuses halidemut's own pipeline (stage 1 instrument, stage 2 emit per
mutant, stage 3 link+run), so the mutant identity mechanism, the equivalence
handling and the test kinds are exactly the ones the full sweep used.

Machine-portability note: every path is a flag with a default, so this runs
unchanged on a bigger host (only --halide-root/--halide-build/--mull-output
change).
"""

from __future__ import annotations

import argparse
import csv
import dataclasses
import json
import shutil
import sys
import tempfile
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))

from halidemut.apps import APPS, ARM_ROUTE, ARMS  # noqa: E402
from halidemut.pipeline import Pipeline, PipelineError  # noqa: E402

FIELDS = [
    "app", "arm", "mutator", "file", "line", "column", "variant",
    "stage2", "stmt_differs", "effective", "stage3",
    "test1_demo", "test2_golden", "test2_written", "test3_perf",
    "killed_by", "killed", "exit_code", "wall_seconds", "note",
]


def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument("--halide-root", default=str(HERE.parent.parent))
    ap.add_argument("--halide-build",
                    default="/home/ardi/project/dsl_mutants/halide/Halide-mutation/build")
    ap.add_argument("--mull-output",
                    default="/home/ardi/project/dsl_mutants/halide/mull-ps/output")
    ap.add_argument("--llvm-prefix", default="/usr/lib/llvm-14")
    ap.add_argument("--workdir",
                    default="/home/ardi/project/dsl_mutants/halide/sweep-work/exp2")
    ap.add_argument("--app", required=True)
    ap.add_argument("--arms", default="boundary_conditions,select_clamp,if_then_else")
    ap.add_argument("--variants", default="before,after",
                    help="which drivers to evaluate")
    ap.add_argument("--test-driver", default=None,
                    help="driver source for the 'after' variant, relative to "
                         "the Halide root (default apps/<app>/mutation_test.cpp)")
    ap.add_argument("--test-args", default=None,
                    help="JSON list of driver argv for the 'after' variant; "
                         "default is the app's own driver_args")
    ap.add_argument("--test-output-artifact", default="",
                    help="output artifact for the 'after' variant; empty means "
                         "none, so the written test is scored purely on its "
                         "own exit status and stdout")
    ap.add_argument("--only", default=None,
                    help="comma-separated line:col filter, e.g. 38:26,39:26")
    ap.add_argument("--csv", required=True)
    ap.add_argument("--workers", type=int, default=3)
    ap.add_argument("--keep", action="store_true")
    return ap.parse_args()


def variant_app(app, args, which):
    if which == "before":
        return app
    driver = args.test_driver or f"apps/{app.name}/mutation_test.cpp"
    kw = dict(driver_source=driver)
    if args.test_args is not None:
        kw["driver_args"] = json.loads(args.test_args)
    kw["output_artifact"] = args.test_output_artifact or None
    kw["extra_driver_outputs"] = []
    return dataclasses.replace(app, **kw)


def main():
    args = parse_args()
    app = APPS[args.app]
    arms = [a for a in args.arms.split(",") if a]
    only = None
    if args.only:
        only = {tuple(int(v) for v in s.split(":")) for s in args.only.split(",")}

    p = Pipeline(Path(args.halide_root), Path(args.halide_build),
                 Path(args.mull_output), Path(args.llvm_prefix),
                 Path(args.workdir))

    out = Path(args.csv)
    out.parent.mkdir(parents=True, exist_ok=True)
    fh = out.open("w", newline="")
    w = csv.DictWriter(fh, fieldnames=FIELDS)
    w.writeheader()

    for arm in arms:
        route = ARM_ROUTE[arm]
        print(f"[{app.name}/{arm}] stage 1 ({route})", flush=True)
        generator, mutants = p.stage1(app, arm, ARMS[arm], route=route)
        if only is not None:
            mutants = [m for m in mutants if (m.line, m.column) in only]
        print(f"[{app.name}/{arm}] {len(mutants)} mutants selected", flush=True)
        if not mutants:
            continue

        base = p.workdir / app.name / arm / "baseline"
        if base.exists():
            shutil.rmtree(base)
        st = p.stage2(app, generator, base, None)
        if st != "OK":
            raise PipelineError(f"baseline generation {st}")
        base_stmt_digest = p.digest(base / f"{app.function_name}.stmt")

        for which in args.variants.split(","):
            va = variant_app(app, args, which)
            drv = base / f"driver-{which}"
            if not p.build_driver(va, base, drv):
                raise PipelineError(f"{which}: baseline driver build failed")
            rundir = base / f"run-{which}"
            if rundir.exists():
                shutil.rmtree(rundir)
            code, sout, secs, timed = p.run_driver(va, drv, rundir)
            if timed or code != 0:
                print(sout[-3000:])
                raise PipelineError(
                    f"{which}: baseline driver failed (exit={code}, to={timed}) "
                    f"-- an 'after' test must pass on the unmutated pipeline")
            golden = p.oracle_signature(va, rundir, sout)
            print(f"[{app.name}/{arm}] baseline/{which} ok in {secs:.1f}s "
                  f"golden={golden[:16]}", flush=True)

            for m in mutants:
                tmp = Path(tempfile.mkdtemp(prefix=f"{app.name}-{which}-",
                                            dir=str(p.workdir)))
                row = dict(app=app.name, arm=arm, mutator=m.mutator,
                           file=Path(m.path).name, line=m.line, column=m.column,
                           variant=which, stage2="OK", stmt_differs="",
                           effective=0, stage3="OK",
                           test1_demo="NOT_RUN", test2_golden="NOT_RUN",
                           test2_written="NOT_RUN", test3_perf="NOT_RUN",
                           killed_by="", killed=0, exit_code="",
                           wall_seconds="0.00", note="")
                try:
                    st = p.stage2(app, generator, tmp, m)
                    row["stage2"] = st
                    if st != "OK":
                        row["note"] = "killed at generation time"
                        w.writerow(row); fh.flush(); continue
                    d = p.digest(tmp / f"{app.function_name}.stmt")
                    differs = d is not None and d != base_stmt_digest
                    row["stmt_differs"] = int(differs)
                    row["effective"] = int(differs)
                    if not differs:
                        row["note"] = ("equivalent at this target "
                                       "(emitted .stmt unchanged)")
                        w.writerow(row); fh.flush(); continue
                    dm = tmp / "driver"
                    if not p.build_driver(va, tmp, dm):
                        row["stage3"] = "BUILD_ERROR"
                        w.writerow(row); fh.flush(); continue
                    rd = tmp / "run"
                    code, sout, secs, timed = p.run_driver(va, dm, rd)
                    row["wall_seconds"] = f"{secs:.2f}"
                    row["exit_code"] = "" if code is None else code
                    # "before" is the shipped driver, so its verdict is
                    # test 1 plus, where the driver saves an artifact, test 2
                    # (golden). "after" is the driver WE wrote: one
                    # self-checking test, scored into test2_written alone.
                    written = (which != "before")
                    if timed:
                        if written:
                            row["test2_written"] = "KILLED"
                        else:
                            row["test1_demo"] = "KILLED"
                        row["note"] = "run timeout"
                    else:
                        sig = p.oracle_signature(va, rd, sout)
                        differs = sig != golden
                        if written:
                            row["test2_written"] = (
                                "KILLED" if (code != 0 or differs) else "SURVIVED")
                        else:
                            row["test1_demo"] = (
                                "KILLED" if code != 0 else "SURVIVED")
                            row["test2_golden"] = (
                                "KILLED" if differs else "SURVIVED")
                    row["killed_by"] = ";".join(
                        k for k in ("test1_demo", "test2_golden",
                                    "test2_written", "test3_perf")
                        if row[k] == "KILLED")
                    row["killed"] = int(bool(row["killed_by"]))
                except Exception as exc:  # keep the batch alive
                    row["stage2"] = "HARNESS_ERROR"
                    row["note"] = f"{type(exc).__name__}: {exc}"[:200]
                finally:
                    if not args.keep:
                        shutil.rmtree(tmp, ignore_errors=True)
                print(f"   {which:6s} {m.mutator} {m.line}:{m.column} "
                      f"eff={row['effective']} "
                      f"killed_by={row['killed_by'] or '-'}",
                      flush=True)
                w.writerow(row)
                fh.flush()

    fh.close()
    print(f"wrote {out}")


if __name__ == "__main__":
    main()
