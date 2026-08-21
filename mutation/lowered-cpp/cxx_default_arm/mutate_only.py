#!/usr/bin/env python3
"""Phase 2: mutate an already-lowered app with cxx_default, link against its
driver, sweep mutants. Assumes mutation/lowered-cpp/<app>/<app>.halide_generated.cpp
already exists (produced by lower_only.py). 10-minute wall-clock budget
applies to this script alone (compile+link+baseline+sweep), not lowering.

Usage: python3 mutate_only.py <app>
"""
import csv
import os
import random
import re
import subprocess
import sys
import time

REPO = "/home/ardi/project/dsl_mutants/halide/Halide-mutation"
CLANG = "/usr/lib/llvm-14/bin/clang++"
MULL_IR = "/home/ardi/project/dsl_mutants/halide/mull-ps/output/mull-ir-frontend-14"
BUILD_INC = f"{REPO}/build/include"
TOOLS = f"{REPO}/tools"
SCRATCH = "/tmp/lowered-build/arm_c_scale"
RESULTS = f"{REPO}/mutation/results"
LOWERED = f"{REPO}/mutation/lowered-cpp"
IMG_CFLAGS = ["-I/usr/include/libpng16"]
IMG_LIBS = ["-lpng16", "-ljpeg"]
DEADLINE_SECONDS = 600  # ~10 min, scoped to the mutation step only (coordinator, 2026-08-21)

sys.path.insert(0, f"{LOWERED}")
from cxx_default_arm.bucket_mutants import region_bounds, classify  # noqa: E402

APPS = {
    "bilateral_grid": dict(driver="apps/bilateral_grid/filter.cpp",
                            args=["{input}", "{output}", "0.1", "10"],
                            input_image="apps/images/gray.png", o2=True),
    "camera_pipe": dict(driver="apps/camera_pipe/process.cpp",
                         args=["{input}", "3700", "2.0", "50", "1.0", "1", "{output}", "{scratch}/h_auto.png"],
                         input_image="apps/images/bayer_raw.png", o2=True),
    "unsharp": dict(driver="apps/unsharp/filter.cpp", args=["{input}", "{output}"],
                     input_image="apps/images/rgba.png", o2=True),
    "bgu": dict(driver="apps/bgu/filter.cpp", args=["{input}", "{output}"],
                input_image="apps/images/rgb.png", o2=True, ram_heavy=True),
    "conv_layer": dict(driver="apps/conv_layer/process.cpp", args=[], input_image=None, o2=False),
    "depthwise_separable_conv": dict(driver="apps/depthwise_separable_conv/process.cpp",
                                      args=[], input_image=None, o2=False),
    "hist": dict(driver="apps/hist/filter.cpp", args=["{input}", "{output}"],
                  input_image="apps/images/rgba.png", o2=True),
    "iir_blur": dict(driver="apps/iir_blur/filter.cpp", args=["{input}", "{output}"],
                      input_image="apps/images/rgba.png", o2=True),
    "lens_blur": dict(driver="apps/lens_blur/process.cpp",
                       args=["{input}", "32", "13", "0.5", "32", "3", "{output}"],
                       input_image="apps/images/rgb_small.png", o2=True, ram_heavy=True),
    "max_filter": dict(driver="apps/max_filter/filter.cpp", args=["{input}", "{output}"],
                        input_image="apps/images/rgba.png", o2=True),
    "nl_means": dict(driver="apps/nl_means/process.cpp",
                      args=["{input}", "7", "7", "0.12", "10", "{output}"],
                      input_image="apps/images/rgb.png", o2=True),
}


def run(cmd, timeout=240, **kw):
    print("+", " ".join(cmd), flush=True)
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout, **kw)
    except subprocess.TimeoutExpired as ex:
        raise RuntimeError(f"command timed out after {timeout}s (likely machine contention): "
                            f"{' '.join(cmd)}") from ex
    if r.returncode != 0:
        print(r.stdout[-4000:])
        print(r.stderr[-4000:])
        raise RuntimeError(f"command failed ({r.returncode}): {' '.join(cmd)}")
    return r


def mutate(app):
    cfg = APPS[app]
    scratch = f"{SCRATCH}/{app}"
    os.makedirs(scratch, exist_ok=True)
    lowered_dir = f"{LOWERED}/{app}"
    emitted_cpp = f"{lowered_dir}/{app}.halide_generated.cpp"
    if not os.path.exists(emitted_cpp):
        raise RuntimeError(f"not lowered yet: {emitted_cpp} missing -- run lower_only.py first")

    t_start = time.time()
    print(f"\n{'='*80}\n{app} (mutate only)\n{'='*80}", flush=True)

    # generator binary needed again only for the throwaway auto_schedule.a
    gen_bin = f"{scratch}/{app}.generator"
    if not os.path.exists(gen_bin):
        gen_src = f"{REPO}/apps/{app}/{app}_generator.cpp"
        run([CLANG, "-std=c++17", "-O1", "-g", "-I", BUILD_INC, "-I", TOOLS,
             "-c", gen_src, "-o", f"{scratch}/gen.o"])
        run([CLANG, f"{scratch}/gen.o", f"{SCRATCH}/gengen.o", "-o", gen_bin,
             "-L", f"{REPO}/build/src", "-lHalide", "-Wl,-rpath," + f"{REPO}/build/src",
             "-lpthread", "-ldl"])

    # --- compile with cxx_default via mull-ir-frontend ---
    yml = f"{scratch}/mull.yml"
    with open(yml, "w") as f:
        f.write("mutators:\n  - cxx_default\ntimeout: 99999999\nquiet: false\nincludePaths:\n  - .*\n")
    env = dict(os.environ, MULL_CONFIG=yml)
    mut_o = f"{scratch}/{app}_cxx.o"
    # The cxx_default compile (Mull's junk-detector re-parse dominates) scales
    # with file size -- bigger emitted files (bilateral_grid, camera_pipe, bgu,
    # lens_blur) genuinely need more than a flat 240s, confirmed by a manual
    # diagnostic run (bilateral_grid: ~390s, exit 0, not stuck). Give it
    # whatever remains of this app's own 10-minute budget rather than an
    # arbitrary flat cap, so it fails only when the app's real budget is spent.
    remaining = max(60, DEADLINE_SECONDS - (time.time() - t_start))
    run([CLANG, "-std=c++17", "-O1", "-g", "-grecord-command-line",
         f"-fpass-plugin={MULL_IR}", "-c", emitted_cpp, "-o", mut_o],
        env=env, timeout=remaining)

    strings_out = subprocess.run(["strings", mut_o], capture_output=True, text=True).stdout
    pattern = re.compile(rf"^cxx_[a-z_]+:{re.escape(emitted_cpp)}:\d+:\d+$", re.M)
    mutants = sorted(set(pattern.findall(strings_out)))
    print(f"mutants: {len(mutants)}")
    if not mutants:
        raise RuntimeError("zero mutants found -- compile likely produced no usable mutation points")

    # --- native support artifacts ---
    runtime_a = f"{SCRATCH}/runtime.a"
    auto_a = f"{scratch}/{app}_auto_schedule.a"
    run([gen_bin, "-g", app, "-f", f"{app}_auto_schedule", "-o", scratch,
         "target=host-no_runtime"])

    # --- link driver ---
    driver_src = f"{REPO}/{cfg['driver']}"
    binary = f"{scratch}/instrumented"
    link_cmd = [CLANG, "-std=c++17", "-O2", "-Wall"] + IMG_CFLAGS + \
        ["-I", lowered_dir, "-I", scratch, "-I", BUILD_INC, "-I", TOOLS,
         driver_src, mut_o, auto_a, runtime_a, "-o", binary] + IMG_LIBS + ["-lpthread", "-ldl"]
    run(link_cmd)

    # --- baseline sanity run ---
    baseline_png = f"{scratch}/baseline.png"
    input_img = f"{REPO}/{cfg['input_image']}" if cfg["input_image"] else None

    def fmt_args(output_path):
        return [a.format(input=input_img, output=output_path, scratch=scratch) for a in cfg["args"]]

    baseline_args = fmt_args(baseline_png)
    r = subprocess.run([binary] + baseline_args, capture_output=True, text=True, timeout=120)
    if r.returncode != 0:
        print(r.stdout[-2000:])
        print(r.stderr[-2000:])
        raise RuntimeError(f"baseline run failed, exit={r.returncode}")
    print(f"baseline OK ({time.time()-t_start:.1f}s elapsed so far)")

    boiler_end, genspec_end = region_bounds(lowered_dir)

    sweep_order = list(mutants)
    random.Random(0).shuffle(sweep_order)

    out_csv = f"{RESULTS}/{app}-cxx_default.csv"
    mut_png = f"{scratch}/mut.png"
    fields = ["app", "arm", "mutator", "file", "line", "column", "region",
              "exit_code", "o1_killed", "o2_killed", "wall_seconds"]
    n = o1k = o2k = 0
    timed_out = False
    with open(out_csv, "w", newline="") as fcsv:
        w = csv.writer(fcsv, lineterminator="\n")
        w.writerow(fields)
        for key in sweep_order:
            if time.time() - t_start > DEADLINE_SECONDS:
                timed_out = True
                print(f"  TIMEBOX HIT at {n}/{len(mutants)} mutants "
                      f"({time.time()-t_start:.0f}s elapsed) -- stopping sweep early", flush=True)
                break
            n += 1
            parts = key.split(":")
            mutator, line, col = parts[0], parts[-2], parts[-1]
            region = classify(int(line), boiler_end, genspec_end)
            e = dict(os.environ)
            e[key] = "1"
            if cfg["o2"]:
                if os.path.exists(mut_png):
                    os.remove(mut_png)
                argv_ = fmt_args(mut_png)
            else:
                argv_ = fmt_args(None)
            t0 = time.time()
            try:
                r = subprocess.run([binary] + argv_, capture_output=True, text=True,
                                    timeout=60, env=e)
                rc = r.returncode
            except subprocess.TimeoutExpired:
                rc = -9
            wall = time.time() - t0
            o1 = 1 if rc != 0 else 0
            if cfg["o2"]:
                if o1:
                    o2 = 1
                else:
                    o2 = 0 if (os.path.exists(mut_png) and
                               open(mut_png, "rb").read() == open(baseline_png, "rb").read()) else 1
            else:
                o2 = ""
            if o1:
                o1k += 1
            if cfg["o2"] and o2 == 1:
                o2k += 1
            w.writerow([app, "cxx_default_on_emitted_cpp", mutator,
                        os.path.basename(emitted_cpp), line, col, region, rc, o1, o2, f"{wall:.3f}"])
            if n % 100 == 0:
                print(f"  progress {n}/{len(mutants)} o1={o1k} o2={o2k}", flush=True)

    elapsed = time.time() - t_start
    status = "PARTIAL(timeboxed)" if timed_out else "COMPLETE"
    print(f"DONE {app} [{status}]: swept={n}/{len(mutants)} o1={o1k} "
          f"o2={o2k if cfg['o2'] else 'n/a'} ({elapsed:.1f}s total)")
    return dict(app=app, total_mutants=len(mutants), swept=n, o1=o1k,
                o2=(o2k if cfg["o2"] else None), elapsed=elapsed, status=status)


def main():
    apps = sys.argv[1:]
    if not apps:
        raise SystemExit(__doc__)
    results = []
    for app in apps:
        try:
            results.append(mutate(app))
        except Exception as ex:
            print(f"FAILED {app}: {ex}", flush=True)
            results.append(dict(app=app, error=str(ex), status="FAILED"))
    print("\n\n=== MUTATE-ONLY BATCH SUMMARY ===")
    for r in results:
        print(r)


if __name__ == "__main__":
    main()
