"""Verify the added artifact-dumping drivers before any golden verdict is used.

    python3 -m halidemut.verify_golden [app ...]

Two things have to hold before a byte-diff against a snapshot means anything:

  1. the driver actually writes the artifact, and it is not empty;
  2. the artifact is reproducible -- identical bytes across repeated runs of the
     *unmutated* build.

(2) is the same check ``Runner.run_app_arm`` makes before it scores a single
mutant: several of these pipelines schedule with ``.parallel()``, and a
non-deterministic baseline would turn every mutant into a false kill. The check
lives here too so a newly added driver can be cleared on its own, without
running a sweep.

The shipped driver is also run once, unchanged, to confirm the added driver did
not disturb test 1 -- for blur in particular, whose test.cpp is the one shipped
driver in this corpus that is a genuine correctness test.

No Mull, no mutants: this only ever builds and runs the baseline, so it needs
the plain generator rather than an instrumented one.
"""

from __future__ import annotations

import argparse
import os
import shutil
import sys
from pathlib import Path

from .apps import APPS, AppConfig, golden_variant, has_independent_golden
from .pipeline import Pipeline, PipelineError

DEFAULT_APPS = ["blur", "conv_layer", "depthwise_separable_conv"]


def build_plain_generator(p: Pipeline, app: AppConfig, outdir: Path) -> Path:
    """Compile and link the app's generator with no instrumentation."""
    outdir.mkdir(parents=True, exist_ok=True)
    gen_obj = outdir / "generator.o"
    proc = p._run([p.cxx, *p._cxx_flags(app), "-O1", "-g", "-c",
                   str(p.halide_root / app.generator_source),
                   "-o", str(gen_obj)], timeout=1800)
    if proc.returncode != 0:
        raise PipelineError(f"{app.name}: generator TU failed\n"
                            + proc.stderr.decode(errors="replace")[-3000:])

    gengen_obj = outdir / "gengen.o"
    if not gengen_obj.exists():
        proc = p._run([p.cxx, *p._cxx_flags(app), "-O1", "-g", "-c",
                       str(p.halide_root / "tools" / "GenGen.cpp"),
                       "-o", str(gengen_obj)], timeout=900)
        if proc.returncode != 0:
            raise PipelineError(f"{app.name}: GenGen.cpp failed\n"
                                + proc.stderr.decode(errors="replace")[-2000:])

    generator = outdir / f"{app.name}.generator"
    proc = p._run([p.cxx, str(gen_obj), str(gengen_obj), "-o", str(generator),
                   "-L", p.halide_lib, "-lHalide",
                   f"-Wl,-rpath,{p.halide_lib}", "-lpthread", "-ldl"],
                  timeout=900)
    if proc.returncode != 0:
        raise PipelineError(f"{app.name}: generator link failed\n"
                            + proc.stderr.decode(errors="replace")[-2000:])
    return generator


def verify(p: Pipeline, app: AppConfig, runs: int, log=print) -> dict:
    out = {"app": app.name, "ok": False}
    work = p.workdir / app.name / "golden-verify"
    if work.exists():
        shutil.rmtree(work)
    work.mkdir(parents=True)

    log(f"[{app.name}] building generator (no instrumentation)")
    generator = build_plain_generator(p, app, work / "gen")

    base = work / "artifacts"
    log(f"[{app.name}] emitting baseline artifacts")
    status = p.stage2(app, generator, base, None)
    if status != "OK":
        raise PipelineError(f"{app.name}: baseline generation {status}")

    # -- test 1: the shipped driver, untouched ----------------------------
    shipped = base / "driver-shipped"
    if not p.build_driver(app, base, shipped):
        raise PipelineError(f"{app.name}: shipped driver build failed")
    code, sout, secs, timed = p.run_driver(app, shipped, base / "run-shipped")
    out["shipped_exit"] = code
    out["shipped_seconds"] = round(secs, 2)
    out["shipped_timed_out"] = timed
    log(f"[{app.name}] test 1 (shipped {Path(app.driver_source).name}): "
        f"exit={code} in {secs:.1f}s")
    if timed or code != 0:
        raise PipelineError(f"{app.name}: shipped driver failed "
                            f"(exit={code}, timeout={timed}) -- test 1 is "
                            f"broken, fix that before trusting test 2")

    # -- test 2 (golden): the added artifact-dumping driver ---------------
    va = golden_variant(app)
    if va is app:
        log(f"[{app.name}] no added golden driver; the shipped driver already "
            f"saves {app.output_artifact}")
    gd = base / "driver-golden"
    if not p.build_driver(va, base, gd):
        raise PipelineError(f"{app.name}: golden driver build failed")

    sigs, sizes = [], []
    for i in range(runs):
        rd = base / f"run-golden{i}"
        if rd.exists():
            shutil.rmtree(rd)
        code, sout, secs, timed = p.run_driver(va, gd, rd)
        if timed or code != 0:
            raise PipelineError(f"{app.name}: golden driver run {i} failed "
                                f"(exit={code}, timeout={timed})")
        artifact = rd / (va.output_artifact or "")
        if not va.output_artifact or not artifact.exists():
            raise PipelineError(f"{app.name}: golden driver wrote no "
                                f"{va.output_artifact!r} -- there is nothing "
                                f"to byte-diff")
        size = artifact.stat().st_size
        if size == 0:
            raise PipelineError(f"{app.name}: golden artifact is empty")
        sizes.append(size)
        sigs.append(p.oracle_signature(va, rd, sout))
        log(f"[{app.name}]   run {i}: {secs:.1f}s  {size} bytes  "
            f"sha256={sigs[-1][:16]}")

    out["artifact"] = va.output_artifact
    out["artifact_bytes"] = sizes[0]
    out["runs"] = runs
    out["digest"] = sigs[0]
    out["deterministic"] = len(set(sigs)) == 1 and len(set(sizes)) == 1
    if not out["deterministic"]:
        raise PipelineError(
            f"{app.name}: golden artifact is NOT deterministic over {runs} "
            f"runs ({sorted(set(s[:16] for s in sigs))}); no golden verdict "
            f"can be trusted for this app")
    out["ok"] = True
    log(f"[{app.name}] OK: {sizes[0]} bytes, identical over {runs} runs")
    return out


def main(argv=None) -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("apps", nargs="*", default=None)
    ap.add_argument("--halide-root",
                    default=str(Path(__file__).resolve().parent.parent.parent))
    ap.add_argument("--halide-build", required=True)
    ap.add_argument("--llvm-prefix", default="/usr/lib/llvm-14")
    ap.add_argument("--workdir", required=True)
    ap.add_argument("--runs", type=int, default=3)
    ap.add_argument("--threads", default="2",
                    help="HL_NUM_THREADS for the runs; the sweep uses 2, and "
                         "determinism has to be established under the same "
                         "setting it will be scored under")
    args = ap.parse_args(argv)

    os.environ["HL_NUM_THREADS"] = args.threads
    names = args.apps or DEFAULT_APPS
    p = Pipeline(Path(args.halide_root), Path(args.halide_build),
                 Path(args.halide_build), Path(args.llvm_prefix),
                 Path(args.workdir))

    rows, failed = [], 0
    for name in names:
        app = APPS[name]
        if not has_independent_golden(app):
            print(f"[{name}] SKIP: no artifact and no added golden driver -- "
                  f"test 2 (golden) cannot observe pipeline output here")
            continue
        try:
            rows.append(verify(p, app, args.runs))
        except Exception as exc:
            failed += 1
            print(f"[{name}] FAILED: {type(exc).__name__}: {exc}")

    print()
    print(f"{'app':<28}{'artifact':<12}{'bytes':>12}{'runs':>6}"
          f"{'deterministic':>15}  digest")
    print("-" * 100)
    for r in rows:
        print(f"{r['app']:<28}{r['artifact']:<12}{r['artifact_bytes']:>12}"
              f"{r['runs']:>6}{str(r['deterministic']):>15}  "
              f"{r['digest'][:32]}")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
