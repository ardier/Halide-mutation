#!/usr/bin/env python3
"""Execution harness for the source-rewriting (AST) mutator.

The tool's own scripts stop at generation: sweep.sh compiles each mutated
source, runs the generator, and diffs the emitted .stmt. That answers "did the
mutation change the code", which is a generation-stage question. It never links
a driver and never applies a test, so it has never killed anything. EFFECTIVE /
EQUIVALENT / GEN_FAIL are generation-stage verdicts and no kill rate can be
quoted from them.

This is the missing stage. Vocabulary, kept strictly:

    point identified -> mutant generated -> mutant run -> mutant killed

Why none of the five Mull harnesses could be reused: every one of them assumes
`env[key]="1"` dispatch against ONE instrumented binary. This mutator emits N
standalone .cpp files with no dispatch at all, so the unit of work is a
separate compile and a separate link, not an env var. What *is* reusable is
Mull-free: halidemut.pipeline's build_driver / run_driver / oracle_signature /
digest / normalise_stdout take an AppConfig and an artifacts directory and
never mention a mutant key. Those are imported, not reimplemented, so the test
kinds here are literally the ones the Mull arms used.

----------------------------------------------------------------- identity
The tool cannot emit one named mutant: --mode=emit writes every surviving
point, and the finest unit it accepts is a site. `mNNN` in a filename is the
ordinal within THAT filtered run -- change --ops and every number shifts. It is
therefore used only to join a file to its row inside a single run, and never
leaves this module. Results are keyed on

    op_id + file:line:col + target token

hashed into a stable `mutant_uid`. Two runs with different flags produce the
same uid for the same mutation.

--------------------------------------------------------------------- shape
Per app, one at a time:

  lower     the app's stock generator emits the pipeline as C++
            (-e c_source,c_header) plus a separate runtime.a. This is the
            *emitted* target kind -- 1,362 points for blur, 22,252 for
            stencil_chain -- not the 36-point generator source.
  emit      the tool writes one .cpp per point into tmpfs
  baseline  compile the unmutated emitted .cpp at -O2, link the driver, run it
            repeatedly: determinism gate, golden snapshot, timing band
  TCE       compile every mutant at -O2 and compare the machine code against
            the baseline object. Bit-identical => the mutant cannot be
            distinguished by any test whatsoever, so it is EQUIVALENT and
            RESOLVED. That is a positive result, not a shortfall; on blur it
            accounts for 44% of the population and skipping those runs is the
            single biggest saving in the harness.
            -O2 because it is what the apps ship. -O0 compiles 16-43% faster
            but proves fewer equivalences and does not match the shipped
            binary, so its equivalence claims would not transfer.
  run       link driver + mutant .o + auto_schedule shim .o + runtime.a and
            score the test kinds
  delete    the app's tmpfs tree goes before the next app starts. The whole
            corpus emitted at once is ~73 GB and /dev/shm holds 110 GB: that
            fits any single app, and no two.

--------------------------------------------------------------- gotchas kept
HL_NUM_THREADS is pinned to 2 for the baseline and for every mutant. At 1 the
emitted halide_do_par_for degenerates to a single task and mutations inside the
task-splitting arithmetic stop being observable at all.

The _auto_schedule companion is a forwarding shim onto the *mutated* pipeline,
never a separately generated unmutated library. Every filter.cpp/process.cpp in
this corpus calls <app>(...) and then <app>_auto_schedule(...) into the same
buffer and saves the second result; linking an unmutated companion overwrites
every trace of the mutation before the image is written and makes the golden
test structurally blind.

Emitted C++ is compiled with -Wno-psabi.
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
from typing import Dict, List, Optional

TEST_KINDS = ["test1_demo", "test2_golden", "test2_written", "test3_perf"]

CSV_FIELDS = [
    "app", "route", "mutant_uid", "op_id", "file", "line", "column", "target",
    "ordinal_this_run", "stage_compile", "tce", "stage_link",
    *TEST_KINDS, "killed_by", "killed", "resolved", "resolution",
    "exit_code", "wall_seconds", "perf_median", "artifact_digest", "note",
]


# --------------------------------------------------------------- identity
@dataclasses.dataclass(frozen=True)
class Point:
    op_id: str
    file: str
    line: int
    column: int
    target: str
    ordinal: str          # mNNN -- run-local join key ONLY, never an identity
    source: Path          # the emitted mutated .cpp

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
        ordinal = m.group("ord")
        p = Point(op_id=m.group("op"), file=m.group("loc"),
                  line=int(m.group("line")), column=int(m.group("col")),
                  target=m.group("target").strip(), ordinal=ordinal,
                  source=srcdir / f"{stem}.{ordinal}.cpp")
        if p.uid in seen:
            # Same op at the same token twice would make the uid ambiguous.
            # Report it rather than silently dropping a mutant.
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
TCE_SECTIONS = (".text", ".rodata", ".data", ".data.rel.ro")


def tce_digest(objcopy: str, obj: Path, scratch: Path) -> str:
    """Digest of the object's *machine code and constants*, ignoring symbol
    tables, debug info and section ordering.

    Two mutants with the same digest as the baseline compile to bit-identical
    code: no test can tell them apart, at this optimisation level, ever. That
    is an equivalence proof, not a measurement failure.
    """
    h = hashlib.sha256()
    for sec in TCE_SECTIONS:
        out = scratch / f"{obj.stem}{sec.replace('.', '_')}.bin"
        r = run([objcopy, "--only-section", sec, "-O", "binary",
                 str(obj), str(out)], timeout=120)
        h.update(sec.encode())
        if r.returncode == 0 and out.exists():
            h.update(out.read_bytes())
            out.unlink()
        else:
            h.update(b"<absent>")
    return h.hexdigest()


# ------------------------------------------------------ auto_schedule shim
SIG_RE_TMPL = r"HALIDE_FUNCTION_ATTRS\s*\nint\s+{func}\s*\(([^;]*?)\)\s*;"


def make_auto_schedule_shim(cxx, func: str, header: Path, scratch: Path,
                            includes) -> Path:
    """Define <func>_auto_schedule as a forwarding call onto the mutated <func>.

    Carried over from the arm-C harness deliberately. Linking a separately
    generated *unmutated* _auto_schedule library made the output test
    structurally blind, because the drivers run the auto variant last into the
    same buffer and save that.
    """
    text = header.read_text()
    m = re.search(SIG_RE_TMPL.format(func=re.escape(func)), text)
    if not m:
        raise RuntimeError(f"cannot find `int {func}(...)` in {header}")
    params = " ".join(m.group(1).split())
    names = [re.findall(r"[A-Za-z_][A-Za-z0-9_]*", p)[-1]
             for p in params.split(",")]
    alias = f"{func}_auto_schedule"
    hdr = scratch / f"{alias}.h"
    hdr.write_text(f"""// generated by run_harness.make_auto_schedule_shim()
#ifndef ASTMUT_{alias.upper()}_H
#define ASTMUT_{alias.upper()}_H
#include "{header.name}"
#ifdef __cplusplus
extern "C" {{
#endif
HALIDE_FUNCTION_ATTRS
int {alias}({params});
#ifdef __cplusplus
}}
#endif
#endif
""")
    src = scratch / f"{alias}_shim.cpp"
    src.write_text(f"""// generated by run_harness.make_auto_schedule_shim()
#include "{alias}.h"
extern "C" int {alias}({params}) {{
    return {func}({', '.join(names)});
}}
""")
    obj = scratch / f"{alias}_shim.o"
    r = run([cxx, "-std=c++17", "-O2", "-Wno-psabi",
             *sum((["-I", str(i)] for i in includes), []),
             "-c", str(src), "-o", str(obj)], timeout=300)
    if r.returncode != 0:
        raise RuntimeError("shim compile failed\n"
                           + r.stderr.decode(errors="replace")[-2000:])
    return obj


# --------------------------------------------------------------- harness
class Harness:
    def __init__(self, args, app, appcfg, golden_app):
        self.a = args
        self.app = app
        self.cfg = appcfg              # halidemut AppConfig, shipped driver
        self.golden = golden_app       # AppConfig with the artifact-dumping
                                       # driver swapped in (may be the same)
        self.cxx = args.cxx
        self.objcopy = args.objcopy
        self.root = Path(args.halide_root)
        self.scratch = Path(args.scratch) / app
        self.includes = [Path(args.lowered_dir), self.scratch,
                         Path(args.halide_build) / "include",
                         self.root / "src" / "runtime", self.root / "tools"]
        self.env = dict(os.environ, HL_NUM_THREADS=str(args.hl_threads))

    # -- compile ----------------------------------------------------------
    def compile_obj(self, src: Path, obj: Path) -> subprocess.CompletedProcess:
        return run([self.cxx, "-std=c++17", f"-O{self.a.opt}", "-Wno-psabi",
                    *sum((["-I", str(i)] for i in self.includes), []),
                    "-c", str(src), "-o", str(obj)],
                   timeout=self.a.compile_timeout)

    # -- link -------------------------------------------------------------
    def driver_object(self, driver_source: Path) -> Path:
        """Compile a driver TU once and relink it per mutant.

        The mutator rewrites the emitted pipeline body; it never touches the
        emitted header, so every mutant of an app presents the driver with the
        same declarations and the driver object is identical every time. At
        corpus scale this is the difference between one compile and one per
        mutant, and it is the same trick halidemut.Runner already uses.
        """
        key = hashlib.sha1(str(driver_source).encode()).hexdigest()[:12]
        obj = self.scratch / f"driver-{key}.o"
        if obj.exists():
            return obj
        r = run([self.cxx, "-std=c++17", "-O2", "-Wno-psabi",
                 "-I/usr/include/libpng16",
                 *sum((["-I", str(i)] for i in self.includes), []),
                 "-c", str(driver_source), "-o", str(obj)],
                timeout=self.a.compile_timeout)
        if r.returncode != 0:
            raise RuntimeError(f"driver {driver_source} failed to compile\n"
                               + r.stderr.decode(errors="replace")[-3000:])
        return obj

    def link(self, driver_source: Path, objs, out: Path, extra_link=()):
        cmd = [self.cxx, "-std=c++17", "-O2", "-Wno-psabi",
               str(self.driver_object(driver_source)),
               *[str(o) for o in objs], *extra_link,
               str(self.a.runtime_a), "-o", str(out),
               "-lpng16", "-ljpeg", "-lpthread", "-ldl"]
        return run(cmd, timeout=self.a.link_timeout)

    # -- run --------------------------------------------------------------
    def run_driver(self, binary: Path, appcfg, rundir: Path, timeout: float):
        rundir.mkdir(parents=True, exist_ok=True)
        argv = [str(binary)]
        for x in appcfg.driver_args:
            argv.append(
                x.replace("{input}", str(self.root / appcfg.input_image)
                          if appcfg.input_image else "")
                 .replace("{output}",
                          str(rundir / (appcfg.output_artifact or "out.png")))
                 .replace("{outdir}", str(rundir)))
        t0 = time.monotonic()
        try:
            p = subprocess.run(argv, cwd=str(rundir), timeout=timeout,
                               env=self.env, stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE)
        except subprocess.TimeoutExpired:
            return None, "", time.monotonic() - t0, True
        return (p.returncode, p.stdout.decode(errors="replace"),
                time.monotonic() - t0, False)


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--app", required=True)
    ap.add_argument("--halide-root", required=True,
                    help="checkout that owns apps/ and src/runtime")
    ap.add_argument("--halide-build", required=True)
    ap.add_argument("--halidemut", required=True,
                    help="mutation/ dir of Halide-mutation-wip-c -- the ONLY "
                         "copy of apps.py that registers interpolate, "
                         "local_laplacian and stencil_chain")
    ap.add_argument("--tool", required=True, help="halide-ast-mutate binary")
    ap.add_argument("--emitted", required=True,
                    help="the app's lowered <func>.halide_generated.cpp")
    ap.add_argument("--lowered-dir", required=True,
                    help="directory holding <func>.h next to the emitted .cpp")
    ap.add_argument("--runtime-a", required=True)
    ap.add_argument("--scratch", default="/dev/shm/astmut",
                    help="tmpfs; one app at a time, deleted after")
    ap.add_argument("--out-csv", required=True)
    ap.add_argument("--cxx", default="/usr/lib/llvm-14/bin/clang++")
    ap.add_argument("--objcopy", default="objcopy")
    ap.add_argument("--ops", default="")
    ap.add_argument("--opt", default="2", choices=["0", "1", "2", "3"])
    ap.add_argument("--jobs", type=int, default=10,
                    help="never exceed the cores this process owns")
    ap.add_argument("--hl-threads", type=int, default=2)
    ap.add_argument("--limit", type=int, default=0,
                    help="stop after N points (smoke tests only)")
    ap.add_argument("--baseline-runs", type=int, default=3)
    ap.add_argument("--perf-runs", type=int, default=0,
                    help=">=3 enables test 3; each mutant is timed that many "
                         "times and the median compared against the band")
    ap.add_argument("--written-driver", default="",
                    help="hand-authored assertion driver for test 2 (written)")
    ap.add_argument("--compile-timeout", type=int, default=1800)
    ap.add_argument("--link-timeout", type=int, default=900)
    ap.add_argument("--keep-scratch", action="store_true")
    a = ap.parse_args(argv)

    sys.path.insert(0, a.halidemut)
    from halidemut.apps import APPS, golden_variant  # noqa: E402

    appcfg = APPS[a.app]
    golden_app = golden_variant(appcfg)
    h = Harness(a, a.app, appcfg, golden_app)
    emitted = Path(a.emitted)
    func = emitted.name.replace(".halide_generated.cpp", "")
    header = Path(a.lowered_dir) / f"{func}.h"

    scratch = h.scratch
    if scratch.exists():
        shutil.rmtree(scratch)
    (scratch / "src").mkdir(parents=True)
    (scratch / "obj").mkdir()
    (scratch / "run").mkdir()

    incs = sum((["-I", str(i)] for i in h.includes), [])
    log = lambda *m: print(*m, flush=True)

    # ---------------------------------------------------------- emit
    log(f"[{a.app}] emitting mutants into {scratch/'src'}")
    cmd = [a.tool, "--mode=emit", f"--out-dir={scratch/'src'}"]
    if a.ops:
        cmd.append(f"--ops={a.ops}")
    cmd += [str(emitted), "--", "clang++", "-std=c++17", "-Wno-psabi",
            *incs, "-c"]
    t0 = time.time()
    r = run(cmd, timeout=7200)
    if r.returncode != 0:
        log(r.stderr.decode(errors="replace")[-3000:])
        raise SystemExit(f"{a.app}: emit failed")
    points = parse_points(r.stdout.decode(errors="replace"),
                          scratch / "src", emitted.name[:-len(".cpp")])
    log(f"[{a.app}] {len(points)} points identified in {time.time()-t0:.0f}s")
    if a.limit:
        points = points[:a.limit]
        log(f"[{a.app}] limited to {len(points)} for this run")
    present = [p for p in points if p.source.exists()]
    if len(present) != len(points):
        log(f"[{a.app}] WARNING {len(points)-len(present)} points had no "
            f"emitted file; they are recorded as GEN_FAIL")

    # ------------------------------------------------------ baseline
    base_o = scratch / "obj" / "baseline.o"
    r = h.compile_obj(emitted, base_o)
    if r.returncode != 0:
        log(r.stderr.decode(errors="replace")[-3000:])
        raise SystemExit(f"{a.app}: baseline compile failed")
    base_tce = tce_digest(a.objcopy, base_o, scratch / "obj")
    log(f"[{a.app}] baseline object: tce={base_tce[:16]}")

    objs = [base_o]
    if appcfg.needs_auto_variant:
        objs.append(make_auto_schedule_shim(a.cxx, func, header, scratch,
                                            h.includes))
    shim_objs = objs[1:]

    def build_and_run(driver_cfg, mut_obj, tag, runs, timeout):
        """Link one driver against one pipeline object and run it."""
        binary = scratch / "obj" / f"{tag}"
        lr = h.link(Path(a.halide_root) / driver_cfg.driver_source,
                    [mut_obj, *shim_objs], binary)
        if lr.returncode != 0:
            return None, lr
        outs = []
        for i in range(runs):
            rd = scratch / "run" / f"{tag}-{i}"
            if rd.exists():
                shutil.rmtree(rd)
            outs.append(h.run_driver(binary, driver_cfg, rd, timeout))
        binary.unlink(missing_ok=True)
        return outs, lr

    # test 1 baseline: the shipped driver, unchanged
    outs, lr = build_and_run(appcfg, base_o, "base-shipped",
                             a.baseline_runs, 600)
    if outs is None:
        log(lr.stderr.decode(errors="replace")[-3000:])
        raise SystemExit(f"{a.app}: baseline shipped-driver link failed")
    codes = [o[0] for o in outs]
    if any(c != 0 for c in codes) or any(o[3] for o in outs):
        raise SystemExit(f"{a.app}: shipped driver fails on the unmutated "
                         f"build (exits {codes}) -- test 1 is broken")
    base_times = [o[2] for o in outs]
    base_median = statistics.median(base_times)
    noise = ((max(base_times) - min(base_times)) / base_median
             if base_median else 0.0)
    # timeout is a test-1 kill, so it has to be generous enough that a slow
    # machine is never mistaken for an infinite loop
    run_timeout = max(30.0, min(300.0, base_median * 8))
    log(f"[{a.app}] baseline test 1: {a.baseline_runs} runs, median "
        f"{base_median:.2f}s, noise {noise*100:.1f}%, timeout {run_timeout:.0f}s")

    # test 2 (golden) baseline: the artifact-dumping driver where one exists
    golden_dir = scratch / "run" / "base-golden-0"
    outs, lr = build_and_run(golden_app, base_o, "base-golden",
                             a.baseline_runs, run_timeout)
    if outs is None:
        log(lr.stderr.decode(errors="replace")[-3000:])
        raise SystemExit(f"{a.app}: baseline golden-driver link failed")
    sigs = []
    for i, (code, sout, secs, timed) in enumerate(outs):
        if timed or code != 0:
            raise SystemExit(f"{a.app}: golden baseline run {i} failed")
        rd = scratch / "run" / f"base-golden-{i}"
        if golden_app.output_artifact:
            art = rd / golden_app.output_artifact
            sigs.append(sha256_file(art) or "<missing>")
        else:
            sigs.append("<no-artifact>")
    if golden_app.output_artifact and len(set(sigs)) != 1:
        raise SystemExit(f"{a.app}: golden artifact is NOT deterministic over "
                         f"{a.baseline_runs} runs -- no golden verdict can be "
                         f"trusted here")
    golden_sig = sigs[0]
    independent_golden = bool(golden_app.output_artifact)
    log(f"[{a.app}] baseline test 2 (golden): "
        f"{'sha256=' + golden_sig[:16] if independent_golden else 'NO ARTIFACT -- test 2 cannot observe pipeline output; recorded NOT_RUN'}")

    written_cfg = None
    if a.written_driver:
        written_cfg = dataclasses.replace(
            appcfg, driver_source=a.written_driver, output_artifact=None,
            extra_driver_outputs=[])
        outs, lr = build_and_run(written_cfg, base_o, "base-written", 1,
                                 run_timeout)
        if outs is None or outs[0][0] != 0:
            raise SystemExit(f"{a.app}: the written test must pass on the "
                             f"unmutated pipeline before it can score anything")
        log(f"[{a.app}] baseline test 2 (written): passes")

    perf_band = None
    if a.perf_runs >= 3:
        # A threshold from this app's own noise, not a global constant.
        tol = max(0.25, 4 * noise)
        perf_band = (base_median / (1 + tol), base_median * (1 + tol))
        log(f"[{a.app}] test 3 band: {perf_band[0]:.3f}s .. "
            f"{perf_band[1]:.3f}s (tolerance {tol*100:.0f}%)")

    # ---------------------------------------------------------- sweep
    fh = open(a.out_csv, "w", newline="")
    w = csv.DictWriter(fh, fieldnames=CSV_FIELDS, lineterminator="\n")
    w.writeheader()
    lock = __import__("threading").Lock()
    counts = {"tce": 0, "compile_fail": 0, "link_fail": 0, "run": 0,
              "killed": 0, "resolved": 0}

    def evaluate(p: Point) -> dict:
        row = dict(app=a.app, route="ast_emitted", mutant_uid=p.uid,
                   op_id=p.op_id, file=Path(p.file).name, line=p.line,
                   column=p.column, target=p.target,
                   ordinal_this_run=p.ordinal, stage_compile="OK", tce="",
                   stage_link="OK", killed_by="", killed=0, resolved=0,
                   resolution="", exit_code="", wall_seconds="",
                   perf_median="", artifact_digest="", note="")
        for k in TEST_KINDS:
            row[k] = "NOT_RUN"
        tag = p.uid
        obj = scratch / "obj" / f"{tag}.o"
        try:
            if not p.source.exists():
                row["stage_compile"] = "GEN_FAIL"
                row["note"] = "the tool emitted no file for this point"
                return row
            cr = h.compile_obj(p.source, obj)
            if cr.returncode != 0:
                row["stage_compile"] = "COMPILE_FAIL"
                row["note"] = ("the compiler rejected the mutant -- a kill "
                               "category only staged compilation produces, "
                               "not a test kill")
                return row
            d = tce_digest(a.objcopy, obj, scratch / "obj")
            row["tce"] = d[:16]
            if d == base_tce:
                row["resolved"] = 1
                row["resolution"] = "equivalent_tce"
                row["note"] = ("bit-identical machine code at -O%s: no test "
                               "can distinguish it" % a.opt)
                return row

            runs = max(1, a.perf_runs)
            # test 1: the shipped driver, unchanged
            outs, lr = build_and_run(appcfg, obj, f"{tag}-t1", runs,
                                     run_timeout)
            if outs is None:
                row["stage_link"] = "LINK_FAIL"
                row["note"] = "mutant object failed to link into the driver"
                return row
            code, sout, secs, timed = outs[0]
            row["exit_code"] = "" if code is None else code
            row["wall_seconds"] = f"{secs:.3f}"
            if timed:
                # No artifact was written, so test 2 had nothing to compare.
                row["test1_demo"] = "KILLED"
                row["note"] = "run timeout"
            else:
                row["test1_demo"] = "KILLED" if code != 0 else "SURVIVED"

            # test 3: median wall time against the app's own noise band
            if perf_band and not timed:
                med = statistics.median(o[2] for o in outs)
                row["perf_median"] = f"{med:.3f}"
                row["test3_perf"] = ("KILLED"
                                     if not (perf_band[0] <= med <= perf_band[1])
                                     else "SURVIVED")
            elif perf_band and timed:
                row["test3_perf"] = "KILLED"

            # test 2 (golden): only where an artifact actually exists
            if independent_golden and not timed:
                gouts, glr = build_and_run(golden_app, obj, f"{tag}-t2g", 1,
                                           run_timeout)
                if gouts is None:
                    row["note"] = (row["note"] + "; golden driver link failed").strip("; ")
                else:
                    gcode, _, _, gtimed = gouts[0]
                    art = (scratch / "run" / f"{tag}-t2g-0"
                           / golden_app.output_artifact)
                    sig = sha256_file(art) or "<missing>"
                    row["artifact_digest"] = sig[:16]
                    # An output comparison can only return a verdict when
                    # there IS an output. A golden run that timed out, aborted
                    # or exited nonzero wrote no artifact; its digest reads
                    # "<missing>", compares unequal to the golden, and was
                    # being scored KILLED -- crediting the added test with a
                    # kill on a mutant test 1 had already caught. Measured on
                    # resize: 76 of 330 test2 kills. The timeout case was
                    # already guarded here; the abort case was not.
                    if gtimed:
                        row["test2_golden"] = "NOT_RUN"
                        row["note"] = (row["note"] + "; golden run timed out, "
                                       "no artifact").strip("; ")
                    elif gcode != 0:
                        row["test2_golden"] = "NOT_RUN"
                        row["note"] = (row["note"] + f"; golden driver exited "
                                       f"{gcode}, wrote no artifact -- test1 "
                                       f"kill only").strip("; ")
                    elif not art.exists():
                        row["test2_golden"] = "NOT_RUN"
                        row["note"] = (row["note"] + "; golden driver exited 0 "
                                       "but wrote no artifact").strip("; ")
                    else:
                        row["test2_golden"] = ("KILLED" if sig != golden_sig
                                               else "SURVIVED")
            elif not independent_golden:
                row["note"] = (row["note"] +
                               "; no artifact: test 2 (golden) cannot observe "
                               "pipeline output here").strip("; ")

            # test 2 (written)
            if written_cfg is not None and not timed:
                wouts, wlr = build_and_run(written_cfg, obj, f"{tag}-t2w", 1,
                                           run_timeout)
                if wouts is not None:
                    wcode, _, _, wtimed = wouts[0]
                    row["test2_written"] = ("KILLED"
                                            if (wtimed or wcode != 0)
                                            else "SURVIVED")
            return row
        finally:
            obj.unlink(missing_ok=True)
            for d in (scratch / "run").glob(f"{tag}-*"):
                shutil.rmtree(d, ignore_errors=True)
            row["killed_by"] = ";".join(k for k in TEST_KINDS
                                        if row[k] == "KILLED")
            row["killed"] = int(bool(row["killed_by"]))
            if row["killed"]:
                row["resolved"] = 1
                row["resolution"] = "killed"

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
                row.update(app=a.app, route="ast_emitted", mutant_uid=p.uid,
                           op_id=p.op_id, file=Path(p.file).name, line=p.line,
                           column=p.column, target=p.target,
                           stage_compile="HARNESS_ERROR",
                           note=f"{type(exc).__name__}: {exc}"[:200])
                for k in TEST_KINDS:
                    row[k] = "NOT_RUN"
            with lock:
                w.writerow(row)
                fh.flush()
                if row["resolution"] == "equivalent_tce":
                    counts["tce"] += 1
                if row["stage_compile"] in ("COMPILE_FAIL", "GEN_FAIL"):
                    counts["compile_fail"] += 1
                if row["stage_link"] == "LINK_FAIL":
                    counts["link_fail"] += 1
                if row["test1_demo"] != "NOT_RUN" or row["test2_golden"] != "NOT_RUN":
                    counts["run"] += 1
                counts["killed"] += int(row["killed"] or 0)
                counts["resolved"] += int(row["resolved"] or 0)
            done += 1
            if done % 50 == 0 or done == len(points):
                log(f"[{a.app}] {done}/{len(points)}  tce={counts['tce']} "
                    f"run={counts['run']} killed={counts['killed']} "
                    f"({time.time()-t0:.0f}s)")
    fh.close()

    n = len(points)
    log("")
    log(f"points identified   {n}")
    log(f"mutants generated   {n - counts['compile_fail']}")
    log(f"  compiler rejected {counts['compile_fail']}")
    log(f"  equivalent (TCE)  {counts['tce']}  "
        f"({100.0*counts['tce']/n if n else 0:.1f}% of points)")
    log(f"  link failed       {counts['link_fail']}")
    log(f"mutants run         {counts['run']}")
    log(f"mutants killed      {counts['killed']}")
    log(f"RESOLVED            {counts['resolved']}/{n} "
        f"({100.0*counts['resolved']/n if n else 0:.1f}%)  "
        f"= killed by some kind, or proven equivalent")
    log(f"wall {time.time()-t0:.0f}s on {a.jobs} workers -> {a.out_csv}")

    if not a.keep_scratch:
        shutil.rmtree(scratch, ignore_errors=True)
        log(f"[{a.app}] scratch deleted; the next app can have the tmpfs")
    return 0


if __name__ == "__main__":
    sys.exit(main())
