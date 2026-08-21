"""Stage-1-only census: instrument every app x arm and count mutation points.

Cheap (one clang compile + link per cell) and tells us the size of the full run
before committing compute to it.
"""
import collections
import json
import sys
import traceback
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

ROOT = Path("/home/ardi/project/dsl_mutants/halide")
sys.path.insert(0, str(ROOT / "Halide-mutation" / "mutation"))

from halidemut.apps import APPS, ARMS, ARM_ROUTE
from halidemut.pipeline import Pipeline, PipelineError

WORK = Path("/home/ardi/project/dsl_mutants/halide/sweep-work/census")
pipeline = Pipeline(
    halide_root=ROOT / "Halide-mutation",
    halide_build=ROOT / "Halide-mutation" / "build",
    mull_output=ROOT / "mull-ps" / "output",
    llvm_prefix=Path("/usr/lib/llvm-14"),
    workdir=WORK,
)

cells = [(a, arm) for a in APPS for arm in ARMS]


def one(cell):
    app_name, arm = cell
    app = APPS[app_name]
    try:
        _, mutants = pipeline.stage1(app, arm, ARMS[arm], route=ARM_ROUTE[arm])
        per_op = collections.Counter(m.mutator for m in mutants)
        return app_name, arm, len(mutants), dict(per_op), None
    except PipelineError as exc:
        return app_name, arm, -1, {}, str(exc)[:600]
    except Exception:
        return app_name, arm, -1, {}, traceback.format_exc()[-600:]


out = {}
with ThreadPoolExecutor(max_workers=6) as pool:
    futs = {pool.submit(one, c): c for c in cells}
    done = 0
    for f in as_completed(futs):
        app_name, arm, n, per_op, err = f.result()
        out.setdefault(app_name, {})[arm] = {"n": n, "per_op": per_op, "error": err}
        done += 1
        flag = "ERR" if err else ""
        print(f"[{done}/{len(cells)}] {app_name:<26}{arm:<22}{n:>5}  {flag}", flush=True)
        if err:
            print("      " + err.replace("\n", "\n      ")[:800], flush=True)

Path(WORK / "census.json").write_text(json.dumps(out, indent=1))
print("\nwrote", WORK / "census.json")
