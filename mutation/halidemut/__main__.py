"""CLI entry point:  python -m halidemut --apps blur,harris --arms arithmetic,schedule"""

from __future__ import annotations

import argparse
import sys
import time
import traceback
from pathlib import Path

from .apps import APPS, ARMS
from .pipeline import Pipeline, PipelineError
from .report import summarise
from .run import Runner, StreamingCSV, write_csv


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="halidemut")
    ap.add_argument("--halide-root", type=Path,
                    default=Path(__file__).resolve().parents[2])
    ap.add_argument("--halide-build", type=Path, default=None,
                    help="defaults to <halide-root>/build")
    ap.add_argument("--mull-output", type=Path, required=True,
                    help="mull-ps output/ directory holding mull-ir-frontend-14")
    ap.add_argument("--llvm-prefix", type=Path, default=Path("/usr/lib/llvm-14"))
    ap.add_argument("--workdir", type=Path, required=True)
    ap.add_argument("--apps", default="blur",
                    help="comma-separated app names, or 'all'")
    ap.add_argument("--arms", default="arithmetic,schedule",
                    help="comma-separated arm names, or 'all'")
    ap.add_argument("--csv", type=Path, default=None)
    ap.add_argument("--summary", type=Path, default=None)
    ap.add_argument("--keep-artifacts", action="store_true")
    ap.add_argument("--determinism-runs", type=int, default=3,
                    help="baseline runs that must agree before O2 is trusted")
    ap.add_argument("--workers", type=int, default=4,
                    help="parallel mutants for normal apps")
    ap.add_argument("--heavy-workers", type=int, default=1,
                    help="parallel mutants for apps marked memory_heavy")
    ap.add_argument("--budget-seconds", type=float, default=None,
                    help="wall-clock budget for this invocation. Arms are run "
                         "in --arms order and evaluation stops when the budget "
                         "is gone; unevaluated mutants are recorded as NOT_RUN "
                         "rather than dropped.")
    ap.add_argument("--no-skip-equivalent", action="store_true",
                    help="build and run mutants whose emitted .stmt is "
                         "byte-identical to baseline instead of classifying "
                         "them as equivalent-at-this-target up front")
    args = ap.parse_args(argv)

    halide_build = args.halide_build or (args.halide_root / "build")
    app_names = list(APPS) if args.apps == "all" else args.apps.split(",")
    arm_names = list(ARMS) if args.arms == "all" else args.arms.split(",")

    for a in app_names:
        if a not in APPS:
            ap.error(f"unknown app {a!r}; known: {', '.join(APPS)}")
    for a in arm_names:
        if a not in ARMS:
            ap.error(f"unknown arm {a!r}; known: {', '.join(ARMS)}")

    pipeline = Pipeline(args.halide_root, halide_build, args.mull_output,
                        args.llvm_prefix, args.workdir)

    sink = StreamingCSV(args.csv) if args.csv else None
    runner = Runner(pipeline, keep_artifacts=args.keep_artifacts,
                    determinism_runs=args.determinism_runs,
                    workers=args.workers, heavy_workers=args.heavy_workers,
                    skip_equivalent=not args.no_skip_equivalent,
                    sink=sink)

    deadline = (time.monotonic() + args.budget_seconds
                if args.budget_seconds else None)

    results = []
    failures = []
    skipped = []
    for app_name in app_names:
        for arm in arm_names:
            if deadline is not None and time.monotonic() > deadline:
                skipped.append((app_name, arm))
                continue
            try:
                results += runner.run_app_arm(APPS[app_name], arm,
                                              deadline=deadline)
            except PipelineError as exc:
                print(f"!! {app_name}/{arm}: {exc}", file=sys.stderr)
                failures.append((app_name, arm, str(exc)))
            except Exception:
                traceback.print_exc()
                failures.append((app_name, arm, "unexpected harness error"))

    if sink is not None:
        sink.close()
        print(f"\nwrote {args.csv} ({len(results)} rows)")

    text = summarise(results)
    if failures:
        text += "\nSETUP FAILURES (no mutants evaluated)\n"
        for app, arm, msg in failures:
            text += f"  {app}/{arm}: {msg.splitlines()[0][:160]}\n"
    if skipped:
        text += "\nNOT REACHED (wall-clock budget exhausted first)\n"
        for app, arm in skipped:
            text += f"  {app}/{arm}\n"
    print("\n" + text)
    if args.summary:
        args.summary.parent.mkdir(parents=True, exist_ok=True)
        args.summary.write_text(text)

    return 0 if results else 1


if __name__ == "__main__":
    sys.exit(main())
