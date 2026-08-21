#!/usr/bin/env python3
"""Run halidemut stage 1 (instrument + link) for a set of apps/arms with the
HalideReplacement mutate()-bailout diagnostics enabled, and save each
benchmark's compile stderr (which carries the diagnostic log lines) plus the
mutant list Mull recorded.

mutate() runs once per mutation point during this single instrumentation
compile -- Mull bakes every mutant clone into the one generator binary here;
the env-var dispatch used later (stage 2/3) only selects among clones that
already exist -- so this single compile is sufficient to observe every
bail-out for every mutation point of a given app/arm.
"""
import dataclasses
import json
import os
import sys

sys.path.insert(0, "/mnt/scratch1/ardi/dsl_mut/HM-arith/mutation")
from halidemut.apps import APPS, ARMS
from halidemut import pipeline as pipeline_mod
from halidemut.pipeline import Pipeline

OUT = "/mnt/scratch1/ardi/dsl_mut/HM-arith/mutation/experiment2/diag"
os.makedirs(OUT, exist_ok=True)

TARGETS = sys.argv[1].split(",") if len(sys.argv) > 1 else \
    ["blur", "bilateral_grid", "harris", "camera_pipe", "unsharp"]
IR_ARMS = sys.argv[2].split(",") if len(sys.argv) > 2 else \
    ["arithmetic", "schedule", "generated"]

os.environ["IRM_HALIDE_MUTATE_STATS"] = "1"
os.environ["IRM_HALIDE_MUTATE_LOG"] = "1"

# Capture every subprocess this pipeline runs; we only care about the
# instrumentation compile (argv contains "-fpass-plugin=...mull-ir-frontend"),
# but it's simplest to just save stderr from every call under a running index.
_orig_run = Pipeline._run
_call_log = []


def _patched_run(self, cmd, timeout, cwd=None, env=None, capture=True):
    proc = _orig_run(self, cmd, timeout=timeout, cwd=cwd, env=env, capture=capture)
    _call_log.append((cmd, proc))
    return proc


Pipeline._run = _patched_run

pipeline = Pipeline(
    halide_root="/mnt/scratch1/ardi/dsl_mut/HM-arith",
    halide_build="/dev/shm/ardi_dslmut/halide16-build",
    mull_output="/mnt/scratch1/ardi/dsl_mut/mull-ps/output",
    llvm_prefix="/mnt/scratch1/ardi/dsl_mut/llvm14full",
    workdir="/dev/shm/ardi_dslmut/diag-work",
)

summary = {}
for app_name in TARGETS:
    app = APPS[app_name]
    for arm in IR_ARMS:
        mutators = ARMS[arm]
        key = f"{app_name}__{arm}"
        print(f"=== {key} ===", flush=True)
        _call_log.clear()
        try:
            generator, mutants = pipeline.stage1(app, arm, mutators, route="ir")
        except Exception as exc:
            print(f"  FAILED: {exc}", flush=True)
            summary[key] = {"error": str(exc)[:4000]}
            continue

        # The instrumentation compile is the first call whose argv mentions
        # the IR-route pass plugin.
        compile_stderr = ""
        for cmd, proc in _call_log:
            if any("mull-ir-frontend" in str(c) for c in cmd):
                compile_stderr = proc.stderr.decode(errors="replace")
                break

        with open(os.path.join(OUT, f"{key}.stderr.log"), "w") as fh:
            fh.write(compile_stderr)

        mutant_rows = [dataclasses.asdict(m) for m in mutants]
        with open(os.path.join(OUT, f"{key}.mutants.json"), "w") as fh:
            json.dump(mutant_rows, fh, indent=2)

        print(f"  mutation points recorded by Mull: {len(mutants)}", flush=True)
        summary[key] = {"n_mutants": len(mutants)}

with open(os.path.join(OUT, "summary.json"), "w") as fh:
    json.dump(summary, fh, indent=2, default=str)
print("DONE")
