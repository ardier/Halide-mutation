"""Orchestrates the mutation pipeline over one or more apps and arms."""

from __future__ import annotations

import csv
import shutil
import sys
import tempfile
import time
import traceback
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Callable, List, Optional

from .apps import APPS, ARM_ROUTE, ARMS, AppConfig
from .pipeline import Mutant, MutantResult, Pipeline, PipelineError

CSV_FIELDS = [
    "app", "arm", "mutator", "file", "line", "column",
    "stage2", "stmt_differs", "effective", "stage3",
    "test1_demo", "test2_golden", "test2_written", "test3_perf",
    "killed_by", "killed", "exit_code", "wall_seconds", "note",
]


def _row(r: MutantResult) -> dict:
    return {
        "app": r.app, "arm": r.arm, "mutator": r.mutant.mutator,
        "file": Path(r.mutant.path).name, "line": r.mutant.line,
        "column": r.mutant.column, "stage2": r.stage2,
        "stmt_differs": "" if r.stmt_differs is None else int(r.stmt_differs),
        "effective": int(r.effective),
        "stage3": r.stage3,
        "test1_demo": r.test1_demo, "test2_golden": r.test2_golden,
        "test2_written": r.test2_written, "test3_perf": r.test3_perf,
        "killed_by": ";".join(r.killed_by), "killed": int(r.killed),
        "exit_code": "" if r.exit_code is None else r.exit_code,
        "wall_seconds": f"{r.wall_seconds:.2f}", "note": r.note,
    }


class Runner:
    def __init__(self, pipeline: Pipeline, keep_artifacts: bool = False,
                 determinism_runs: int = 3, workers: int = 4,
                 heavy_workers: int = 1, skip_equivalent: bool = True,
                 sink: Optional[Callable[[MutantResult], None]] = None):
        self.p = pipeline
        self.keep = keep_artifacts
        self.determinism_runs = determinism_runs
        self.workers = workers
        self.heavy_workers = heavy_workers
        self.skip_equivalent = skip_equivalent
        # Called with each result the moment it lands. A run under a wall-clock
        # budget can be cut off at any point, so results must be durable as
        # they are produced rather than only at the end.
        self.sink = sink

    def _emit(self, r: MutantResult) -> MutantResult:
        if self.sink is not None:
            self.sink(r)
        return r

    def run_app_arm(self, app: AppConfig, arm: str, log=print,
                    deadline: Optional[float] = None) -> List[MutantResult]:
        mutators = ARMS[arm]
        route = ARM_ROUTE[arm]
        log(f"[{app.name}/{arm}] stage 1: instrumenting ({route} route)")
        generator, mutants = self.p.stage1(app, arm, mutators, route=route)
        log(f"[{app.name}/{arm}] {len(mutants)} mutants")
        if not mutants:
            return []

        base = self.p.workdir / app.name / arm / "baseline"
        if base.exists():
            shutil.rmtree(base)
        log(f"[{app.name}/{arm}] baseline")
        status = self.p.stage2(app, generator, base, None)
        if status != "OK":
            raise PipelineError(f"{app.name}/{arm}: baseline generation {status}")

        base_stmt = (base / f"{app.function_name}.stmt")
        base_stmt_digest = self.p.digest(base_stmt)

        driver = base / "driver"
        if not self.p.build_driver(app, base, driver):
            raise PipelineError(f"{app.name}/{arm}: baseline driver build failed")

        base_run = base / "run"
        code, out, secs, timed = self.p.run_driver(app, driver, base_run)
        if timed or code != 0:
            raise PipelineError(
                f"{app.name}/{arm}: baseline driver failed (exit={code}, timeout={timed})")
        golden = self.p.oracle_signature(app, base_run, out)

        # test 2 (golden) treats any difference from the snapshot as a kill,
        # so the app's own output must be reproducible first. Several of these
        # pipelines schedule with .parallel(), and a nondeterministic baseline
        # would turn every mutant into a false kill.
        for i in range(1, self.determinism_runs):
            rd = base / f"run-det{i}"
            c, o, _, t = self.p.run_driver(app, driver, rd)
            if t or c != 0:
                raise PipelineError(
                    f"{app.name}/{arm}: baseline run {i} failed (exit={c}, timeout={t})")
            sig = self.p.oracle_signature(app, rd, o)
            if sig != golden:
                raise PipelineError(
                    f"{app.name}/{arm}: baseline output is NOT deterministic "
                    f"({golden[:16]} != {sig[:16]} on run {i}); no golden "
                    f"verdict can be trusted")
        log(f"[{app.name}/{arm}] baseline ok ({secs:.1f}s), deterministic over "
            f"{self.determinism_runs} runs, golden={golden[:16]}")

        # The driver TU is identical for every mutant of an app: the mutation
        # changes what the pipeline computes or how it is scheduled, never the
        # C signature in the emitted header. Compile it once and relink per
        # mutant, guarded by a digest of the emitted headers.
        base_headers = self.p.header_signature(app, base)
        driver_obj: Optional[Path] = base / "driver.o"
        if app.extra_driver_link or not self.p.compile_driver_object(
                app, base, driver_obj):
            driver_obj = None
            log(f"[{app.name}/{arm}] driver object not cached; full rebuild "
                f"per mutant")

        workers = self.heavy_workers if app.memory_heavy else self.workers
        results: List[MutantResult] = []

        def one(m: Mutant) -> MutantResult:
            return self._evaluate(app, arm, generator, m, base_stmt_digest,
                                  golden, base_headers, driver_obj)

        truncated = []
        with ThreadPoolExecutor(max_workers=workers) as pool:
            futures = {pool.submit(one, m): m for m in mutants}
            done = 0
            for fut in as_completed(futures):
                m = futures[fut]
                try:
                    results.append(self._emit(fut.result()))
                except Exception as exc:  # keep the batch alive
                    r = MutantResult(app.name, arm, m)
                    r.stage2 = "HARNESS_ERROR"
                    r.note = f"{type(exc).__name__}: {exc}"[:200]
                    results.append(self._emit(r))
                done += 1
                if done % 10 == 0 or done == len(mutants):
                    log(f"[{app.name}/{arm}] {done}/{len(mutants)}")
                if deadline is not None and time.monotonic() > deadline:
                    # Out of wall-clock budget. Stop handing out new work and
                    # record what never ran, so the raw mutant count stays
                    # honest and the unevaluated mutants are visibly excluded
                    # from every rate rather than silently missing.
                    for other, om in futures.items():
                        if other.cancel():
                            truncated.append(om)
                    log(f"[{app.name}/{arm}] budget exhausted after {done}/"
                        f"{len(mutants)}; {len(truncated)} mutants not evaluated")
                    break

        for m in truncated:
            r = MutantResult(app.name, arm, m)
            r.stage2 = "NOT_RUN"
            r.note = "wall-clock budget exhausted before this mutant was evaluated"
            results.append(self._emit(r))

        results.sort(key=lambda r: (r.mutant.mutator, r.mutant.line, r.mutant.column))
        return results

    def _evaluate(self, app: AppConfig, arm: str, generator: Path, m: Mutant,
                  base_stmt_digest, golden: str, base_headers: str = "",
                  driver_obj: Optional[Path] = None) -> MutantResult:
        r = MutantResult(app.name, arm, m)
        tmp = Path(tempfile.mkdtemp(prefix=f"{app.name}-", dir=str(self.p.workdir)))
        try:
            r.stage2 = self.p.stage2(app, generator, tmp, m)
            if r.stage2 != "OK":
                # A mutant the DSL compiler itself rejects is killed at
                # generation time -- a kill category only staged compilation
                # produces. Recorded, but not counted under any test kind.
                r.note = "killed at generation time"
                return r

            stmt = tmp / f"{app.function_name}.stmt"
            d = self.p.digest(stmt)
            r.stmt_differs = (d is not None and d != base_stmt_digest)

            if self.skip_equivalent and not r.stmt_differs:
                # The emitted Halide IR is byte-identical to baseline, so the
                # object code is too and the driver cannot observe anything.
                # Such a mutant is equivalent at this target by construction
                # and is resolved without running it; it is excluded from
                # every kill-rate denominator anyway;
                # building and running it is pure cost. Validated empirically
                # first: over the blur and harris schedule runs, all 47
                # stmt-identical mutants were built, run, and survived both
                # oracles, 47/47.
                r.note = ("equivalent at this target (emitted .stmt unchanged); "
                          "stages 3-4 skipped")
                return r

            reuse = driver_obj
            if reuse is not None and self.p.header_signature(app, tmp) != base_headers:
                # The mutant changed the emitted header, so the cached object
                # was compiled against a different declaration. Rare enough to
                # be worth noting when it happens.
                reuse = None
                r.note = "emitted header differs from baseline; driver recompiled"

            driver = tmp / "driver"
            if not self.p.build_driver(app, tmp, driver, driver_object=reuse):
                r.stage3 = "BUILD_ERROR"
                r.note = "mutant object failed to link into the driver"
                return r

            rundir = tmp / "run"
            code, out, secs, timed = self.p.run_driver(app, driver, rundir)
            r.wall_seconds = secs
            r.exit_code = code

            if timed:
                # A run that never terminated is a test-1 kill. It wrote no
                # artifact, so test 2 had nothing to compare: recording a
                # golden kill here would restate test 1 and inflate the
                # golden column.
                r.test1_demo = "KILLED"
                r.test2_golden = "NOT_RUN"
                r.note = "run timeout"
                return r

            r.test1_demo = "KILLED" if code != 0 else "SURVIVED"
            sig = self.p.oracle_signature(app, rundir, out)
            r.test2_golden = "KILLED" if sig != golden else "SURVIVED"
            if not r.stmt_differs:
                r.note = "equivalent at this target (emitted .stmt unchanged)"
            return r
        finally:
            if not self.keep:
                shutil.rmtree(tmp, ignore_errors=True)


def write_csv(results: List[MutantResult], path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=CSV_FIELDS)
        w.writeheader()
        for r in results:
            w.writerow(_row(r))


class StreamingCSV:
    """Append-and-flush each result as it lands.

    A run under a wall-clock budget can be killed at any moment; anything only
    held in memory would be lost with it.
    """

    def __init__(self, path: Path):
        path.parent.mkdir(parents=True, exist_ok=True)
        self._fh = path.open("w", newline="")
        self._w = csv.DictWriter(self._fh, fieldnames=CSV_FIELDS)
        self._w.writeheader()
        self._fh.flush()
        self._lock = __import__("threading").Lock()

    def __call__(self, r: MutantResult) -> None:
        with self._lock:
            self._w.writerow(_row(r))
            self._fh.flush()

    def close(self) -> None:
        self._fh.close()
