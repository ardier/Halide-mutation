#!/usr/bin/env python3
"""Phase 1: lower a Halide app's generator to emitted C++ only. No mutation.
Fast, reliable pass -- keep separate from the (slow, contention-prone)
mutation pass per coordinator directive 2026-08-21.

Usage: python3 lower_only.py <app> [<app> ...]
"""
import os
import subprocess
import sys
import time

REPO = "/home/ardi/project/dsl_mutants/halide/Halide-mutation"
CLANG = "/usr/lib/llvm-14/bin/clang++"
BUILD_INC = f"{REPO}/build/include"
TOOLS = f"{REPO}/tools"
SCRATCH = "/tmp/lowered-build/arm_c_scale"
LOWERED = f"{REPO}/mutation/lowered-cpp"


def run(cmd, timeout=180, **kw):
    print("+", " ".join(cmd), flush=True)
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout, **kw)
    except subprocess.TimeoutExpired as ex:
        raise RuntimeError(f"command timed out after {timeout}s: {' '.join(cmd)}") from ex
    if r.returncode != 0:
        print(r.stdout[-4000:])
        print(r.stderr[-4000:])
        raise RuntimeError(f"command failed ({r.returncode}): {' '.join(cmd)}")
    return r


def lower(app):
    t0 = time.time()
    scratch = f"{SCRATCH}/{app}"
    os.makedirs(scratch, exist_ok=True)
    lowered_dir = f"{LOWERED}/{app}"
    os.makedirs(lowered_dir, exist_ok=True)
    print(f"\n{'='*80}\n{app} (lower only)\n{'='*80}", flush=True)

    gen_src = f"{REPO}/apps/{app}/{app}_generator.cpp"
    if not os.path.exists(gen_src):
        raise RuntimeError(f"no generator source at {gen_src}")

    gen_bin = f"{scratch}/{app}.generator"
    run([CLANG, "-std=c++17", "-O1", "-g", "-I", BUILD_INC, "-I", TOOLS,
         "-c", gen_src, "-o", f"{scratch}/gen.o"])
    run([CLANG, f"{scratch}/gen.o", f"{SCRATCH}/gengen.o", "-o", gen_bin,
         "-L", f"{REPO}/build/src", "-lHalide", "-Wl,-rpath," + f"{REPO}/build/src",
         "-lpthread", "-ldl"])
    run([gen_bin, "-g", app, "-o", lowered_dir, "-f", app,
         "-e", "c_source,c_header,stmt", "target=host"])

    emitted_cpp = f"{lowered_dir}/{app}.halide_generated.cpp"
    if not os.path.exists(emitted_cpp):
        raise RuntimeError(f"lowering did not produce {emitted_cpp}")
    size = os.path.getsize(emitted_cpp)
    elapsed = time.time() - t0
    print(f"LOWERED {app}: {size} bytes ({elapsed:.1f}s)")
    return dict(app=app, bytes=size, elapsed=elapsed, status="LOWERED")


def main():
    apps = sys.argv[1:]
    if not apps:
        raise SystemExit(__doc__)
    results = []
    for app in apps:
        try:
            results.append(lower(app))
        except Exception as ex:
            print(f"FAILED {app}: {ex}", flush=True)
            results.append(dict(app=app, error=str(ex), status="FAILED"))
    print("\n\n=== LOWER-ONLY BATCH SUMMARY ===")
    for r in results:
        print(r)


if __name__ == "__main__":
    main()
