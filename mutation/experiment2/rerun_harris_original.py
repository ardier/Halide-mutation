import os, sys
sys.path.insert(0, '/mnt/scratch1/ardi/dsl_mut/HM-arith/mutation')
from halidemut.apps import APPS, ARMS
from halidemut.pipeline import Pipeline
os.environ['IRM_HALIDE_MUTATE_STATS'] = '1'
os.environ['IRM_HALIDE_MUTATE_LOG'] = '1'
pipeline = Pipeline(
    halide_root='/mnt/scratch1/ardi/dsl_mut/HM-arith',
    halide_build='/dev/shm/ardi_dslmut/halide16-build',
    mull_output='/mnt/scratch1/ardi/dsl_mut/mull-ps/output',
    llvm_prefix='/mnt/scratch1/ardi/dsl_mut/llvm14full',
    workdir='/dev/shm/ardi_dslmut/rerun-orig-work',
)
generator, mutants = pipeline.stage1(APPS['harris'], 'arithmetic', ARMS['arithmetic'], route='ir')
print('mutation points recorded by Mull:', len(mutants))
