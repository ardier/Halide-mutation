# halidemut

Mutation-testing pipeline for the Halide benchmark apps.

```sh
cd mutation
python3 -m halidemut \
    --mull-output /path/to/mull-ps/output \
    --workdir /tmp/halidemut \
    --apps blur,bilateral_grid,harris,unsharp,camera_pipe \
    --arms arithmetic,schedule \
    --csv results.csv --summary summary.txt
```

Requires a built Halide tree (`../build`) and a built `mull-ps` `output/`
directory. See `mull-ps/docs/linux-build.md`.

## Stages

| Stage | What it does |
|---|---|
| 1 | Instrument the app's generator TU with `mull-ir-frontend`, link a generator binary, read back the mutant list |
| 2 | Per mutant, re-run the generator with that mutant's env var set, emitting `static_library`, `h` and `stmt` |
| 3 | Link the app's own driver against the mutant's static library, run it, score it |

## Outcome classes

| Class | Meaning |
|---|---|
| `genKill` | the Halide compiler rejected the mutant (`GEN_ERROR`/`GEN_TIMEOUT`) — a kill category only staged compilation produces |
| `bldErr` | the mutant object failed to link into the driver |
| `equiv` | generated fine, but the emitted `.stmt` is byte-identical to baseline |
| `eff` | effective mutants: reached the driver *and* changed the emitted code |

`equiv` is not a survival. Every generator branches its schedule on the target
(`has_gpu_feature()` / `has_feature(HVX)` / else), so a mutation inside a branch
the chosen target does not take cannot affect anything. Counting those as
survivors would understate every kill rate, so the per-kind percentages are
computed over `eff` only. Such a mutant is *proven equivalent*, which counts
as RESOLVED -- a positive result, not a shortfall.

## Test kinds

All three are tests. A mutant is **resolved** if any kind kills it, or if it is
proven equivalent. Each kind is scored independently and the *set* of kinds that
killed a mutant is recorded (`killed_by`), not just the first to fire: "killed
by X" and "X alone sufficed" are different questions.

- **test 1 — demo program** (`test1_demo`) — the shipped driver's own verdict:
  crash, `abort()`, nonzero exit, or timeout. Zero effort; it ships with the
  app.
- **test 2 — additional tests** — oracles we added, in two sub-tiers that are
  never pooled, because the difference between them *is* the test-writing
  effort being measured:
  - `test2_golden` — snapshot the baseline output once, then byte-diff. Near
    free.
  - `test2_written` — hand-authored assertion drivers, swapped in with
    `dataclasses.replace(app, driver_source=...)` so no shipped file is
    touched. Real work.
- **test 3 — performance** (`test3_perf`) — median wall time against a
  threshold taken from that app's own baseline timing noise.

`test2_golden` needs an output artifact. Where a driver writes none it falls
back to normalised stdout, which carries no pipeline output and therefore only
restates test 1. `blur`, `conv_layer` and `depthwise_separable_conv` are given
an artifact-dumping driver variant so their golden column is a real, independent
measurement.

## Deviation from the apps' own `make test`

Most drivers link two copies of the pipeline — the manually scheduled one and a
Mullapudi2016-autoscheduled one — benchmark both, then save the output of the
**autoscheduled** run. That is unusable as a mutation oracle: every generator
guards its manual schedule with `if (!using_autoscheduler())`, so a
schedule-directive mutant changes only the manual variant while the saved image
comes from the auto variant. Every such mutant would score as surviving no
matter what it did.

So the second variant is generated from the same source *without* passing
`autoscheduler=`: it is the manual schedule under a second symbol name. The
app's own driver then links and runs unmodified, and the artifact it saves
reflects the mutation. This also takes the autoscheduler out of the inner loop,
which is what made `camera_pipe` slow and memory-hungry in earlier work.

## Not yet implemented

`test3_perf` (the performance kind: columns exist and are written `NOT_RUN`),
the full stage-2 preservation-class taxonomy beyond `equiv`, and the
ground-truth verification sampler.
