#!/usr/bin/env python3
"""Validation run: same as run_stage1_diag.py but pointed at the
canMutate()-mirrors-mutate() experimental build, arithmetic arm only, to
confirm the mutation-point count Mull embeds shrinks by exactly the
mutate()-observed skip count, with zero previously-applied points lost."""
import json
import os
import sys

sys.path.insert(0, '/mnt/scratch1/ardi/dsl_mut/HM-arith/mutation')
from halidemut.apps import APPS, ARMS
from halidemut.pipeline import Pipeline

OUT = '/mnt/scratch1/ardi/dsl_mut/HM-arith/mutation/experiment2/canmutate-experiment'
TARGETS = sys.argv[1].split(',') if len(sys.argv) > 1 else \
    ['bilateral_grid', 'harris', 'camera_pipe', 'unsharp']

os.environ['IRM_HALIDE_MUTATE_STATS'] = '1'
os.environ['IRM_HALIDE_MUTATE_LOG'] = '1'

pipeline = Pipeline(
    halide_root='/mnt/scratch1/ardi/dsl_mut/HM-arith',
    halide_build='/dev/shm/ardi_dslmut/halide16-build',
    mull_output=OUT,
    llvm_prefix='/mnt/scratch1/ardi/dsl_mut/llvm14full',
    workdir='/dev/shm/ardi_dslmut/canmutate-work',
)

import subprocess
_orig_run = Pipeline._run
_call_log = []
def _patched_run(self, cmd, timeout, cwd=None, env=None, capture=True):
    proc = _orig_run(self, cmd, timeout=timeout, cwd=cwd, env=env, capture=capture)
    _call_log.append((cmd, proc))
    return proc
Pipeline._run = _patched_run

summary = {}
for app_name in TARGETS:
    app = APPS[app_name]
    arm = 'arithmetic'
    mutators = ARMS[arm]
    key = f'{app_name}__{arm}'
    print(f'=== {key} ===', flush=True)
    _call_log.clear()
    try:
        generator, mutants = pipeline.stage1(app, arm, mutators, route='ir')
    except Exception as exc:
        print(f'  FAILED: {exc}', flush=True)
        summary[key] = {'error': str(exc)[:4000]}
        continue
    compile_stderr = ''
    for cmd, proc in _call_log:
        if any('mull-ir-frontend' in str(c) for c in cmd):
            compile_stderr = proc.stderr.decode(errors='replace')
            break
    with open(os.path.join(OUT, f'{key}.stderr.log'), 'w') as fh:
        fh.write(compile_stderr)
    print(f'  mutation points recorded by Mull: {len(mutants)}', flush=True)
    summary[key] = {'n_mutants': len(mutants)}

with open(os.path.join(OUT, 'summary.json'), 'w') as fh:
    json.dump(summary, fh, indent=2)
print('DONE')
