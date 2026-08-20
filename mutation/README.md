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
survivors would understate every kill rate, so O1/O2 percentages are computed
over `eff` only.

## Oracles

- **O1** — the driver's exit status: crash, `abort()`, nonzero exit, or timeout.
- **O2** — byte comparison of the driver's output artifact against a golden
  snapshot taken once from the unmutated build. For apps that write no output
  file (`blur`), it falls back to the driver's stdout with timing lines
  stripped.

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

O3 (performance oracle), the full stage-2 preservation-class taxonomy beyond
`equiv`, and the ground-truth verification sampler.
