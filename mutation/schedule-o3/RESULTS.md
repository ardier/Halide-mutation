# Schedule-directive write-position classification and an O3 performance oracle

Two connected jobs on the 8 schedule-directive operators (`vectorize`/
`unroll`/`parallel` pairwise, `compute_at`/`store_at`): where their mutation
points are written, and whether a performance oracle can resolve the 110
that stay unresolved by every correctness oracle.

## Job 1: write-position classification

Raw census (union of `mutation/results-full-sweep/*.csv` and `*.pass2.csv`,
every status including `NOT_RUN`) over the 13 apps that have any schedule-arm
data: **466 raw mutants at 275 distinct mutation points**.

Classification method: brace-matched enclosing-function detection
(`classify_enclosing.py`), not a line-number heuristic. It strips comments
and string/char literals, walks braces, and at each `{` decides whether the
immediately preceding statement is a function/method signature -- in-class
(`void generate() {`) or out-of-line (`void CameraPipe::generate() {`) --
by regex-searching for `name(args)` anchored at the end of the preceding
statement, which tolerates an arbitrary prefix (return type, access
specifier, `Class::` qualifier) without needing to strip each one by hand.
For every mutation site this gives the innermost enclosing function by brace
range, which is what actually determines write-position -- a naive
"line number is past `schedule()`'s declaration" test fails on any generator
with out-of-line methods.

**Ground truth match.** camera_pipe was given as a known case: `schedule()`
at line 154, an out-of-line `CameraPipe::generate()` at 406, 9 points inside
`schedule()` (162-186) and 27 inline in the algorithm body (473-560). The
tool reproduces this exactly -- `schedule` resolves to range `[154, 206]`,
`CameraPipe::generate` to `[406, 618]`, and every one of the 36 sites lands
in the predicted bucket.

**Only camera_pipe has a formal `schedule()` method.** Direct grep for
`void schedule(` across all 13 generator sources confirms zero others define
one -- consistent with the earlier spot-check finding that only camera_pipe
and `resize` (0 schedule points) do so anywhere in the corpus.

### Results

| bucket | sites | mutants | share of mutants |
|---|---:|---:|---:|
| formal `schedule()` block (camera_pipe only) | 9 | 15 | 3.2% |
| inline, directly in `generate()`/`Class::generate()` | 254 | 431 | 92.5% |
| inline, in a non-`generate` helper called from `generate()` | 12 | 20 | 4.3% |
| **non-formal total** | **266** | **451** | **96.8%** |

The "inline-in-helper" row is two apps where a free/member function -- not
named `generate` or `schedule` -- builds part of the pipeline and schedules
it there: iir_blur's `blur_cols_transpose` (10 pts/17 muts; its own comment
at line 153 reads "Scheduling is done inside blur_cols_transpose") and bgu's
`solve_symmetric` (2 pts/3 muts). Neither is a formal scheduler-API
boundary, so both count as non-formal, but they are reported separately
because they are not lexically "inside `generate()`" either -- listing them
under `inline-in-generate` would overstate that bucket on a technicality.

Per-app detail (formal / inline-generate / inline-helper, points and
mutants):

```
app                            formal      inline-generate   inline-helper   total pts  total muts
bgu                             0/0            35/60             2/3            37         63
bilateral_grid                  0/0            20/37             0/0            20         37
blur                            0/0            13/21             0/0            13         21
c_backend                       0/0             1/2              0/0             1          2
camera_pipe                     9/15           27/46             0/0            36         61
conv_layer                      0/0             8/9              0/0             8          9
depthwise_separable_conv        0/0            47/87             0/0            47         87
harris                          0/0            31/50             0/0            31         50
hist                            0/0            29/51             0/0            29         51
iir_blur                        0/0             0/0             10/17           10         17
max_filter                      0/0             7/12             0/0             7          12
nl_means                        0/0            18/29             0/0            18         29
unsharp                         0/0            18/27             0/0            18         27
TOTAL                           9/15          254/431           12/20          275        466
```

### The unresolved-110 subset is 100% non-formal

Of the 110 mutants unresolved by every correctness oracle (from
`mutation/experiment2/resolution_table.py -v`), **zero sit in camera_pipe's
formal `schedule()` block** -- all 15 mutants there were already resolved,
14 by compiler rejection or equivalence and the rest by the argument in
`EQUIVALENCE.md`. 106/110 are inline-in-generate; the remaining 4 (all
iir_blur, lines 45/45/56/59) are inline-in-helper. So "prioritize the inline
ones" and "run all 110" are the same instruction here -- there is no
formal-block subset of the unresolved population to deprioritize.

## Job 2: O3 performance oracle

### Mechanism

Reused `mutation/halidemut/pipeline.py`'s own `Pipeline` class exactly as it
produced the corpus's existing schedule-arm CSVs (Mull IR-route
instrumentation, `mull-ir-frontend-14`, the old LLVM14/Halide16 stack): one
instrumented generator binary per app, mutants selected by env-var at
generation time. This is not a hand-edited reproduction of the mutation --
it is the same mechanism, extended to timing.

For each of the 9 apps holding an unresolved mutant: `stage1` once (build
the instrumented generator), `stage2(mutant=None)` once for baseline
artifacts, link a baseline driver, measure baseline wall time over 21 reps
-- establishing that app's own noise before looking at a single mutant.
Then per mutant: `stage2(mutant)` emits its `.a`/`.h`/`.stmt`, the driver is
relinked (reusing the compiled driver object when the header hash matches
baseline's, which it always does for a schedule mutant), and timed the same
way.

`HL_NUM_THREADS=8` throughout (>=2 as required) -- mid-range for a
128-core box, chosen so 4 apps running concurrently never approach the
100-core cap.

**Threshold, per app, from that app's own measured baseline spread:**
`threshold = max(3 x IQR_baseline, 2% x median_baseline)`. IQR (of 21
repeated baseline runs) is an outlier-robust spread estimate; for a
near-normal distribution IQR = 1.349*sigma, so 3xIQR is roughly a
4-sigma-equivalent margin -- strict enough that ordinary scheduler/cache
noise rarely crosses it, loose enough to catch a real effect. The 2%-floor
guards against a freak near-zero IQR producing a hair-trigger threshold.
Verdict: `KILLED_O3` if `|median_mutant - median_baseline| > threshold`.

**Adaptive reps + per-run timeout**, added after the first pilot showed why
they're necessary (below): minimum 4 reps, maximum 9; after each rep from
the 4th on, if the running median already exceeds 3x the threshold, stop
early (`n=4*` in the log/data) -- an obvious kill does not need the same
sample size as a borderline case. Each single rep is capped at
`min(90s, max(8 x baseline_median, 5s))`; a rep that blows through this is
killed and counted at the cap (`any_timeout=1`, marked `T`) -- a mutant that
cannot finish within 8x baseline is a kill by construction, and there is no
reason to wait out its true magnitude to know that.

Secondary signals recorded per mutant: peak RSS (`os.wait4` rusage,
`ru_maxrss`), `.stmt` line count vs baseline, vector-instruction count in
the **linked driver's disassembly** (`%xmm`/`%ymm`/`%zmm` operand count via
`objdump -d` -- this is the actual compiled machine code, not the emitted
Halide IR), and `.text` section byte size (`size`).

### Load discipline

`uptime` before the first launch: load average 12.68/12.89/13.06 on a
128-core box (~10%) -- quiet. Split into 4 concurrent worker processes
(<=32 threads total while all 4 ran), well under the 100-core cap; load
peaked around 38 (30%) during the busiest stretch and settled back down as
workers finished. Never approached the cap.

### Why the reps/timeout scheme changed mid-run (reported, not hidden)

The first pass (fixed 9 reps, no per-run cap) worked, but a handful of
`*_to_parallel` mutants turned out to be **50-100x slower than baseline**
(spawning a parallel task per iteration of what should have stayed a tight
unrolled loop over a tiny per-tile extent) -- one `depthwise_separable_conv`
mutant took several minutes for a single rep. At fixed-9-reps with no cap,
finishing the full 110-mutant set would have taken hours. The adaptive
scheme (above) was substituted for the mutants not yet measured; the first
48 results (collected before the change) are the fixed-9-rep numbers and
were kept rather than discarded -- their `mutant_n` column shows exactly
what ran for each. This is a real change to the protocol, reported here
rather than smoothed over; the verdicts it produces are the same kind of
verdict (median-vs-threshold), only cheaper to obtain for the extreme cases.

A one-line bug (`r['col']` vs the CSV's actual `column` header) crashed two
runs after their first successful mutant each; both were re-run for their
skipped mutants once fixed. `git check-attr text --
mutation/schedule-o3/o3-results.csv` reports `text: unset` in this repo
before anything was committed, so the CSV-corruption failure mode described
in the environment brief cannot recur here -- and independently, the
streaming results lived at `/mnt/scratch1/ardi/dsl_mut/sched-o3/` (outside
any git working tree) for the entire sweep; they were copied into the repo
only after every worker had exited, so no git operation ever ran while a
process was appending to these particular files.

**Verified against the run logs, not just trusted:** every worker's CSV row
count matches its log's `KILLED_O3`/`SURVIVED_O3` line count exactly (e.g.
`A: log_verdicts=24 csv_rows=24` ... `D3: log_verdicts=13 csv_rows=13`);
the two crash-truncated runs (`C2`/`D2`, 0 log verdicts but 1 CSV row each)
are explained by exactly where the bug fired (after the row was written,
before the verdict was printed), not a mystery. 48 (pre-bug) + 2 (mid-crash)
+ 60 (re-run) = 110, matching the target list exactly, no duplicates,
verified by merging on `(app, mutator, file, line, column)`.

### Results

**50 of 110 (45.5%) killed by the O3 performance oracle.**

| app | n | killed | survived | baseline median (range) | threshold (% of median) |
|---|---:|---:|---:|---:|---:|
| bilateral_grid | 15 | 10 | 5 | 2.12-2.15s | 2.0-3.5% |
| conv_layer | 4 | 1 | 3 | 6.91-6.94s | 57.0-98.7% |
| depthwise_separable_conv | 34 | 16 | 18 | 0.38-0.60s | 89.5-100.0% |
| harris | 6 | 2 | 4 | 0.75s | 80.0% |
| hist | 16 | 2 | 14 | 1.73s | 35.2% |
| iir_blur | 4 | 3 | 1 | 6.81s | 3.3% |
| max_filter | 8 | 5 | 3 | 1.20-1.25s | 12.5-55.7% |
| nl_means | 16 | 10 | 6 | 3.01s | 5.2-9.9% |
| unsharp | 7 | 1 | 6 | 2.10s | 32.1% |
| **total** | **110** | **50** | **60** | | |

**Read the threshold column before the kill count.** `bilateral_grid` and
`iir_blur` have a tight, high-confidence threshold (2-3.5% of median) --
their kill/survive calls are trustworthy at face value. `conv_layer` and
`depthwise_separable_conv` have a threshold at 90-100% of their own median
-- their baseline is that noisy (conv_layer's `process.cpp` shows 19-33%
IQR run to run), so a "SURVIVED_O3" verdict there is a much weaker claim: it
means "did not double in wall time," not "no real difference." This is
reported per-app rather than pooled into one number specifically so it
cannot be misread as uniform confidence.

**By what margin, and by what mechanism.** Every one of the 50 kills is a
`*_to_parallel` mutant (in either direction) except two: `conv_layer`
`parallel_to_vectorize@179` (+354%) and `bilateral_grid`
`vectorize_to_unroll@141`/`147`/`unroll_to_vectorize@132` (which cluster at
the low end, near their tight 2-3.5% threshold). The mechanism is
consistent and physically sensible throughout: converting a fine-grained
`unroll` (or `vectorize`) into `parallel` spawns a thread task per iteration
of what was a handful of unrolled/vectorized lanes -- overhead the tiny
per-tile extents in these pipelines cannot amortize. Margins range from
+4.4% (iir_blur, right at its tight threshold) to +785% (bilateral_grid
`unroll_to_parallel@141`), with a cluster of `+700%`/`+731.5%` values that
are the **timeout cap itself** (8x baseline), not a measured true magnitude
-- those mutants are killed correctly, but "+700%" is a floor on how bad
they actually are, not the number.

**iir_blur -- the mutant that motivated this whole side of the corpus is
now resolved.** The plan's "structural equivalence argument doesn't
generalize" finding rests on `iir_blur`: at the same site,
`vectorize_to_parallel` was already killed by the correctness oracle (O2)
while `vectorize_to_unroll` survived every correctness oracle, with no
Halide-level reassociation to explain the split. This sweep's target list
is the 4 mutants that stayed unresolved after that finding --
`vectorize_to_parallel@45` and `vectorize_to_unroll@45,56,59`. Results:
`vectorize_to_parallel@45` is **killed by O3 at +675%** (median goes from
6.81s to 52.8s) -- a mutation invisible to every correctness oracle turns
out to cause a nearly 8x slowdown. `vectorize_to_unroll@56` and `@59` are
each **killed by O3 at +4.4%**, right at iir_blur's own tight 3.3%
threshold -- small but real, and consistent between the two sites (same
mutator, same margin, both above threshold). `vectorize_to_unroll@45` is
the one iir_blur mutant that survives O3 too (-1.5%, inside the noise
band) -- so of the four, three are now resolved (killed) and one remains
genuinely unresolved.

**Secondary signals on the 60 O3-survivors.** All 60 already have an
"effective" (non-byte-identical) `.stmt` by definition of being in the
unresolved-not-equivalent set, so a `.stmt` diff alone is not news. What is
worth reporting: the **linked driver binary's** vector-instruction count
(`%xmm`/`%ymm`/`%zmm` in `objdump -d`) and `.text` size differ for the
overwhelming majority of survivors too (e.g. `depthwise_separable_conv`
`unroll_to_vectorize@276`: `.stmt` 672->1272 lines, vector-op count
6054->15226, `.text` +47.9%) -- confirming the code-shape change survives
all the way through instruction selection and linking, not just the IR.
This is **not** claimed as equivalence resolution -- no argument is offered
for why these 60 cannot be distinguished by *some* signal, only that this
particular oracle (median wall time, this threshold) does not distinguish
them. They stay unresolved.

### Recommendation

**Report the family in full, split by write-position, and report the O3
sub-result as a genuine, partial resolution -- not as grounds to keep
excluding it.**

- The blanket exclusion was reasoned from "Halide guarantees schedules
  preserve values, so a correctness oracle is structurally blind here."
  That reasoning is now demonstrably incomplete on its own terms: 45.5% of
  the mutants the correctness oracles could not touch are killed by a
  cheap, honestly-thresholded wall-time comparison. A family that a
  different, equally legitimate oracle resolves nearly half of is not a
  family with nothing to report.
- The write-position finding is itself worth keeping regardless of the O3
  result: 96.8% of all schedule mutation points in this corpus -- and 100%
  of the ones that stayed unresolved -- are written inline in the
  algorithm body, not behind a dedicated `schedule()` boundary. If the
  paper's framing of "schedule directives as compiler pragmas, closer to
  hints than domain semantics" is meant to justify exclusion, that framing
  describes a `schedule()`-block world this corpus barely has (9 of 466
  raw points, one app). What actually exists is inline scheduling calls
  interleaved with the algorithm -- ordinary source lines a developer
  edits and reviews like any other -- and this study now has both a
  performance oracle result and a positive equivalence argument
  (`EQUIVALENCE.md` 6-7, the integer-pipeline case) for that population,
  not just a shrug.
- What should **not** be claimed: that the 60 O3-survivors are equivalent.
  No argument was constructed for them, per the project's own standard
  (`EQUIVALENCE.md`'s explicit stance that a survived-so-far mutant is not
  yet an equivalent one). They stay unresolved, honestly. The remaining
  open question for that residual 60 -- worth a sentence, not a rerun --
  is whether a tighter noise floor (more reps, or a benchmark-style
  amortized-loop driver instead of one process per measurement,
  particularly for `conv_layer` and `depthwise_separable_conv` where the
  threshold is 90-100% of median) would move some of them into the killed
  column; this run's numbers do not distinguish "genuinely equivalent"
  from "our noise floor is too coarse to see it" for that specific subset.

## Files

- `mutation/schedule-o3/o3-results.csv` -- all 110 unresolved mutants, full
  detail (baseline/mutant timing, RSS, `.stmt` lines, vector-insn counts,
  `.text` bytes, verdict).
- `mutation/schedule-o3/targets-unresolved-110.csv` -- the input target
  list (app, mutator, file, line, column) derived from
  `resolution_table.py -v`.
- `mutation/schedule-o3/logs/*.log` -- full run logs for every worker
  (`A`-`D` fixed-9-rep pass, `A2`-`D2` the crash-truncated attempt,
  `A3`-`D3` the adaptive/timeout re-run) -- the source of the
  log-vs-CSV verification above.
- `mutation/schedule-o3/scripts/` -- the two driver scripts
  (`sched-o3-sweep.py`, `sched-o3-sweep2.py`).
- `mutation/schedule-o3/classify_enclosing.py`,
  `classify_schedule_sites.py` -- Job 1's brace-matching classifier and
  driver.
- `mutation/schedule-o3/schedule_raw_census.json`,
  `schedule_site_classification.json`,
  `schedule_mutant_classification.json` -- Job 1's raw census and
  classified output, per-site and per-mutant.
