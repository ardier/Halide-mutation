"""Three-stage mutation pipeline for Halide benchmark apps.

stage 1  instrument the generator TU with Mull's IR frontend, link a generator
         binary, and read back the mutant list
stage 2  for each mutant, re-run the generator with that mutant's env var set to
         emit a static library, header and .stmt
stage 3  link the app's own driver against the mutant's static library, run it,
         and score the result

Test kinds. Every kind is scored independently and the SET of kinds that
killed a mutant is recorded, not just the first one to fire -- "killed by X"
and "X alone sufficed" are different questions. A mutant is RESOLVED if any
kind kills it, or if it is proven equivalent.

  test1_demo     the shipped driver's own verdict: exit status, crash, abort,
                 timeout. Zero effort, it ships with the app.
  test2_golden   byte comparison of the driver's output artifact against a
                 snapshot taken once from the unmutated build. Near-free.
  test2_written  a hand-authored assertion driver we added, swapped in with
                 dataclasses.replace(app, driver_source=...) so no shipped file
                 is touched. Real work. Kept in its own column on purpose:
                 pooling it with test2_golden would hide the test-writing
                 effort difference that separation exists to measure.
  test3_perf     median wall time against a threshold taken from that app's own
                 baseline timing noise.
"""

from __future__ import annotations

import dataclasses
import hashlib
import os
import re
import shutil
import subprocess
import tempfile
from pathlib import Path
from typing import Dict, List, Optional

from .apps import AppConfig

# The test kinds, in report order. A mutant carries one verdict per kind.
TEST_KINDS = ["test1_demo", "test2_golden", "test2_written", "test3_perf"]

# Mutant env-var keys look like  <mutator-id>:<file>:<line>:<column>
# The instrumented object also contains a longer
# <id>:<file>:<line>:<col>:<endline>:<endcol> form, which is Mull's reporting
# identifier rather than a key -- matching it too doubles the mutant count.
MUTANT_KEY_RE = re.compile(r"^(Halide_[a-z_0-9]+):(/[^:]+):(\d+):(\d+)$")

# Timing lines make stdout non-deterministic; drop them before comparing.
TIMING_LINE_RE = re.compile(
    r"(time|times|Manually-tuned|Auto-scheduled|runtime|best|Halide)\s*.*?[\d.]+\s*(ms|s)?\b",
    re.IGNORECASE,
)


@dataclasses.dataclass
class Mutant:
    key: str
    mutator: str
    path: str
    line: int
    column: int

    @property
    def location(self) -> str:
        return f"{Path(self.path).name}:{self.line}:{self.column}"


@dataclasses.dataclass
class MutantResult:
    app: str
    arm: str
    mutant: Mutant
    stage2: str = "OK"          # OK | GEN_ERROR | GEN_TIMEOUT
    stmt_differs: Optional[bool] = None
    stage3: str = "OK"          # OK | BUILD_ERROR
    test1_demo: str = "NOT_RUN"      # KILLED | SURVIVED | NOT_RUN
    test2_golden: str = "NOT_RUN"    # KILLED | SURVIVED | NOT_RUN
    test2_written: str = "NOT_RUN"   # KILLED | SURVIVED | NOT_RUN
    test3_perf: str = "NOT_RUN"      # KILLED | SURVIVED | NOT_RUN
    exit_code: Optional[int] = None
    wall_seconds: float = 0.0
    note: str = ""

    @property
    def killed_by(self) -> List[str]:
        """The set of test kinds that killed this mutant, in report order."""
        return [k for k in TEST_KINDS if getattr(self, k) == "KILLED"]

    @property
    def killed(self) -> bool:
        return bool(self.killed_by)

    @property
    def resolved(self) -> bool:
        """Killed by at least one test kind, or proven equivalent.

        Equivalence is a positive result, not a shortfall: a mutant whose
        emitted code is byte-identical to baseline cannot be killed by any
        test, and saying so is an answer.
        """
        return self.killed or (self.stage2 == "OK" and self.stage3 == "OK"
                               and not self.effective)

    @property
    def effective(self) -> bool:
        """Did the mutation change the code the generator emitted?

        A generator's schedule is branched on the target (GPU / HVX / CPU), so
        a mutation inside a branch the chosen target does not take leaves the
        emitted .stmt byte-identical. Such a mutant is equivalent *at this
        target* by construction and cannot be killed by any test kind --
        counting it as "survived" would understate every kill rate. It is
        resolved, and reported separately.
        """
        return self.stage2 == "OK" and self.stage3 == "OK" and bool(self.stmt_differs)


class PipelineError(RuntimeError):
    pass


class Pipeline:
    def __init__(
        self,
        halide_root: Path,
        halide_build: Path,
        mull_output: Path,
        llvm_prefix: Path,
        workdir: Path,
    ):
        self.halide_root = Path(halide_root).resolve()
        self.halide_build = Path(halide_build).resolve()
        self.mull_output = Path(mull_output).resolve()
        self.llvm_prefix = Path(llvm_prefix).resolve()
        self.workdir = Path(workdir).resolve()
        self.workdir.mkdir(parents=True, exist_ok=True)

        self.cxx = str(self.llvm_prefix / "bin" / "clang++")
        self.include_dirs = [
            str(self.halide_build / "include"),
            str(self.halide_root / "tools"),
        ]
        self.halide_lib = str(self.halide_build / "src")

    # -- helpers ----------------------------------------------------------

    def _run(self, cmd, timeout, cwd=None, env=None, capture=True):
        return subprocess.run(
            cmd,
            timeout=timeout,
            cwd=cwd or str(self.halide_root),
            env=env,
            stdout=subprocess.PIPE if capture else subprocess.DEVNULL,
            stderr=subprocess.PIPE if capture else subprocess.DEVNULL,
        )

    def _cxx_flags(self, app: AppConfig, extra_includes=()):
        flags = ["-std=c++17"]
        for d in list(self.include_dirs) + list(extra_includes):
            flags += ["-I", d]
        return flags

    # -- stage 1 ----------------------------------------------------------

    def stage1(self, app: AppConfig, arm: str, mutators: List[str],
               route: str = "ir") -> tuple[Path, List[Mutant]]:
        """Instrument the generator TU and link a generator binary.

        ``route`` selects the frontend: "ir" loads the LLVM pass plugin, "ast"
        loads the Clang AST plugin. Both read the same mull.yml (via
        MULL_CONFIG) and both embed env-var-keyed mutants into the object, so
        everything downstream of here is shared.

        Returns the generator path and the mutants Mull recorded.
        """
        outdir = self.workdir / app.name / arm
        outdir.mkdir(parents=True, exist_ok=True)

        config = outdir / "mull.yml"
        config.write_text(
            "mutators:\n"
            + "".join(f"  - {m}\n" for m in mutators)
            + "timeout: 99999999\nquiet: true\nincludePaths:\n  - .*\n"
        )

        gen_obj = outdir / "generator.o"
        env = dict(os.environ, MULL_CONFIG=str(config))
        # -grecord-command-line is required on the IR route: Mull's junk
        # detector re-parses the source and reconstructs the compile flags from
        # the recorded command line. Without it the include paths are lost, the
        # re-parse cannot find Halide.h, and every mutation point is discarded
        # as junk. The AST route needs no junk detection -- it has exact source
        # locations from the AST -- but the flag is harmless there.
        # Only one source file per invocation -- Mull rejects a recorded command
        # line that yields more than one compiler job.
        if route == "ir":
            plugin = [f"-fpass-plugin={self.mull_output / 'mull-ir-frontend-14'}"]
        elif route == "ast":
            plugin = [f"-fplugin={self.mull_output / 'libmull-cxx-frontend-14.so'}"]
        else:
            raise PipelineError(f"unknown mutation route {route!r}")
        cmd = [
            self.cxx, *self._cxx_flags(app), "-O1", "-g", "-grecord-command-line",
            *plugin,
            "-c", str(self.halide_root / app.generator_source),
            "-o", str(gen_obj),
        ]
        proc = self._run(cmd, timeout=1800, env=env)
        if proc.returncode != 0:
            raise PipelineError(
                f"{app.name}/{arm}: instrumentation failed\n"
                + proc.stderr.decode(errors="replace")[-4000:]
            )

        gengen_obj = outdir / "gengen.o"
        if not gengen_obj.exists():
            proc = self._run(
                [self.cxx, *self._cxx_flags(app), "-O1", "-g", "-c",
                 str(self.halide_root / "tools" / "GenGen.cpp"), "-o", str(gengen_obj)],
                timeout=900,
            )
            if proc.returncode != 0:
                raise PipelineError(f"{app.name}: GenGen.cpp failed\n"
                                    + proc.stderr.decode(errors="replace")[-2000:])

        generator = outdir / f"{app.name}.generator"
        proc = self._run(
            [self.cxx, str(gen_obj), str(gengen_obj), "-o", str(generator),
             "-L", self.halide_lib, "-lHalide", f"-Wl,-rpath,{self.halide_lib}",
             "-lpthread", "-ldl"],
            timeout=900,
        )
        if proc.returncode != 0:
            raise PipelineError(f"{app.name}/{arm}: generator link failed\n"
                                + proc.stderr.decode(errors="replace")[-2000:])

        return generator, self._read_mutants(gen_obj)

    def _read_mutants(self, obj: Path) -> List[Mutant]:
        proc = subprocess.run(["strings", str(obj)], stdout=subprocess.PIPE)
        seen, mutants = set(), []
        for line in proc.stdout.decode(errors="replace").splitlines():
            m = MUTANT_KEY_RE.match(line.strip())
            if not m or line.strip() in seen:
                continue
            seen.add(line.strip())
            mutants.append(Mutant(line.strip(), m.group(1), m.group(2),
                                  int(m.group(3)), int(m.group(4))))
        mutants.sort(key=lambda x: (x.mutator, x.line, x.column))
        return mutants

    # -- stage 2 ----------------------------------------------------------

    def stage2(self, app: AppConfig, generator: Path, dest: Path,
               mutant: Optional[Mutant]) -> str:
        """Emit static library, header and .stmt for one mutant (or baseline)."""
        dest.mkdir(parents=True, exist_ok=True)
        env = dict(os.environ)
        if mutant is not None:
            env[mutant.key] = "1"

        target = "host-no_runtime" if app.needs_runtime else "host"
        jobs = [
            [str(generator), "-g", app.generator_name, "-e", "static_library,h,stmt",
             "-f", app.function_name, "-o", str(dest), f"target={target}"],
        ]
        if app.needs_auto_variant:
            # Deliberately no autoscheduler= argument; see apps.py.
            jobs.append(
                [str(generator), "-g", app.generator_name, "-e", "static_library,h",
                 "-f", f"{app.function_name}_auto_schedule", "-o", str(dest),
                 "target=host-no_runtime"]
            )
        if app.needs_runtime:
            jobs.append([str(generator), "-r", "runtime", "-o", str(dest), "target=host"])
        for extra in app.extra_gen_jobs:
            jobs.append([str(generator)]
                        + [a.replace("{outdir}", str(dest)) for a in extra])

        for cmd in jobs:
            try:
                proc = self._run(cmd, timeout=app.generate_timeout, env=env)
            except subprocess.TimeoutExpired:
                return "GEN_TIMEOUT"
            if proc.returncode != 0:
                return "GEN_ERROR"
        return "OK"

    # -- stage 3 ----------------------------------------------------------

    def _driver_libs(self, app: AppConfig, artifacts: Path) -> List[str]:
        libs = [str(artifacts / f"{app.function_name}.a")]
        if app.needs_auto_variant:
            libs.append(str(artifacts / f"{app.function_name}_auto_schedule.a"))
        if app.needs_runtime:
            libs.append(str(artifacts / "runtime.a"))
        return libs

    def header_signature(self, app: AppConfig, artifacts: Path) -> str:
        """Digest of everything the driver *compiles against*, as opposed to
        links. Used to decide whether a prebuilt driver object is still valid
        for this mutant."""
        h = hashlib.sha256()
        for p in sorted(artifacts.glob("*.h")):
            h.update(p.name.encode())
            h.update(p.read_bytes())
        return h.hexdigest()

    def compile_driver_object(self, app: AppConfig, artifacts: Path,
                              out: Path) -> bool:
        """Compile the app's driver TU once, against the baseline headers."""
        cmd = [self.cxx, *self._cxx_flags(app, extra_includes=[str(artifacts)]),
               "-O2", "-Wall", "-c", str(self.halide_root / app.driver_source),
               "-o", str(out)]
        proc = self._run(cmd, timeout=900)
        return proc.returncode == 0

    def build_driver(self, app: AppConfig, artifacts: Path, out: Path,
                     driver_object: Optional[Path] = None) -> bool:
        """Link the app's driver against one mutant's artifacts.

        ``driver_object`` is a prebuilt object for the driver TU. Every mutant
        of an app emits the same header -- the mutation changes the schedule or
        the arithmetic inside the pipeline, not its C signature -- so the driver
        TU compiles to the same object every time and only the link differs.
        The caller is responsible for having checked header_signature; if the
        headers ever did differ, the object is not reused.
        """
        libs = self._driver_libs(app, artifacts)
        extra_sources = [str(artifacts / f) for f in app.extra_driver_link]

        if driver_object is not None and not extra_sources:
            cmd = [self.cxx, str(driver_object), *libs,
                   "-o", str(out), "-lpthread", "-ldl"]
        else:
            cmd = [self.cxx, *self._cxx_flags(app, extra_includes=[str(artifacts)]),
                   "-O2", "-Wall", str(self.halide_root / app.driver_source),
                   *extra_sources, *libs,
                   "-o", str(out), "-lpthread", "-ldl"]
        if app.needs_image_io:
            cmd += ["-ljpeg", "-lpng", "-lz"]
        proc = self._run(cmd, timeout=900)
        return proc.returncode == 0

    def run_driver(self, app: AppConfig, driver: Path, rundir: Path):
        """Returns (exit_code, stdout, wall_seconds, timed_out)."""
        rundir.mkdir(parents=True, exist_ok=True)
        argv = [str(driver)]
        for a in app.driver_args:
            argv.append(
                a.replace("{input}", str(self.halide_root / app.input_image) if app.input_image else "")
                 .replace("{output}", str(rundir / (app.output_artifact or "out.png")))
                 .replace("{outdir}", str(rundir))
            )
        import time
        started = time.monotonic()
        try:
            proc = subprocess.run(argv, cwd=str(rundir), timeout=app.run_timeout,
                                  stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except subprocess.TimeoutExpired:
            return None, "", time.monotonic() - started, True
        return proc.returncode, proc.stdout.decode(errors="replace"), \
            time.monotonic() - started, False

    # -- oracles ----------------------------------------------------------

    @staticmethod
    def normalise_stdout(text: str) -> str:
        keep = []
        for line in text.splitlines():
            if TIMING_LINE_RE.search(line):
                continue
            keep.append(line.rstrip())
        return "\n".join(keep).strip()

    @staticmethod
    def digest(path: Path) -> Optional[str]:
        if not path.exists():
            return None
        return hashlib.sha256(path.read_bytes()).hexdigest()

    def oracle_signature(self, app: AppConfig, rundir: Path, stdout: str) -> str:
        """The test-2 observable: the output artifact if the driver writes one,
        else its normalised stdout.

        An app whose driver writes no artifact has no independent golden
        signal -- the fallback restates what test 1 already saw. Three such
        apps (blur, conv_layer, depthwise_separable_conv) are given an
        artifact-dumping driver variant instead; see apps.py.
        """
        if app.output_artifact:
            d = self.digest(rundir / app.output_artifact)
            return d or "<missing>"
        return self.normalise_stdout(stdout)
