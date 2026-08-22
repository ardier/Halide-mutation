#!/usr/bin/env python3
"""Execution harness for the AST mutator applied to Halide GENERATOR source.

This is the missing stage for the DSL-native operator family. The census
records 2,481 halide_* mutation points on generator sources and the tool's own
sweep.sh recorded EFFECTIVE / EQUIVALENT / GEN_FAIL for them -- but those are
GENERATION-STAGE verdicts produced by diffing the emitted .stmt text. No driver
was ever linked and no test was ever applied, so no kill rate can be quoted
from them. This module links the driver and applies the tests.

Vocabulary, kept strictly:

    point identified -> mutant generated -> mutant run -> mutant killed

NOT_RUN never silently enters a denominator.

---------------------------------------------------------------- the chain
Mutating a generator is a longer chain than mutating emitted C++. The emitted
route compiles one .cpp and links it. Here:

    1 compile   the mutated generator TU  (parses Halide.h -- the slow part)
    2 link      against libHalide -> a standalone generator binary
    3 generate  RUN that binary to emit <func>.a, <func>.h, <func>.stmt
                (plus the _auto_schedule variant and runtime.a where the app
                 needs them)
    4 link      the app's shipped driver against those artifacts
    5 run       score the test kinds

Stages 3, 4 and 5 are NOT reimplemented here: they are halidemut.Pipeline's
stage2 / build_driver / run_driver / oracle_signature, imported and called.
Only stage 1-2 differ from the Mull arms, because this mutator emits N
standalone .cpp files with no env-var dispatch, so the unit of work is a
separate compile and a separate link rather than an env var set on one shared
instrumented binary.

------------------------------------------------------- why no shim is needed
The emitted-C++ harness has to synthesise a forwarding _auto_schedule shim,
because there the mutation lives in the emitted pipeline .cpp and a separately
generated companion library would be unmutated and would overwrite the mutated
result before the image is written. Here the mutation lives in the GENERATOR,
and the same mutated generator binary emits BOTH the main and the
_auto_schedule variant (halidemut.Pipeline.stage2 issues both jobs against the
one binary). The companion is therefore mutated by construction and the output
oracle stays sighted. This is checked, not assumed: --require-auto-from-mutant
asserts both artifacts came from the mutated binary.

--------------------------------------------------------------------- TCE
Equivalence is proven on the EMITTED ARTIFACT, not on the generator source. A
generator mutation that lands in a branch the chosen target does not take (a
GPU/HVX schedule arm, say) emits byte-identical code and cannot be killed by
any test at this target. Two digests are recorded:

    tce_lib    machine code and constants of the emitted static library,
               section by section, ignoring symbol tables / debug / ordering.
               Identical to baseline => provably unkillable by ANY test.
    stmt_sha   digest of the emitted .stmt text. This is what the old
               generation-stage sweep compared, recorded so the two runs can be
               reconciled rather than argued about.

A mutant can be stmt-identical (so the old sweep called it EQUIVALENT) yet
differ in the library, or vice versa; recording both makes that visible.

------------------------------------------------------------------ gotchas
HL_NUM_THREADS=2. At 1 the emitted halide_do_par_for degenerates to a single
task and mutations in the task-splitting arithmetic stop being observable.

A run TIMEOUT is a test1_demo kill ONLY. It writes no artifact, so the output
comparison had nothing to compare and is recorded NOT_RUN, never KILLED.

test3_perf is left EMPTY unless --perf-runs >= 3. An empty cell means "not
run"; a 0 would read as "ran and survived".

A generator that fails to compile, fails to link, or crashes/hangs when RUN
never becomes a runnable pipeline. Those are recorded in their own stage
columns and are NOT counted as test kills. They are reported as their own
category.
"""

from __future__ import annotations

import argparse
import csv
import dataclasses
import hashlib
import os
import re
import shutil
import statistics
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import List, Optional

# Current column vocabulary. Deliberately NOT o1/o2/o3, and deliberately
# test2_added + test2_method rather than separate golden/written columns.
TEST_KINDS = ["test1_demo", "test2_added", "test3_perf"]

CSV_FIELDS = [
    "app", "route", "target_kind", "mutant_uid", "op_id", "file", "line",
    "column", "target", "ordinal_this_run",
    "stage_compile", "stage_genlink", "stage_generate", "stage_link",
    "tce_lib", "stmt_sha", "stmt_differs", "equivalent",
    "test1_demo", "test2_added", "test2_method", "test3_perf",
    "killed_by", "exit_code", "wall_seconds", "perf_median",
    "artifact_digest", "tool_id", "note",
]

HALIDE_OPS = ("halide_arith_swap,halide_rel_swap,halide_boundary_conditions,"
              "halide_clamp_arg_swap,halide_select_arg_swap,"
              "halide_select_to_if_then_else")


# --------------------------------------------------------------- identity
@dataclasses.dataclass(frozen=True)
class Point:
    op_id: str
    file: str
    line: int
    column: int
    target: str
    ordinal: str
    source: Path

    @property
    def key(self) -> str:
        return (f"{self.op_id}|{Path(self.file).name}:{self.line}:"
                f"{self.column}|{self.target}")

    @property
    def uid(self) -> str:
        return hashlib.sha1(self.key.encode()).hexdigest()[:16]


POINT_RE = re.compile(
    r"^(?P<op>[a-z0-9_]+)\t(?P<loc>[^\t]+):(?P<line>\d+):(?P<col>\d+)\t"
    r"(?P<target>[^\t]*)\t(?P<ord>m\d+\S*)\s*$")


def parse_points(tsv_text: str, srcdir: Path, stem: str) -> List[Point]:
    pts, seen = [], set()
    for raw in tsv_text.splitlines():
        if not raw or raw.startswith("#"):
            continue
        m = POINT_RE.match(raw)
        if not m:
            continue
        p = Point(op_id=m.group("op"), file=m.group("loc"),
                  line=int(m.group("line")), column=int(m.group("col")),
                  target=m.group("target").strip(), ordinal=m.group("ord"),
                  source=srcdir / f"{stem}.{m.group('ord')}.cpp")
        if p.uid in seen:
            print(f"  WARNING duplicate identity {p.key}", file=sys.stderr)
            continue
        seen.add(p.uid)
        pts.append(p)
    return pts


# ------------------------------------------------------------------ shell
def run(cmd, timeout, env=None, cwd=None):
    return subprocess.run([str(c) for c in cmd], timeout=timeout, env=env,
                          cwd=cwd, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE)


def sha256_file(p: Path) -> Optional[str]:
    if not p.exists():
        return None
    return hashlib.sha256(p.read_bytes()).hexdigest()


# ------------------------------------------------------------------ TCE
# Sections are enumerated from each object, NOT taken from a fixed list.
#
# The first version of this used the fixed list (.text, .rodata, .data,
# .data.rel.ro) inherited from the emitted-C++ harness. That is correct for an
# object clang produces from emitted C++, but WRONG for one Halide's own code
# generator produces: Halide emits every function into its own section
# (.text.halide_blur, .text.halide_default_malloc, ...) and leaves the plain
# .text section zero bytes long. The fixed list matched nothing, every library
# hashed to the same "all sections absent" value, and every single mutant
# compared bit-identical to baseline. It did not look like a broken
# measurement -- it looked like a 100% equivalence rate. Verified on blur: 237
# allocatable sections exist where the fixed list found 0 bytes of code.
EXCLUDE_SEC_RE = re.compile(r"^\.(comment|note($|\.)|gnu\.build-id)")
SEC_RE = re.compile(r"^\s*(\d+)\s+(\S+)\s+([0-9a-f]+)\s")


def object_sections(objdump: str, obj: Path):
    """Every section that occupies space in the loaded image, as (name, size).

    Build-metadata sections are dropped: .comment carries the compiler version
    string and .note.* carries build ids, none of which is machine code and
    any of which can differ without a semantic difference.
    """
    r = run([objdump, "-h", str(obj)], timeout=120)
    lines = r.stdout.decode(errors="replace").splitlines()
    secs = []
    for i, line in enumerate(lines):
        m = SEC_RE.match(line)
        if not m:
            continue
        name, size = m.group(2), int(m.group(3), 16)
        flags = lines[i + 1] if i + 1 < len(lines) else ""
        if "ALLOC" not in flags or "CONTENTS" not in flags:
            continue
        if EXCLUDE_SEC_RE.match(name):
            continue
        secs.append((name, size))
    return sorted(secs)


def lib_tce_digest(objcopy: str, ar: str, objdump: str, lib: Path,
                   scratch: Path) -> str:
    """Digest the machine code and constants inside a static library.

    Symbol tables, debug info, archive member timestamps and section ordering
    are all excluded, so this answers exactly one question: does the emitted
    pipeline consist of the same instructions and the same constants? If it
    does, no test can tell this mutant from baseline, ever, at this
    optimisation level. That is an equivalence proof.

    Returns a "<...>" sentinel rather than a hash whenever it could not
    actually read any code, so a failure can never masquerade as equivalence.
    """
    if not lib.exists():
        return "<absent>"
    work = scratch / f"ar-{lib.stem}-{os.getpid()}-{time.monotonic_ns()}"
    work.mkdir(parents=True, exist_ok=True)
    try:
        names = run([ar, "t", str(lib)], timeout=120)
        members = sorted(n for n in names.stdout.decode().split() if n)
        r = run([ar, "x", str(lib.resolve())], timeout=300, cwd=str(work))
        if r.returncode != 0:
            return "<ar-failed>"
        h = hashlib.sha256()
        total_bytes = 0
        for mem in members:
            mp = work / mem
            h.update(b"|MEMBER|" + mem.encode())
            if not mp.exists():
                h.update(b"<missing-member>")
                continue
            secs = object_sections(objdump, mp)
            if not secs:
                h.update(b"<no-alloc-sections>")
                continue
            for name, size in secs:
                out = work / ("sec" + re.sub(r"\W", "_", name) + ".bin")
                rr = run([objcopy, "--only-section", name, "-O", "binary",
                          str(mp), str(out)], timeout=120)
                h.update(b"|SEC|" + name.encode() + b"|" + str(size).encode())
                if rr.returncode == 0 and out.exists():
                    data = out.read_bytes()
                    total_bytes += len(data)
                    h.update(data)
                    out.unlink()
                else:
                    h.update(b"<extract-failed>")
        if total_bytes == 0:
            return "<no-code-bytes>"
        return h.hexdigest()
    finally:
        shutil.rmtree(work, ignore_errors=True)


# --------------------------------------------------------------- harness
class GenHarness:
    """Stage 1-2 for the generator route: build one generator binary per
    mutant. Everything after that is halidemut.Pipeline."""

    def __init__(self, a, pipe, appcfg):
        self.a = a
        self.pipe = pipe
        self.cfg = appcfg
        self.scratch = Path(a.scratch) / a.app
        self.cxx = a.cxx
        self.env = dict(os.environ, HL_NUM_THREADS=str(a.hl_threads))
        self.gengen_obj = self.scratch / "gengen.o"
        self.extra_objs: List[str] = []

    def _flags(self):
        return ["-std=c++17",
                "-I", str(self.pipe.halide_build / "include"),
                "-I", str(self.pipe.halide_root / "tools")]

    def build_support_objects(self):
        """GenGen.cpp and any extra_generator_sources: compiled ONCE and
        reused for every mutant. They are never mutated, so recompiling them
        per mutant would be pure waste at corpus scale."""
        r = run([self.cxx, *self._flags(), "-O1", "-c",
                 str(self.pipe.halide_root / "tools" / "GenGen.cpp"),
                 "-o", str(self.gengen_obj)], timeout=1800)
        if r.returncode != 0:
            raise SystemExit("GenGen.cpp failed to compile\n"
                             + r.stderr.decode(errors="replace")[-3000:])
        for i, src in enumerate(getattr(self.cfg, "extra_generator_sources", []) or []):
            obj = self.scratch / f"extra{i}.o"
            r = run([self.cxx, *self._flags(), "-O1", "-c",
                     str(self.pipe.halide_root / src), "-o", str(obj)],
                    timeout=1800)
            if r.returncode != 0:
                raise SystemExit(f"{src} failed to compile\n"
                                 + r.stderr.decode(errors="replace")[-3000:])
            self.extra_objs.append(str(obj))

    def compile_generator_tu(self, src: Path, obj: Path):
        return run([self.cxx, *self._flags(), "-O1", "-c", str(src),
                    "-o", str(obj)], timeout=self.a.compile_timeout)

    def link_generator(self, obj: Path, out: Path):
        libdir = str(self.pipe.halide_build / "src")
        return run([self.cxx, str(obj), str(self.gengen_obj), *self.extra_objs,
                    "-o", str(out), "-L", libdir, "-lHalide",
                    f"-Wl,-rpath,{libdir}", "-lpthread", "-ldl"],
                   timeout=self.a.link_timeout)


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--app", required=True)
    ap.add_argument("--halide-root", required=True)
    ap.add_argument("--halide-build", required=True)
    ap.add_argument("--halidemut", required=True,
                    help="mutation/ dir of Halide-mutation-wip-c -- the ONLY "
                         "copy of apps.py registering interpolate, "
                         "local_laplacian and stencil_chain")
    ap.add_argument("--mull-output", default="/mnt/scratch1/ardi/dsl_mut/mull-ps/output",
                    help="only used to satisfy the Pipeline constructor; the "
                         "generator route loads no Mull plugin")
    ap.add_argument("--llvm-prefix", default="/usr/lib/llvm-14")
    ap.add_argument("--tool", required=True, help="halide-ast-mutate binary")
    ap.add_argument("--generator-source", default="",
                    help="override; default is appcfg.generator_source")
    ap.add_argument("--ops", default=HALIDE_OPS)
    ap.add_argument("--out-csv", required=True)
    ap.add_argument("--scratch", default="/dev/shm/genmut")
    ap.add_argument("--cxx", default="/usr/lib/llvm-14/bin/clang++")
    ap.add_argument("--objcopy", default="objcopy")
    ap.add_argument("--objdump", default="objdump")
    ap.add_argument("--ar", default="ar")
    ap.add_argument("--jobs", type=int, default=6)
    ap.add_argument("--hl-threads", type=int, default=2)
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--baseline-runs", type=int, default=3)
    ap.add_argument("--perf-runs", type=int, default=0)
    ap.add_argument("--compile-timeout", type=int, default=1800)
    ap.add_argument("--link-timeout", type=int, default=900)
    ap.add_argument("--generate-timeout", type=int, default=900)
    ap.add_argument("--keep-scratch", action="store_true")
    a = ap.parse_args(argv)

    sys.path.insert(0, a.halidemut)
    from halidemut.apps import APPS, golden_variant           # noqa: E402
    from halidemut.pipeline import Pipeline                   # noqa: E402

    tool_id = hashlib.md5(Path(a.tool).read_bytes()).hexdigest()[:12]
    appcfg = APPS[a.app]
    golden_app = golden_variant(appcfg)

    scratch = Path(a.scratch) / a.app
    if scratch.exists():
        shutil.rmtree(scratch)
    for sub in ("src", "obj", "gen", "art", "run"):
        (scratch / sub).mkdir(parents=True)

    pipe = Pipeline(halide_root=Path(a.halide_root),
                    halide_build=Path(a.halide_build),
                    mull_output=Path(a.mull_output),
                    llvm_prefix=Path(a.llvm_prefix),
                    workdir=scratch / "pipe")
    h = GenHarness(a, pipe, appcfg)
    log = lambda *m: print(*m, flush=True)

    gen_src = Path(a.generator_source) if a.generator_source else \
        Path(a.halide_root) / appcfg.generator_source
    if not gen_src.exists():
        raise SystemExit(f"generator source not found: {gen_src}")
    log(f"[{a.app}] generator source {gen_src}")
    log(f"[{a.app}] tool {a.tool} id={tool_id}")

    # ------------------------------------------------------- emit points
    incs = ["-I", str(Path(a.halide_build) / "include"),
            "-I", str(Path(a.halide_root) / "tools")]
    cmd = [a.tool, "--mode=emit", f"--out-dir={scratch/'src'}"]
    if a.ops:
        cmd.append(f"--ops={a.ops}")
    cmd += [str(gen_src), "--", "clang++", "-std=c++17", *incs, "-c"]
    t0 = time.time()
    r = run(cmd, timeout=7200)
    if r.returncode != 0:
        log(r.stderr.decode(errors="replace")[-3000:])
        raise SystemExit(f"{a.app}: emit failed")
    points = parse_points(r.stdout.decode(errors="replace"),
                          scratch / "src", gen_src.name[:-len(".cpp")])
    log(f"[{a.app}] {len(points)} points identified in {time.time()-t0:.0f}s")
    if a.limit:
        points = points[:a.limit]
        log(f"[{a.app}] limited to {len(points)} for this run")
    if not points:
        raise SystemExit(f"{a.app}: no points -- wrong --ops for this target?")

    # ------------------------------------------------------- support objs
    log(f"[{a.app}] compiling GenGen.cpp + extras once")
    h.build_support_objects()

    # ---------------------------------------------------------- baseline
    base_obj = scratch / "obj" / "baseline.o"
    r = h.compile_generator_tu(gen_src, base_obj)
    if r.returncode != 0:
        log(r.stderr.decode(errors="replace")[-3000:])
        raise SystemExit(f"{a.app}: BASELINE generator TU failed to compile")
    base_gen = scratch / "gen" / "baseline.generator"
    r = h.link_generator(base_obj, base_gen)
    if r.returncode != 0:
        log(r.stderr.decode(errors="replace")[-3000:])
        raise SystemExit(f"{a.app}: BASELINE generator failed to link")

    def generate(genbin: Path, dest: Path) -> str:
        dest.mkdir(parents=True, exist_ok=True)
        cfg = dataclasses.replace(appcfg, generate_timeout=a.generate_timeout)
        return pipe.stage2(cfg, genbin, dest, None)

    # The generator itself must be deterministic before TCE means anything.
    base_art = scratch / "art" / "baseline"
    st = generate(base_gen, base_art)
    if st != "OK":
        raise SystemExit(f"{a.app}: BASELINE generate failed: {st}")
    func = appcfg.function_name
    base_lib = base_art / f"{func}.a"
    base_tce = lib_tce_digest(a.objcopy, a.ar, a.objdump, base_lib,
                              scratch / "obj")
    if base_tce.startswith("<"):
        # Never let an unreadable library be silently treated as a digest --
        # every mutant would then match it and be declared equivalent.
        raise SystemExit(f"{a.app}: cannot read machine code out of "
                         f"{base_lib} ({base_tce}); TCE would be meaningless")
    base_stmt = sha256_file(base_art / f"{func}.stmt") or "<absent>"

    base_art2 = scratch / "art" / "baseline2"
    st = generate(base_gen, base_art2)
    if st != "OK":
        raise SystemExit(f"{a.app}: BASELINE re-generate failed: {st}")
    tce2 = lib_tce_digest(a.objcopy, a.ar, a.objdump,
                          base_art2 / f"{func}.a", scratch / "obj")
    if tce2 != base_tce:
        raise SystemExit(f"{a.app}: the generator is NOT deterministic -- it "
                         f"emits different machine code on two runs, so no TCE "
                         f"equivalence claim here can be trusted")
    shutil.rmtree(base_art2, ignore_errors=True)
    log(f"[{a.app}] baseline emitted lib tce={base_tce[:16]} "
        f"stmt={base_stmt[:16]} (deterministic over 2 generates)")
    if appcfg.needs_auto_variant:
        aux = base_art / f"{func}_auto_schedule.a"
        if not aux.exists():
            raise SystemExit(f"{a.app}: needs_auto_variant but the mutated "
                             f"generator produced no _auto_schedule library")
        log(f"[{a.app}] _auto_schedule variant emitted BY THE SAME generator "
            f"binary -- no unmutated companion is linked, oracle stays sighted")

    # -------------------------------------------------- baseline driver
    drv_obj = scratch / "obj" / "driver.o"
    if not pipe.compile_driver_object(appcfg, base_art, drv_obj):
        raise SystemExit(f"{a.app}: shipped driver TU failed to compile")
    base_bin = scratch / "obj" / "baseline.bin"
    if not pipe.build_driver(appcfg, base_art, base_bin, drv_obj):
        raise SystemExit(f"{a.app}: baseline driver failed to link")

    os.environ["HL_NUM_THREADS"] = str(a.hl_threads)
    times, sigs = [], []
    probe_cfg = dataclasses.replace(appcfg, run_timeout=600)
    for i in range(a.baseline_runs):
        rd = scratch / "run" / f"base-{i}"
        code, sout, secs, timed = pipe.run_driver(probe_cfg, base_bin, rd)
        if timed or code != 0:
            raise SystemExit(f"{a.app}: shipped driver fails on the UNMUTATED "
                             f"build (exit {code}, timeout={timed}) -- test 1 "
                             f"is broken, nothing can be scored")
        times.append(secs)
        sigs.append(pipe.oracle_signature(appcfg, rd, sout))
        shutil.rmtree(rd, ignore_errors=True)
    base_median = statistics.median(times)
    noise = ((max(times) - min(times)) / base_median) if base_median else 0.0
    run_timeout = max(30.0, min(300.0, base_median * 8))
    log(f"[{a.app}] baseline test1: {a.baseline_runs} runs, median "
        f"{base_median:.2f}s, noise {noise*100:.1f}%, timeout {run_timeout:.0f}s")

    # ------------------------------------------------------ test2 setup
    golden_bin = None
    golden_sig = None
    test2_method = ""
    if golden_app.output_artifact:
        test2_method = "output_compare"
        gdrv_obj = scratch / "obj" / "golden_driver.o"
        if not pipe.compile_driver_object(golden_app, base_art, gdrv_obj):
            raise SystemExit(f"{a.app}: golden driver TU failed to compile")
        golden_bin = scratch / "obj" / "baseline.golden"
        if not pipe.build_driver(golden_app, base_art, golden_bin, gdrv_obj):
            raise SystemExit(f"{a.app}: golden driver failed to link")
        gsigs = []
        gcfg = dataclasses.replace(golden_app, run_timeout=int(run_timeout))
        for i in range(a.baseline_runs):
            rd = scratch / "run" / f"bgold-{i}"
            code, sout, secs, timed = pipe.run_driver(gcfg, golden_bin, rd)
            if timed or code != 0:
                raise SystemExit(f"{a.app}: golden baseline run {i} failed")
            gsigs.append(pipe.oracle_signature(golden_app, rd, sout))
            shutil.rmtree(rd, ignore_errors=True)
        if len(set(gsigs)) != 1:
            raise SystemExit(f"{a.app}: the output artifact is NOT "
                             f"deterministic over {a.baseline_runs} runs -- no "
                             f"output-comparison verdict here can be trusted")
        golden_sig = gsigs[0]
        log(f"[{a.app}] baseline test2 ({test2_method}): "
            f"sha={golden_sig[:16]} deterministic over {a.baseline_runs} runs")
    else:
        log(f"[{a.app}] NO output artifact: this driver only prints, so "
            f"test2_added is recorded NOT_RUN (test1 only)")

    perf_band = None
    if a.perf_runs >= 3:
        tol = max(0.25, 4 * noise)
        perf_band = (base_median / (1 + tol), base_median * (1 + tol))
        log(f"[{a.app}] test3 band {perf_band[0]:.3f}..{perf_band[1]:.3f}s")

    # -------------------------------------------------------------- sweep
    fh = open(a.out_csv, "w", newline="")
    w = csv.DictWriter(fh, fieldnames=CSV_FIELDS, lineterminator="\n")
    w.writeheader()
    lock = __import__("threading").Lock()
    C = dict(compile_fail=0, genlink_fail=0, gen_fail=0, link_fail=0,
             tce_equiv=0, run=0, killed=0, gen_missing=0)

    def evaluate(p: Point) -> dict:
        row = dict.fromkeys(CSV_FIELDS, "")
        row.update(app=a.app, route="ast_mutator", target_kind="generator",
                   mutant_uid=p.uid, op_id=p.op_id, file=Path(p.file).name,
                   line=p.line, column=p.column, target=p.target,
                   ordinal_this_run=p.ordinal, tool_id=tool_id,
                   stage_compile="OK", stage_genlink="OK",
                   stage_generate="OK", stage_link="OK",
                   test1_demo="NOT_RUN", test2_added="NOT_RUN",
                   test2_method="", test3_perf="")
        tag = p.uid
        obj = scratch / "obj" / f"{tag}.o"
        genbin = scratch / "gen" / f"{tag}.generator"
        art = scratch / "art" / tag
        binary = scratch / "obj" / f"{tag}.bin"
        gbin = scratch / "obj" / f"{tag}.gbin"
        try:
            if not p.source.exists():
                row["stage_compile"] = "GEN_FAIL"
                row["note"] = "the tool emitted no file for this point"
                return row
            cr = h.compile_generator_tu(p.source, obj)
            if cr.returncode != 0:
                row["stage_compile"] = "COMPILE_FAIL"
                row["note"] = ("the compiler rejected the mutated generator; "
                               "a staged-compilation outcome, not a test kill")
                return row
            lr = h.link_generator(obj, genbin)
            if lr.returncode != 0:
                row["stage_genlink"] = "GENLINK_FAIL"
                row["note"] = "mutated generator failed to link against libHalide"
                return row
            st = generate(genbin, art)
            if st != "OK":
                row["stage_generate"] = st
                row["note"] = ("the mutated generator did not produce a "
                               "pipeline; never became a runnable mutant, so "
                               "it is NOT scored as a test kill")
                return row

            dg = lib_tce_digest(a.objcopy, a.ar, a.objdump, art / f"{func}.a",
                                scratch / "obj")
            row["tce_lib"] = dg[:16]
            sd = sha256_file(art / f"{func}.stmt") or "<absent>"
            row["stmt_sha"] = sd[:16]
            row["stmt_differs"] = int(sd != base_stmt)
            if dg.startswith("<"):
                # Could not read the library. That is a measurement failure,
                # not an equivalence: fall through and test it for real.
                row["note"] = f"TCE unavailable ({dg}); mutant tested anyway"
            elif dg == base_tce:
                row["equivalent"] = "tce_lib"
                row["note"] = ("emitted pipeline is bit-identical machine "
                               "code: no test can distinguish it")
                return row

            if not pipe.build_driver(appcfg, art, binary, None):
                row["stage_link"] = "LINK_FAIL"
                row["note"] = "driver failed to link against the mutant pipeline"
                return row

            runs = max(1, a.perf_runs)
            rcfg = dataclasses.replace(appcfg, run_timeout=int(run_timeout))
            obs = []
            for i in range(runs):
                rd = scratch / "run" / f"{tag}-{i}"
                obs.append((pipe.run_driver(rcfg, binary, rd), rd))
            (code, sout, secs, timed), rd0 = obs[0]
            row["exit_code"] = "" if code is None else code
            row["wall_seconds"] = f"{secs:.3f}"
            if timed:
                # No artifact was written, so the output comparison had
                # nothing to compare. It is NOT a test2 kill.
                row["test1_demo"] = "KILLED"
                row["note"] = "run timeout"
            else:
                row["test1_demo"] = "KILLED" if code != 0 else "SURVIVED"

            if perf_band:
                if timed:
                    row["test3_perf"] = "KILLED"
                else:
                    med = statistics.median(o[0][2] for o in obs)
                    row["perf_median"] = f"{med:.3f}"
                    row["test3_perf"] = ("KILLED" if not
                                         (perf_band[0] <= med <= perf_band[1])
                                         else "SURVIVED")

            if golden_sig is not None and not timed:
                row["test2_method"] = test2_method
                if not pipe.build_driver(golden_app, art, gbin, None):
                    row["note"] = (row["note"] + "; golden driver link failed").strip("; ")
                else:
                    grd = scratch / "run" / f"{tag}-g"
                    gcfg2 = dataclasses.replace(golden_app,
                                                run_timeout=int(run_timeout))
                    gcode, gout, _, gtimed = pipe.run_driver(gcfg2, gbin, grd)
                    art_path = grd / golden_app.output_artifact
                    # An output comparison can only return a verdict when
                    # there is an output to compare. A run that timed out,
                    # aborted or exited nonzero wrote no artifact; scoring the
                    # absent file as "different from golden" would manufacture
                    # a test2 kill out of what is really a test1 kill and
                    # double-count the same observation. Measured on blur:
                    # 6 of 30 generator mutants abort, and all 6 were being
                    # credited to test2 before this check existed.
                    if gtimed:
                        row["test2_added"] = "NOT_RUN"
                        row["note"] = (row["note"] + "; golden run timed out, "
                                       "no artifact to compare").strip("; ")
                    elif gcode != 0:
                        row["test2_added"] = "NOT_RUN"
                        row["note"] = (row["note"] + f"; golden driver exited "
                                       f"{gcode}, wrote no artifact -- test1 "
                                       f"kill only, not a test2 kill").strip("; ")
                    elif not art_path.exists():
                        row["test2_added"] = "NOT_RUN"
                        row["note"] = (row["note"] + "; golden driver exited 0 "
                                       "but produced no artifact").strip("; ")
                    else:
                        sig = pipe.oracle_signature(golden_app, grd, gout)
                        row["artifact_digest"] = (sig or "")[:16]
                        row["test2_added"] = ("KILLED" if sig != golden_sig
                                              else "SURVIVED")
                    shutil.rmtree(grd, ignore_errors=True)
            elif golden_sig is None:
                row["note"] = (row["note"] + "; driver writes no artifact, "
                               "test2 cannot observe pipeline output").strip("; ")
            return row
        finally:
            for pth in (obj, genbin, binary, gbin):
                Path(pth).unlink(missing_ok=True)
            shutil.rmtree(art, ignore_errors=True)
            for d in (scratch / "run").glob(f"{tag}*"):
                shutil.rmtree(d, ignore_errors=True)
            row["killed_by"] = ";".join(k for k in TEST_KINDS
                                        if row.get(k) == "KILLED")

    t0 = time.time()
    with ThreadPoolExecutor(max_workers=a.jobs) as pool:
        futs = {pool.submit(evaluate, p): p for p in points}
        done = 0
        for f in as_completed(futs):
            p = futs[f]
            try:
                row = f.result()
            except Exception as exc:
                row = dict.fromkeys(CSV_FIELDS, "")
                row.update(app=a.app, route="ast_mutator",
                           target_kind="generator", mutant_uid=p.uid,
                           op_id=p.op_id, file=Path(p.file).name, line=p.line,
                           column=p.column, target=p.target, tool_id=tool_id,
                           stage_compile="HARNESS_ERROR",
                           test1_demo="NOT_RUN", test2_added="NOT_RUN",
                           test3_perf="",
                           note=f"{type(exc).__name__}: {exc}"[:300])
            with lock:
                w.writerow(row)
                fh.flush()
                if row["stage_compile"] == "COMPILE_FAIL":
                    C["compile_fail"] += 1
                if row["stage_compile"] == "GEN_FAIL":
                    C["gen_missing"] += 1
                if row["stage_genlink"] == "GENLINK_FAIL":
                    C["genlink_fail"] += 1
                if str(row["stage_generate"]).startswith("GEN_") :
                    C["gen_fail"] += 1
                if row["stage_link"] == "LINK_FAIL":
                    C["link_fail"] += 1
                if row["equivalent"] == "tce_lib":
                    C["tce_equiv"] += 1
                if row["test1_demo"] in ("KILLED", "SURVIVED"):
                    C["run"] += 1
                if row["killed_by"]:
                    C["killed"] += 1
            done += 1
            if done % 10 == 0 or done == len(points):
                log(f"[{a.app}] {done}/{len(points)} tce={C['tce_equiv']} "
                    f"run={C['run']} killed={C['killed']} "
                    f"({time.time()-t0:.0f}s)")
    fh.close()

    n = len(points)
    generated = n - C["gen_missing"] - C["compile_fail"]
    log("")
    log(f"points identified            {n}")
    log(f"  tool emitted no file       {C['gen_missing']}")
    log(f"  compiler rejected mutant   {C['compile_fail']}")
    log(f"mutants generated            {generated}")
    log(f"  generator link failed      {C['genlink_fail']}")
    log(f"  generator ran but produced no pipeline  {C['gen_fail']}")
    log(f"  equivalent (TCE on emitted lib)         {C['tce_equiv']}")
    log(f"  driver link failed         {C['link_fail']}")
    log(f"mutants run                  {C['run']}")
    log(f"mutants killed               {C['killed']}")
    log(f"wall {time.time()-t0:.0f}s on {a.jobs} workers -> {a.out_csv}")

    if not a.keep_scratch:
        shutil.rmtree(scratch, ignore_errors=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
