"""CLI entry point:  python -m halidemut --apps blur,harris --arms arithmetic,schedule"""

from __future__ import annotations

import argparse
import sys
import traceback
from pathlib import Path

from .apps import APPS, ARMS
from .pipeline import Pipeline, PipelineError
from .report import summarise
from .run import Runner, write_csv


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
    runner = Runner(pipeline, keep_artifacts=args.keep_artifacts)

    results = []
    failures = []
    for app_name in app_names:
        for arm in arm_names:
            try:
                results += runner.run_app_arm(APPS[app_name], arm)
            except PipelineError as exc:
                print(f"!! {app_name}/{arm}: {exc}", file=sys.stderr)
                failures.append((app_name, arm, str(exc)))
            except Exception:
                traceback.print_exc()
                failures.append((app_name, arm, "unexpected harness error"))

    if args.csv:
        write_csv(results, args.csv)
        print(f"\nwrote {args.csv} ({len(results)} rows)")

    text = summarise(results)
    if failures:
        text += "\nSETUP FAILURES (no mutants evaluated)\n"
        for app, arm, msg in failures:
            text += f"  {app}/{arm}: {msg.splitlines()[0][:160]}\n"
    print("\n" + text)
    if args.summary:
        args.summary.parent.mkdir(parents=True, exist_ok=True)
        args.summary.write_text(text)

    return 0 if results else 1


if __name__ == "__main__":
    sys.exit(main())
