#!/usr/bin/env python3
"""Arm C at full corpus scale: stock `cxx_default` mutation of Halide's own
emitted (C-backend) C++, on a 128-core/251GB host.

This is the same mechanism as `mutate_only.py` (lower the generator to C++ with
`-e c_source,c_header`, instrument that .cpp with Mull's stock C++ mutator
group, link it into the app's real driver, run one process per mutant behind
Mull's env-var dispatch), with three changes that the bigger machine makes
possible/necessary:

1. **No 10-minute timebox.** A per-app budget (default 2h) covers
   compile+link+baseline+sweep so one stuck app cannot eat the session, but it
   is 12x the old one and the sweep is no longer the part that overruns.
2. **Parallel sweep.** Mutants are independent processes over one shared
   instrumented binary; they are dispatched over a worker pool instead of a
   `for` loop. `HL_NUM_THREADS` is pinned (default 2) for the baseline *and*
   every mutant, so the pool's parallelism dominates and verdicts reproduce.
   It must be >= 2: at 1 the emitted `halide_do_par_for` degenerates to a
   single task and mutations in the task-splitting arithmetic stop being
   observable. Measured on blur, whose driver aborts on a wrong result --
   5 mutants killed at every thread count from 2 to 32 survive at 1, and a
   6th segfaults only at 1. From 2 upward every verdict is identical, so 2 is
   the cheapest faithful setting and leaves the most room for the pool.
3. **The `_auto_schedule` companion is a shim onto the mutated pipeline, not a
   separately generated native library.** Every `filter.cpp`/`process.cpp` in
   this corpus calls `<app>(...)` and then `<app>_auto_schedule(...)` into the
   *same* output buffer and saves the result of the second call. Linking an
   unmutated native `<app>_auto_schedule.a` (what the earlier run did)
   therefore overwrites every trace of the mutation before the image is
   written, making O2 structurally blind -- exactly the "O1 and O2 identical on
   every single mutant" anomaly the earlier harris run reported. In arm A the
   two variants come from one mutated generator, so both see the mutation;
   defining `<app>_auto_schedule` as a forwarding shim onto the mutated
   `<app>` restores that property here without touching any shipped driver.

Usage:
    python3 arm_c_swsec.py lower  <app> ...     # phase 1, emit C++
    python3 arm_c_swsec.py build  <app> ...     # phase 2, instrument + link
    python3 arm_c_swsec.py sweep  <app> ...     # phase 3, run every mutant
    python3 arm_c_swsec.py all    <app> ...     # 1+2+3
Environment: ARMC_JOBS / ARMC_HEAVY_JOBS (sweep workers), ARMC_BUDGET (s/app),
             ARMC_HL_THREADS (Halide runtime threads per mutant run, >= 2).
"""
import csv
import json
import os
import re
import random
import shutil
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor

R = "/mnt/scratch1/ardi/dsl_mut"
REPO = f"{R}/HM-armc-fix"  # isolated worktree, branch armc-unblock-camera-bgu
CLANG = "/usr/lib/llvm-14/bin/clang++"
MULL_IR = f"{R}/mull-ps/output/mull-ir-frontend-14"
BUILD_INC = f"{REPO}/build/include"
SRC_RUNTIME = f"{REPO}/src/runtime"
TOOLS = f"{REPO}/tools"
SCRATCH = f"{R}/armc-work"
RESULTS = f"{REPO}/mutation/results-arm-c"
LOWERED = f"{REPO}/mutation/lowered-cpp"
IMG_CFLAGS = ["-I/usr/include/libpng16"]
IMG_LIBS = ["-lpng16", "-ljpeg"]

BUDGET = int(os.environ.get("ARMC_BUDGET", "7200"))
HL_THREADS = os.environ.get("ARMC_HL_THREADS", "2")
JOBS = int(os.environ.get("ARMC_JOBS", "40"))
# Apps flagged `heavy` get their own width: a bigger emitted file means a
# bigger per-run working set, and their drivers run the pipeline for longer.
HEAVY_JOBS = int(os.environ.get("ARMC_HEAVY_JOBS", "24"))

sys.path.insert(0, LOWERED)
from cxx_default_arm.bucket_mutants import region_bounds, classify  # noqa: E402

# The trailing `timing_iterations` argument of the drivers that take one is set
# to 1, not the 10 their usage strings suggest. It is purely a benchmark repeat
# count -- `benchmark(timing_iterations, k, ...)` re-runs an already-deterministic
# pipeline and reports the minimum -- so it changes wall time and nothing else.
# At 10, bilateral_grid runs its pipeline 200 times per mutant (100 manual, 100
# auto-scheduled) for a 224s baseline; at 1 the same verdict costs ~22s.
#
# artifact:  None -> the driver writes no comparable output file, so O2 has
#            nothing independent to check and falls back to O1 (same
#            convention arm A used for blur/c_backend/conv_layer/dwsc).
# heavy:     run the instrumented compile in the small-concurrency group and
#            sweep with fewer workers (bigger emitted file / bigger working set).
APPS = {
    "blur": dict(gen_src="apps/blur/halide_blur_generator.cpp", gen="halide_blur",
                 func="halide_blur", driver="apps/blur/test.cpp", args=[],
                 image=None, artifact=None, auto_sched=False),
    "harris": dict(gen="harris", func="harris", driver="apps/harris/filter.cpp",
                   args=["{input}", "{output}"], image="apps/images/rgba.png",
                   artifact="output"),
    "unsharp": dict(gen="unsharp", func="unsharp", driver="apps/unsharp/filter.cpp",
                    args=["{input}", "{output}"], image="apps/images/rgba.png",
                    artifact="output"),
    "hist": dict(gen="hist", func="hist", driver="apps/hist/filter.cpp",
                 args=["{input}", "{output}"], image="apps/images/rgba.png",
                 artifact="output"),
    "iir_blur": dict(gen="iir_blur", func="iir_blur", driver="apps/iir_blur/filter.cpp",
                     args=["{input}", "{output}"], image="apps/images/rgba.png",
                     artifact="output"),
    "max_filter": dict(gen="max_filter", func="max_filter", driver="apps/max_filter/filter.cpp",
                       args=["{input}", "{output}"], image="apps/images/rgba.png",
                       artifact="output"),
    "bilateral_grid": dict(gen="bilateral_grid", func="bilateral_grid",
                           driver="apps/bilateral_grid/filter.cpp",
                           args=["{input}", "{output}", "0.1", "1"],
                           image="apps/images/gray.png", artifact="output", heavy=True),
    "conv_layer": dict(gen="conv_layer", func="conv_layer", driver="apps/conv_layer/process.cpp",
                       args=[], image=None, artifact=None),
    "depthwise_separable_conv": dict(gen="depthwise_separable_conv",
                                     func="depthwise_separable_conv",
                                     driver="apps/depthwise_separable_conv/process.cpp",
                                     args=[], image=None, artifact=None, heavy=True),
    "nl_means": dict(gen="nl_means", func="nl_means", driver="apps/nl_means/process.cpp",
                     args=["{input}", "7", "7", "0.12", "1", "{output}"],
                     image="apps/images/rgb.png", artifact="output", heavy=True),
    "lens_blur": dict(gen="lens_blur", func="lens_blur", driver="apps/lens_blur/process.cpp",
                      args=["{input}", "32", "13", "0.5", "32", "1", "{output}"],
                      image="apps/images/rgb_small.png", artifact="output", heavy=True),
    # Both of the following fail to compile as plain C++ regardless of mutation
    # -- verified with a bare `clang++ -c`. Kept in the table so `verify` can
    # re-check them, excluded from the sweep list.
    # UNBLOCKED 2026-08-21: the C-backend compile error is fixed (see
    # C_BACKEND_FIXES / _fix_camera_pipe_prefetch below) -- no longer
    # backend_broken, fully sweepable, 1163/1163 swept.
    "camera_pipe": dict(gen="camera_pipe", func="camera_pipe",
                        driver="apps/camera_pipe/process.cpp",
                        args=["{input}", "3700", "2.0", "50", "1.0", "1", "{output}",
                              "{scratch}/h_auto.png"],
                        image="apps/images/bayer_raw.png", artifact="output",
                        heavy=True),
    # bgu: the C-backend compile error is ALSO fixed (see
    # _fix_bgu_fast_inverse below, 0 syntax errors verified) -- but still
    # excluded from SWEEPABLE. A separate, later problem: Mull's own
    # mull-ir-frontend-14 instrumentation of the corrected file either
    # segfaults (mull::mutateBitcode, avoidable by raising the process stack
    # ulimit) or, with that avoided, runs 87+ minutes at a stable ~73GB RSS
    # without finishing -- a wall-clock wall in Mull's single-threaded
    # mutation-application pipeline on this benchmark's unusually large
    # (16,164-line), arithmetic-dense emitted file, not a memory problem and
    # not fixable by more patience within a practical budget. See BLOCKED.md.
    "bgu": dict(gen="bgu", func="bgu", driver="apps/bgu/filter.cpp",
                args=["{input}", "{output}"], image="apps/images/rgb.png",
                artifact="output", heavy=True, backend_broken=True),
}

SWEEPABLE = [a for a, c in APPS.items() if not c.get("backend_broken")]


def cfg(app):
    c = dict(gen_src=f"apps/{app}/{app}_generator.cpp", auto_sched=True,
             heavy=False, backend_broken=False)
    c.update(APPS[app])
    return c


def run(cmd, timeout=600, **kw):
    print("+", " ".join(str(x) for x in cmd), flush=True)
    r = subprocess.run([str(x) for x in cmd], capture_output=True, text=True,
                       timeout=timeout, **kw)
    if r.returncode != 0:
        print(r.stdout[-3000:])
        print(r.stderr[-3000:])
        raise RuntimeError(f"failed ({r.returncode}): {' '.join(str(x) for x in cmd)}")
    return r


def gengen_o():
    """tools/GenGen.cpp, compiled once and shared by every generator link."""
    o = f"{SCRATCH}/gengen.o"
    if not os.path.exists(o):
        os.makedirs(SCRATCH, exist_ok=True)
        run([CLANG, "-std=c++17", "-O1", "-I", BUILD_INC, "-I", TOOLS,
             "-c", f"{TOOLS}/GenGen.cpp", "-o", o])
    return o


def generator_binary(app):
    c = cfg(app)
    scratch = f"{SCRATCH}/{app}"
    os.makedirs(scratch, exist_ok=True)
    gen_bin = f"{scratch}/{app}.generator"
    if not os.path.exists(gen_bin):
        run([CLANG, "-std=c++17", "-O1", "-g", "-I", BUILD_INC, "-I", TOOLS,
             "-c", f"{REPO}/{c['gen_src']}", "-o", f"{scratch}/gen.o"], timeout=900)
        run([CLANG, f"{scratch}/gen.o", gengen_o(), "-o", gen_bin,
             "-L", f"{REPO}/build/src", "-lHalide",
             f"-Wl,-rpath,{REPO}/build/src", "-lpthread", "-ldl"], timeout=900)
    return gen_bin


def runtime_a():
    """Halide's C runtime, target=host, generator-agnostic: the emitted .cpp
    only extern-declares halide_error_*/halide_malloc/halide_do_par_for."""
    a = f"{SCRATCH}/runtime.a"
    if not os.path.exists(a):
        gen_bin = generator_binary("blur")
        run([gen_bin, "-r", "runtime", "-o", SCRATCH, "target=host"], timeout=600)
    return a


# --------------------------------------------------------------------------
# phase 1: lower
# --------------------------------------------------------------------------
# Two of Halide's own C-backend code-generation bugs, worked around here
# mechanically rather than left as an exclusion. Both were re-verified with a
# bare `clang++ -fsyntax-only` (no Mull, no mutation tooling) before and
# after the fix, so these are genuine Halide codegen faults, not
# mutation-tooling artifacts, and the fixes below only ADD content -- they
# never touch an existing declaration or expression -- so neither can change
# program behaviour. See mutation/results-arm-c/BLOCKED.md for the writeup.
def _fix_camera_pipe_prefetch(text):
    """camera_pipe's `.prefetch()` schedule directive lowers to
    `uint16_t x = __builtin_prefetch(...)` -- a void builtin's result
    assigned to an integer, which does not compile. Halide v21's C backend
    fixes this upstream by wrapping the call in a comma expression that
    discards the void result and yields 0 instead; this reproduces that same
    transformation verbatim on the older backend's output. The prefetch
    still executes for its side effect (a pure cache hint with no effect on
    correctness either way); the dummy temporary it initializes was already
    write-only (passed straight to `halide_maybe_unused` and never read)."""
    old = ("uint16_t _91 = __builtin_prefetch(((uint16_t *)_input + _90), "
           "/*rw*/0, /*locality*/0);")
    new = ("uint16_t _91 = (__builtin_prefetch(((uint16_t *)_input + _90), "
           "/*rw*/0, /*locality*/0), 0);")
    n = text.count(old)
    if n == 0:
        return text, 0
    assert n == 1, f"expected exactly 1 occurrence, found {n}"
    return text.replace(old, new), 1


def _fix_bgu_fast_inverse(text):
    """bgu's Cholesky solve calls Halide's `fast_inverse` intrinsic both at
    its native vector width (float8, from the surrounding schedule's
    `vectorize(x, 8)`) and, after the backend's own per-lane scalarization of
    that vectorized stage, at scalar width -- but the C backend forward-
    declares each extern callee exactly once, keyed only by function name
    (src/CodeGen_C.cpp, ExternCallPrototypes::visit(Call*)), not by
    (name, signature). Only the float8 overload ever gets declared, so the
    scalarized call sites resolve against it via an implicit float->float8
    splat and return the wrong type. The scalar entry point already exists:
    Halide's own runtime (src/runtime/x86.ll) defines a weak_odr
    `float @fast_inverse_f32(float)` via the same SSE rcp.ss approximate-
    reciprocal instruction the vector form uses per lane, and it is already
    linked into every arm-C binary -- this adds only the missing C++
    prototype for that pre-existing symbol. extern "C" linkage cannot carry
    two overloads of the same name, so the added declaration uses ordinary
    C++ linkage plus an asm-label to bind to the identical external symbol:
    no new code, no behaviour change, nothing here executes differently than
    what the runtime already does for the vector form."""
    old = "float8 fast_inverse_f32(float8 );\n"
    n = text.count(old)
    if n == 0:
        return text, 0
    assert n == 1, f"expected exactly 1 occurrence, found {n}"
    new = (old +
           '}  // extern "C" (closed early: fast_inverse_f32 needs a genuine\n'
           '   // C++ overload below, which extern "C" linkage forbids)\n'
           "// --- mechanical, behaviour-preserving fix for a Halide C-backend\n"
           "// forward-declaration bug -- see _fix_bgu_fast_inverse() docstring\n"
           "// in arm_c_swsec.py for the full explanation. ---\n"
           'float fast_inverse_f32(float x) asm("fast_inverse_f32");\n'
           'extern "C" {\n')
    return text.replace(old, new), 1


C_BACKEND_FIXES = {
    "camera_pipe": _fix_camera_pipe_prefetch,
    "bgu": _fix_bgu_fast_inverse,
}


def lower(app):
    c = cfg(app)
    t0 = time.time()
    lowered_dir = f"{LOWERED}/{app}"
    os.makedirs(lowered_dir, exist_ok=True)
    emitted = f"{lowered_dir}/{c['func']}.halide_generated.cpp"
    if os.path.exists(emitted) and os.path.getsize(emitted) > 0:
        print(f"SKIP lower {app}: {os.path.basename(emitted)} already present")
        return dict(app=app, status="ALREADY_LOWERED", bytes=os.path.getsize(emitted))
    gen_bin = generator_binary(app)
    run([gen_bin, "-g", c["gen"], "-o", lowered_dir, "-f", c["func"],
         "-e", "c_source,c_header,stmt", "target=host"], timeout=1800)
    if not os.path.exists(emitted):
        raise RuntimeError(f"lowering produced no {emitted}")
    fixed = 0
    if app in C_BACKEND_FIXES:
        text = open(emitted).read()
        text, fixed = C_BACKEND_FIXES[app](text)
        if fixed:
            open(emitted, "w").write(text)
    return dict(app=app, status="LOWERED", bytes=os.path.getsize(emitted),
                seconds=round(time.time() - t0, 1), c_backend_fix_applied=bool(fixed))


# --------------------------------------------------------------------------
# phase 2: instrument + link
# --------------------------------------------------------------------------
SIG_RE_TMPL = r"HALIDE_FUNCTION_ATTRS\s*\nint\s+{func}\s*\(([^;]*?)\)\s*;"


def make_auto_schedule_shim(app, scratch):
    """Define <app>_auto_schedule as a forwarding call onto the mutated <app>.

    Every driver in this corpus runs the manual variant, then the
    auto-scheduled variant into the same buffer, then writes that buffer out.
    Arm A gets both variants from one mutated generator; this reproduces that
    here (see module docstring). Returns the compiled object file."""
    c = cfg(app)
    header = f"{LOWERED}/{app}/{c['func']}.h"
    text = open(header).read()
    m = re.search(SIG_RE_TMPL.format(func=re.escape(c["func"])), text)
    if not m:
        raise RuntimeError(f"cannot find `int {c['func']}(...)` in {header}")
    params = " ".join(m.group(1).split())
    names = []
    for p in params.split(","):
        ids = re.findall(r"[A-Za-z_][A-Za-z0-9_]*", p)
        names.append(ids[-1])
    alias = f"{app}_auto_schedule"
    hdr = f"{scratch}/{alias}.h"
    with open(hdr, "w") as f:
        f.write(f"""// Generated by arm_c_swsec.py -- see make_auto_schedule_shim().
#ifndef ARMC_{alias.upper()}_H
#define ARMC_{alias.upper()}_H
#include "{c['func']}.h"
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
    src = f"{scratch}/{alias}_shim.cpp"
    with open(src, "w") as f:
        f.write(f"""// Generated by arm_c_swsec.py -- see make_auto_schedule_shim().
#include "{alias}.h"
extern "C" int {alias}({params}) {{
    return {c['func']}({', '.join(names)});
}}
""")
    obj = f"{scratch}/{alias}_shim.o"
    run([CLANG, "-std=c++17", "-O2", "-I", f"{LOWERED}/{app}", "-I", scratch,
         "-I", BUILD_INC, "-c", src, "-o", obj], timeout=300)
    return obj


def build(app, budget=BUDGET):
    c = cfg(app)
    t0 = time.time()
    scratch = f"{SCRATCH}/{app}"
    os.makedirs(scratch, exist_ok=True)
    lowered_dir = f"{LOWERED}/{app}"
    emitted = f"{lowered_dir}/{c['func']}.halide_generated.cpp"
    if not os.path.exists(emitted):
        raise RuntimeError(f"not lowered: {emitted}")

    yml = f"{scratch}/mull.yml"
    with open(yml, "w") as f:
        f.write("mutators:\n  - cxx_default\ntimeout: 99999999\nquiet: false\n"
                "includePaths:\n  - .*\n")
    env = dict(os.environ, MULL_CONFIG=yml)
    mut_o = f"{scratch}/{app}_cxx.o"
    remaining = max(600, budget - (time.time() - t0))
    r = run([CLANG, "-std=c++17", "-O1", "-g", "-grecord-command-line",
             f"-fpass-plugin={MULL_IR}", "-c", emitted, "-o", mut_o],
            env=env, timeout=remaining)
    compile_seconds = round(time.time() - t0, 1)
    raw = None
    mraw = re.search(r"Found (\d+) mutants", r.stderr + r.stdout)
    if mraw:
        raw = int(mraw.group(1))

    strings_out = subprocess.run(["strings", mut_o], capture_output=True,
                                 text=True).stdout
    pat = re.compile(rf"^cxx_[a-z_]+:{re.escape(emitted)}:\d+:\d+$", re.M)
    mutants = sorted(set(pat.findall(strings_out)))
    if not mutants:
        raise RuntimeError("zero mutants extracted from the instrumented object")
    with open(f"{scratch}/mutants.txt", "w") as f:
        f.write("\n".join(mutants) + "\n")

    objs = [mut_o]
    if c["auto_sched"]:
        objs.append(make_auto_schedule_shim(app, scratch))

    binary = f"{scratch}/instrumented"
    link = ([CLANG, "-std=c++17", "-O2", "-Wall"] + IMG_CFLAGS +
            ["-I", lowered_dir, "-I", scratch, "-I", BUILD_INC, "-I", SRC_RUNTIME,
             "-I", TOOLS, f"{REPO}/{c['driver']}"] + objs +
            [runtime_a(), "-o", binary] + IMG_LIBS + ["-lpthread", "-ldl"])
    run(link, timeout=900)

    meta = dict(app=app, mutants=len(mutants), raw_candidates=raw,
                compile_seconds=compile_seconds, binary=binary,
                emitted=emitted, status="BUILT",
                total_seconds=round(time.time() - t0, 1))
    with open(f"{scratch}/build.json", "w") as f:
        json.dump(meta, f, indent=2)
    print(f"BUILT {app}: {len(mutants)} mutants "
          f"(compile {compile_seconds}s, total {meta['total_seconds']}s)")
    return meta


# --------------------------------------------------------------------------
# phase 3: sweep
# --------------------------------------------------------------------------
def sweep(app, budget=BUDGET, jobs=None):
    c = cfg(app)
    t0 = time.time()
    scratch = f"{SCRATCH}/{app}"
    meta = json.load(open(f"{scratch}/build.json"))
    binary = meta["binary"]
    emitted = meta["emitted"]
    mutants = [l.strip() for l in open(f"{scratch}/mutants.txt") if l.strip()]
    workers = jobs or (HEAVY_JOBS if c["heavy"] else JOBS)
    image = f"{REPO}/{c['image']}" if c["image"] else None
    base_env = dict(os.environ, HL_NUM_THREADS=HL_THREADS)

    def argv_for(out_path, wdir):
        return [a.format(input=image, output=out_path, scratch=wdir)
                for a in c["args"]]

    # --- baseline, under exactly the mutant environment minus any mutant key
    base_dir = f"{scratch}/baseline"
    shutil.rmtree(base_dir, ignore_errors=True)
    os.makedirs(base_dir)
    base_out = f"{base_dir}/out.png" if c["artifact"] else None
    t_b = time.time()
    rb = subprocess.run([binary] + argv_for(base_out, base_dir),
                        capture_output=True, text=True, timeout=1800,
                        env=base_env, cwd=base_dir)
    base_seconds = time.time() - t_b
    if rb.returncode != 0:
        print(rb.stdout[-2000:]); print(rb.stderr[-2000:])
        raise RuntimeError(f"baseline run failed, exit={rb.returncode}")
    base_bytes = open(base_out, "rb").read() if base_out else None
    per_mutant_timeout = max(30, min(300, base_seconds * 8))
    print(f"{app}: baseline OK in {base_seconds:.1f}s; "
          f"{len(mutants)} mutants, {workers} workers, "
          f"per-mutant timeout {per_mutant_timeout:.0f}s", flush=True)

    boiler_end, genspec_end = region_bounds(f"{LOWERED}/{app}")
    deadline = t0 + budget
    done = [0]

    def one(idx_key):
        idx, key = idx_key
        if time.time() > deadline:
            return None
        wdir = f"{scratch}/w/{idx % (workers * 2)}"
        os.makedirs(wdir, exist_ok=True)
        out_path = f"{wdir}/out.png" if c["artifact"] else None
        if out_path and os.path.exists(out_path):
            os.remove(out_path)
        e = dict(base_env)
        e[key] = "1"
        t = time.time()
        try:
            r = subprocess.run([binary] + argv_for(out_path, wdir),
                               capture_output=True, text=True,
                               timeout=per_mutant_timeout, env=e, cwd=wdir)
            rc = r.returncode
        except subprocess.TimeoutExpired:
            rc = -9
        wall = time.time() - t
        o1 = 1 if rc != 0 else 0
        if c["artifact"]:
            if o1:
                o2 = 1
            else:
                try:
                    o2 = 0 if (os.path.exists(out_path) and
                               open(out_path, "rb").read() == base_bytes) else 1
                except OSError:
                    o2 = 1
        else:
            o2 = o1  # no comparable artifact: O2 restates O1 (arm-A convention)
        parts = key.split(":")
        done[0] += 1
        if done[0] % 200 == 0:
            print(f"  {app}: {done[0]}/{len(mutants)} "
                  f"({time.time()-t0:.0f}s)", flush=True)
        return [app, "cxx_default_on_emitted_cpp", parts[0],
                os.path.basename(emitted), parts[-2], parts[-1],
                classify(int(parts[-2]), boiler_end, genspec_end),
                rc, o1, o2, f"{wall:.3f}"]

    # Sweep in a fixed shuffled order, not in mutation-point order. If the
    # budget ever does cut a sweep short, the mutants that got a verdict are
    # then an unbiased sample of the population rather than whichever mutators
    # sort first alphabetically.
    order = list(enumerate(mutants))
    random.Random(0).shuffle(order)

    rows = []
    with ThreadPoolExecutor(max_workers=workers) as ex:
        for row in ex.map(one, order):
            if row is not None:
                rows.append(row)

    os.makedirs(RESULTS, exist_ok=True)
    out_csv = f"{RESULTS}/{app}-cxx_default.csv"
    with open(out_csv, "w", newline="") as f:
        w = csv.writer(f, lineterminator="\n")
        w.writerow(["app", "arm", "mutator", "file", "line", "column", "region",
                    "exit_code", "o1_killed", "o2_killed", "wall_seconds"])
        w.writerows(rows)
    shutil.rmtree(f"{scratch}/w", ignore_errors=True)

    swept = len(rows)
    o1k = sum(r[8] for r in rows)
    o2k = sum(r[9] for r in rows)
    status = "COMPLETE" if swept == len(mutants) else "PARTIAL(budget)"
    res = dict(app=app, status=status, mutants=len(mutants), swept=swept,
               o1_killed=o1k, o2_killed=o2k,
               o2_independent=bool(c["artifact"]),
               baseline_seconds=round(base_seconds, 2),
               sweep_seconds=round(time.time() - t0, 1), csv=out_csv,
               raw_candidates=meta.get("raw_candidates"),
               compile_seconds=meta.get("compile_seconds"))
    for path in (f"{scratch}/sweep.json", f"{RESULTS}/{app}-sweep.json"):
        with open(path, "w") as f:
            json.dump(res, f, indent=2)
    print(f"SWEPT {app} [{status}]: {swept}/{len(mutants)} "
          f"o1={o1k} o2={o2k} ({res['sweep_seconds']}s)", flush=True)
    return res


def verify_backend_broken(app):
    """Re-check that the emitted C++ does not compile as plain C++ at all --
    no Mull, no plugin, no mutation."""
    c = cfg(app)
    emitted = f"{LOWERED}/{app}/{c['func']}.halide_generated.cpp"
    if not os.path.exists(emitted):
        try:
            lower(app)
        except Exception as ex:
            return dict(app=app, stage="lower", status="LOWER_FAILED", error=str(ex))
    r = subprocess.run([CLANG, "-std=c++17", "-O1", "-fsyntax-only", emitted],
                       capture_output=True, text=True, timeout=1800)
    errs = [l for l in r.stderr.splitlines() if ": error:" in l]
    return dict(app=app, stage="plain-clang++", returncode=r.returncode,
                status="STILL_BROKEN" if r.returncode != 0 else "NOW_COMPILES",
                error_count=len(errs), first_errors=errs[:6])


def main():
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    phase, apps = sys.argv[1], sys.argv[2:]
    if not apps or apps == ["ALL"]:
        apps = SWEEPABLE
    fns = {"lower": [lower], "build": [build], "sweep": [sweep],
           "all": [lower, build, sweep], "verify": [verify_backend_broken]}[phase]
    out = []
    for app in apps:
        for fn in fns:
            try:
                out.append(fn(app))
            except Exception as ex:
                print(f"FAILED {app} @ {fn.__name__}: {ex}", flush=True)
                out.append(dict(app=app, stage=fn.__name__, status="FAILED",
                                error=str(ex)[:500]))
                break
    print("\n=== SUMMARY (%s) ===" % phase)
    for o in out:
        print(json.dumps(o))
    with open(f"{SCRATCH}/{phase}-summary.json", "w") as f:
        json.dump(out, f, indent=2)


if __name__ == "__main__":
    main()
