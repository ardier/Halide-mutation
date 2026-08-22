#!/usr/bin/env python3
"""Phase 1 (gap-closing): lower Halide apps/tutorials that have NEVER been
lowered to emitted C++, using `-e c_source,c_header` (NOT in the default
GENERATOR_OUTPUTS -- see apps/support/Makefile.inc:40).

Adapted from ../lower_only.py and arm_c_swsec.py's lower():
  - REPO is computed relative to this file's own location, since
    lower_only.py's hardcoded REPO path does not exist on swsec01.
  - Generalized to multi-generator apps: arm_c_swsec.py's lower() only
    handles apps pre-registered in its hardcoded APPS dict; none of the 8
    targets here (c_backend, fft, resize, wavelet, linear_blur, and 3
    tutorial generators) are registered there, so it KeyErrors as-is.

Scope: LOWERING ONLY. No mutation, no Mull, no sweep.

Usage: python3 lower_gap.py <target> [<target> ...] | all
Targets: c_backend fft resize wavelet linear_blur
         tut_lesson_15 tut_lesson_16 tut_lesson_21
"""
import os
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
# this file lives at <REPO>/mutation/lowered-cpp/cxx_default_arm/lower_gap.py
REPO = os.path.dirname(os.path.dirname(os.path.dirname(HERE)))
CLANG = "/usr/lib/llvm-14/bin/clang++"
BUILD_INC = f"{REPO}/build/include"
TOOLS = f"{REPO}/tools"
SCRATCH = "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gap-lower2/work"
LOWERED = f"{REPO}/mutation/lowered-cpp"


def run(cmd, timeout=600, **kw):
    print("+", " ".join(str(x) for x in cmd), flush=True)
    try:
        r = subprocess.run([str(x) for x in cmd], capture_output=True, text=True,
                            timeout=timeout, **kw)
    except subprocess.TimeoutExpired as ex:
        raise RuntimeError(f"command timed out after {timeout}s: {' '.join(str(x) for x in cmd)}") from ex
    if r.returncode != 0:
        print(r.stdout[-4000:])
        print(r.stderr[-4000:])
        raise RuntimeError(f"command failed ({r.returncode}): {' '.join(str(x) for x in cmd)}")
    return r


def gengen_o():
    o = f"{SCRATCH}/gengen.o"
    if not os.path.exists(o):
        os.makedirs(SCRATCH, exist_ok=True)
        run([CLANG, "-std=c++17", "-O1", "-I", BUILD_INC, "-I", TOOLS,
             "-c", f"{TOOLS}/GenGen.cpp", "-o", o])
    return o


def build_generator_bin(name, srcs, scratch, extra_inc=None):
    """Compile one or more generator .cpp source files (repo-relative paths)
    into a single generator binary. Mirrors what each app's own
    Makefile/CMakeLists does for `%.generator` (see apps/support/Makefile.inc
    GENERATOR_DEPS), just invoked directly instead of through make."""
    os.makedirs(scratch, exist_ok=True)
    objs = []
    inc = ["-I", BUILD_INC, "-I", TOOLS]
    if extra_inc:
        inc += ["-I", extra_inc]
    for src in srcs:
        obj = f"{scratch}/{os.path.basename(src)}.o"
        run([CLANG, "-std=c++17", "-O1", "-g"] + inc +
            ["-c", f"{REPO}/{src}", "-o", obj], timeout=600)
        objs.append(obj)
    gen_bin = f"{scratch}/{name}.generator"
    run([CLANG] + objs + [gengen_o(), "-o", gen_bin,
         "-L", f"{REPO}/build/src", "-lHalide",
         f"-Wl,-rpath,{REPO}/build/src", "-lpthread", "-ldl"], timeout=600)
    return gen_bin


def lower_one(gen_bin, gen_name, func_name, out_dir, target="host", extra_args=None):
    """Run a generator binary with -e c_source,c_header for one -g/-f pair."""
    os.makedirs(out_dir, exist_ok=True)
    args = [gen_bin, "-g", gen_name, "-o", out_dir, "-f", func_name,
            "-e", "c_source,c_header", f"target={target}"]
    if extra_args:
        args += extra_args
    t0 = time.time()
    run(args, timeout=600)
    elapsed = time.time() - t0
    emitted = f"{out_dir}/{func_name}.halide_generated.cpp"
    if not os.path.exists(emitted):
        raise RuntimeError(f"lowering produced no {emitted}")
    return dict(func=func_name, emitted=emitted, bytes=os.path.getsize(emitted),
                seconds=round(elapsed, 1))


# --------------------------------------------------------------------------
# per-target lowering
# --------------------------------------------------------------------------
def lower_fft():
    scratch = f"{SCRATCH}/fft"
    out_dir = f"{LOWERED}/fft"
    gen_bin = build_generator_bin("fft", ["apps/fft/fft_generator.cpp", "apps/fft/fft.cpp"], scratch)
    results = []
    # Primary/default variant per apps/fft/Makefile
    results.append(lower_one(gen_bin, "fft", "fft_forward_r2c", out_dir,
                              extra_args=["direction=samples_to_frequency", "size0=16", "size1=16",
                                          "gain=0.00390625", "input_number_type=real",
                                          "output_number_type=complex"]))
    return results


def lower_resize():
    scratch = f"{SCRATCH}/resize"
    out_dir = f"{LOWERED}/resize"
    gen_bin = build_generator_bin("resize", ["apps/resize/resize_generator.cpp"], scratch)
    results = []
    results.append(lower_one(gen_bin, "resize", "resize_linear_float32_up", out_dir,
                              extra_args=["interpolation_type=linear", "input.type=float32",
                                          "upsample=true"]))
    return results


def lower_c_backend():
    scratch = f"{SCRATCH}/c_backend"
    out_dir = f"{LOWERED}/c_backend"
    results = []
    gen1 = build_generator_bin("pipeline", ["apps/c_backend/pipeline_generator.cpp"], scratch)
    results.append(lower_one(gen1, "pipeline", "pipeline_c", out_dir))
    gen2 = build_generator_bin("pipeline_cpp", ["apps/c_backend/pipeline_cpp_generator.cpp"], scratch)
    # matches the app's own Makefile rule for pipeline_cpp_cpp.halide_generated.cpp
    results.append(lower_one(gen2, "pipeline_cpp", "pipeline_cpp_cpp", out_dir,
                              target="host-c_plus_plus_name_mangling"))
    return results


def lower_wavelet():
    scratch = f"{SCRATCH}/wavelet"
    out_dir = f"{LOWERED}/wavelet"
    results = []
    for gen_name in ["daubechies_x", "haar_x", "inverse_daubechies_x", "inverse_haar_x"]:
        gen_bin = build_generator_bin(gen_name, [f"apps/wavelet/{gen_name}_generator.cpp"], scratch)
        results.append(lower_one(gen_bin, gen_name, gen_name, out_dir))
    return results


def lower_linear_blur():
    scratch = f"{SCRATCH}/linear_blur"
    stub_dir = f"{scratch}/stubs"
    out_dir = f"{LOWERED}/linear_blur"
    os.makedirs(stub_dir, exist_ok=True)
    results = []
    # Each leaf generator declares its Func input with no fixed type/dims
    # (e.g. `Input<Func> input{"input"};`), so standalone lowering needs the
    # type/dim spelled out on the command line (Halide's own error message
    # names the mechanism: "you may need to specify 'input.type' as a
    # GeneratorParam"). float32/dim=3 matches how linear_blur itself calls
    # them (RGB Buffer<float,3>).
    leaf_srcs = {
        "simple_blur": ("apps/linear_blur/simple_blur_generator.cpp",
                         ["input.type=float32", "input.dim=3"]),
        "srgb_to_linear": ("apps/linear_blur/srgb_to_linear_generator.cpp",
                            ["srgb.type=float32", "srgb.dim=3"]),
        "linear_to_srgb": ("apps/linear_blur/linear_to_srgb_generator.cpp",
                            ["linear.type=float32", "linear.dim=3"]),
    }
    leaf_bins = {}
    for gen_name, (src, extra) in leaf_srcs.items():
        gen_bin = build_generator_bin(gen_name, [src], scratch)
        leaf_bins[gen_name] = gen_bin
        # produce the .stub.h that linear_blur_generator.cpp #includes
        run([gen_bin, "-g", gen_name, "-o", stub_dir, "-e", "cpp_stub"], timeout=300)
        # also lower each leaf generator standalone -- they are real,
        # independent generators in this app (in scope on their own)
        results.append(lower_one(gen_bin, gen_name, gen_name, out_dir, extra_args=extra))

    stub_files = os.listdir(stub_dir)
    print("stub dir contents:", stub_files)

    # composed generator: needs the OTHER three generator classes linked into
    # the SAME binary (GeneratorStub resolves them from the in-process
    # registry at generate() time), plus -I stub_dir so its #include
    # "*.stub.h" lines resolve.
    composed_srcs = ["apps/linear_blur/linear_blur_generator.cpp"] + [s for s, _ in leaf_srcs.values()]
    gen_bin = build_generator_bin("linear_blur", composed_srcs, scratch, extra_inc=stub_dir)
    # linear_blur_generator.cpp's generate() is unconditionally:
    #   if (using_autoscheduler()) { ... } else { assert(false); abort(); }
    # so it can ONLY be lowered with an autoscheduler plugin engaged. None of
    # Halide's autoscheduler .so plugins were built in HM-armc-fix/build (that
    # build dir is a SHARED symlink to /dev/shm/ardi_dslmut/halide16-build used
    # by other worktrees/agents -- confirmed via CMakeCache.txt's
    # CMAKE_HOME_DIRECTORY -- so we do not build autoschedulers *there*).
    # Fixed by hand-compiling the Mullapudi2016 (and Li2018) plugin .so
    # directly with clang++ against that build's already-built libHalide.so
    # and headers (read-only), mirroring src/autoschedulers/mullapudi2016/
    # Makefile's own recipe, output to a private scratch dir -- see
    # as-plugins/ next to this worktree. -p loads it; -s was removed in this
    # Halide version (16.0.0) in favor of the autoscheduler=NAME GeneratorParam
    # already used below.
    try:
        results.append(lower_one(gen_bin, "linear_blur", "linear_blur", out_dir,
                                  extra_args=["-p", "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gap-lower2/as-plugins/libautoschedule_mullapudi2016.so", "autoscheduler=Mullapudi2016"]))
    except Exception as ex:
        results.append(dict(func="linear_blur (composed)", status="FAILED", error=str(ex)))
    return results


TUTORIALS = {
    "tut_lesson_15": dict(src="tutorial/lesson_15_generators.cpp",
                           gens=[("my_first_generator", "my_first_generator"),
                                 ("my_second_generator", "my_second_generator")]),
    "tut_lesson_16": dict(src="tutorial/lesson_16_rgb_generate.cpp",
                           gens=[("brighten", "brighten")]),
    "tut_lesson_21": dict(src="tutorial/lesson_21_auto_scheduler_generate.cpp",
                           gens=[("auto_schedule_gen", "auto_schedule_gen")]),
}


def lower_tutorial(target):
    cfg = TUTORIALS[target]
    scratch = f"{SCRATCH}/{target}"
    out_dir = f"{LOWERED}/{target}"
    gen_bin = build_generator_bin(target, [cfg["src"]], scratch)
    results = []
    for gen_name, func_name in cfg["gens"]:
        results.append(lower_one(gen_bin, gen_name, func_name, out_dir))
    return results


DISPATCH = {
    "fft": lower_fft,
    "resize": lower_resize,
    "c_backend": lower_c_backend,
    "wavelet": lower_wavelet,
    "linear_blur": lower_linear_blur,
    "tut_lesson_15": lambda: lower_tutorial("tut_lesson_15"),
    "tut_lesson_16": lambda: lower_tutorial("tut_lesson_16"),
    "tut_lesson_21": lambda: lower_tutorial("tut_lesson_21"),
}

ALL = list(DISPATCH.keys())


def main():
    targets = sys.argv[1:]
    if not targets:
        raise SystemExit(__doc__)
    if targets == ["all"]:
        targets = ALL
    summary = []
    for t in targets:
        if t not in DISPATCH:
            print(f"UNKNOWN TARGET {t}")
            summary.append(dict(target=t, status="UNKNOWN"))
            continue
        print(f"\n{'='*80}\n{t}\n{'='*80}", flush=True)
        t0 = time.time()
        try:
            results = DISPATCH[t]()
            summary.append(dict(target=t, status="LOWERED", results=results,
                                 seconds=round(time.time() - t0, 1)))
            print(f"OK {t}: {results}")
        except Exception as ex:
            summary.append(dict(target=t, status="FAILED", error=str(ex),
                                 seconds=round(time.time() - t0, 1)))
            print(f"FAILED {t}: {ex}", flush=True)
    print("\n\n=== LOWER-GAP BATCH SUMMARY ===")
    for s in summary:
        print(s)


if __name__ == "__main__":
    main()
