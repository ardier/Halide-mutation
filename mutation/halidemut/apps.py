"""Per-benchmark configuration for the mutation pipeline.

Each entry describes how to build one Halide app's generator, what to generate
from it, and how to drive the resulting pipeline so a mutant's effect is
observable.

A note on the ``_auto_schedule`` variants. Most apps' drivers link two copies of
the pipeline -- the manually scheduled one and a Mullapudi2016-autoscheduled one
-- benchmark both, and then save the output of the *autoscheduled* run. That is
unusable as a mutation oracle: every generator guards its manual schedule with
``if (!using_autoscheduler())``, so a schedule-directive mutant changes only the
manual variant while the saved image comes from the auto variant, and every such
mutant would be scored as surviving no matter what it did.

So the second variant is generated from the same source *without* passing
``autoscheduler=``. It is then simply the manual schedule under a second symbol
name, the app's own driver links and runs unmodified, and the artifact it saves
reflects the mutation. This also removes the autoscheduler from the inner loop,
which matters: it dominates generation time.
"""

from dataclasses import dataclass, field
from typing import List, Optional


@dataclass(frozen=True)
class AppConfig:
    name: str
    generator_source: str
    """Path to the generator TU, relative to the Halide source root."""

    generator_name: str
    """Argument to the generator binary's -g flag."""

    driver_source: str
    """The app's own test/demo driver, relative to the Halide source root."""

    function_name: str
    """Argument to -f; also the emitted header/function name."""

    driver_args: List[str] = field(default_factory=list)
    """Driver argv. ``{input}`` and ``{output}`` are substituted at run time."""

    needs_auto_variant: bool = True
    """Whether the driver links a second ``<function_name>_auto_schedule`` copy."""

    needs_runtime: bool = True
    """Whether a separate runtime.a must be generated and linked."""

    input_image: Optional[str] = None
    """Input file relative to the Halide source root."""

    output_artifact: Optional[str] = None
    """Filename the driver writes; compared byte-wise by the O2 oracle. When
    None the O2 oracle falls back to the driver's normalised stdout."""

    extra_driver_outputs: List[str] = field(default_factory=list)
    """Additional files the driver writes that are not the oracle artifact."""

    needs_image_io: bool = True
    """Link libpng/libjpeg for halide_image_io.h."""

    run_timeout: int = 300
    generate_timeout: int = 600

    memory_heavy: bool = False
    """Run this app's mutants serially rather than in the shared pool."""

    extra_gen_jobs: List[List[str]] = field(default_factory=list)
    """Extra generator invocations, as argv fragments appended after the
    generator path. ``{outdir}`` is substituted with the artifact directory.
    Only c_backend needs this: its driver links a second, C-backend-emitted
    copy of the same pipeline alongside the native one."""

    extra_driver_link: List[str] = field(default_factory=list)
    """Extra files inside the artifact directory to compile into the driver."""


APPS = {
    # Self-checking: generates random input and compares the Halide pipeline
    # against two reference C++ implementations. The only app of the five whose
    # shipped test is a real correctness oracle rather than a demo -- though it
    # skips a 64-pixel border.
    "blur": AppConfig(
        name="blur",
        generator_source="apps/blur/halide_blur_generator.cpp",
        generator_name="halide_blur",
        function_name="halide_blur",
        driver_source="apps/blur/test.cpp",
        driver_args=[],
        needs_auto_variant=False,
        needs_runtime=False,
        input_image=None,
        output_artifact=None,
        needs_image_io=False,
    ),
    "bilateral_grid": AppConfig(
        name="bilateral_grid",
        generator_source="apps/bilateral_grid/bilateral_grid_generator.cpp",
        generator_name="bilateral_grid",
        function_name="bilateral_grid",
        driver_source="apps/bilateral_grid/filter.cpp",
        driver_args=["{input}", "{output}", "0.1", "10"],
        input_image="apps/images/gray.png",
        output_artifact="out.png",
    ),
    "harris": AppConfig(
        name="harris",
        generator_source="apps/harris/harris_generator.cpp",
        generator_name="harris",
        function_name="harris",
        driver_source="apps/harris/filter.cpp",
        driver_args=["{input}", "{output}"],
        input_image="apps/images/rgba.png",
        output_artifact="out.png",
    ),
    "unsharp": AppConfig(
        name="unsharp",
        generator_source="apps/unsharp/unsharp_generator.cpp",
        generator_name="unsharp",
        function_name="unsharp",
        driver_source="apps/unsharp/filter.cpp",
        driver_args=["{input}", "{output}"],
        input_image="apps/images/rgba.png",
        output_artifact="out.png",
    ),
    # Historically the most fragile of the five: the largest generator, and the
    # heaviest at both generate and run time.
    "camera_pipe": AppConfig(
        name="camera_pipe",
        generator_source="apps/camera_pipe/camera_pipe_generator.cpp",
        generator_name="camera_pipe",
        function_name="camera_pipe",
        driver_source="apps/camera_pipe/process.cpp",
        driver_args=["{input}", "3700", "2.0", "50", "1.0", "1", "{output}", "{outdir}/h_auto.png"],
        input_image="apps/images/bayer_raw.png",
        output_artifact="out.png",
        extra_driver_outputs=["h_auto.png"],
        run_timeout=600,
        generate_timeout=1200,
        memory_heavy=True,
    ),
    # ---- the remaining Table-4 apps that exist in this checkout ----------
    # Flagged RAM-heavy by the thesis (needed swap at 32GB).
    "bgu": AppConfig(
        name="bgu",
        generator_source="apps/bgu/bgu_generator.cpp",
        generator_name="bgu",
        function_name="bgu",
        driver_source="apps/bgu/filter.cpp",
        driver_args=["{input}", "{output}"],
        input_image="apps/images/rgb.png",
        output_artifact="out.png",
        run_timeout=600,
        generate_timeout=1200,
        memory_heavy=True,
    ),
    # The only app in the corpus whose shipped driver is a differential
    # oracle: it runs the same pipeline through the LLVM backend and through
    # the C backend and asserts the two agree. Both copies are emitted by the
    # same (mutated) generator run, so the comparison is blind to generator
    # mutation by construction -- see the notes in the run report.
    "c_backend": AppConfig(
        name="c_backend",
        generator_source="apps/c_backend/pipeline_generator.cpp",
        generator_name="pipeline",
        function_name="pipeline_native",
        driver_source="apps/c_backend/run.cpp",
        driver_args=[],
        needs_auto_variant=False,
        needs_runtime=False,
        input_image=None,
        output_artifact=None,
        needs_image_io=False,
        extra_gen_jobs=[
            ["-g", "pipeline", "-o", "{outdir}", "-f", "pipeline_c",
             "-e", "c_source,c_header", "target=host"],
        ],
        extra_driver_link=["pipeline_c.halide_generated.cpp"],
    ),
    "conv_layer": AppConfig(
        name="conv_layer",
        generator_source="apps/conv_layer/conv_layer_generator.cpp",
        generator_name="conv_layer",
        function_name="conv_layer",
        driver_source="apps/conv_layer/process.cpp",
        driver_args=[],
        needs_runtime=False,
        input_image=None,
        output_artifact=None,
        needs_image_io=False,
        run_timeout=900,
        generate_timeout=1200,
    ),
    "depthwise_separable_conv": AppConfig(
        name="depthwise_separable_conv",
        generator_source=(
            "apps/depthwise_separable_conv/depthwise_separable_conv_generator.cpp"),
        generator_name="depthwise_separable_conv",
        function_name="depthwise_separable_conv",
        driver_source="apps/depthwise_separable_conv/process.cpp",
        driver_args=[],
        needs_runtime=False,
        input_image=None,
        output_artifact=None,
        needs_image_io=False,
        run_timeout=900,
    ),
    "hist": AppConfig(
        name="hist",
        generator_source="apps/hist/hist_generator.cpp",
        generator_name="hist",
        function_name="hist",
        driver_source="apps/hist/filter.cpp",
        driver_args=["{input}", "{output}"],
        input_image="apps/images/rgba.png",
        output_artifact="out.png",
    ),
    "iir_blur": AppConfig(
        name="iir_blur",
        generator_source="apps/iir_blur/iir_blur_generator.cpp",
        generator_name="iir_blur",
        function_name="iir_blur",
        driver_source="apps/iir_blur/filter.cpp",
        driver_args=["{input}", "{output}"],
        input_image="apps/images/rgba.png",
        output_artifact="out.png",
    ),
    # Flagged RAM-heavy by the thesis (needed swap at 32GB).
    "lens_blur": AppConfig(
        name="lens_blur",
        generator_source="apps/lens_blur/lens_blur_generator.cpp",
        generator_name="lens_blur",
        function_name="lens_blur",
        driver_source="apps/lens_blur/process.cpp",
        # The app's own Makefile passes 3 timing iterations; 1 is used here.
        # That argument drives only the benchmark loop, not the output.
        driver_args=["{input}", "32", "13", "0.5", "32", "1", "{output}"],
        needs_runtime=False,
        input_image="apps/images/rgb_small.png",
        output_artifact="out.png",
        run_timeout=900,
        generate_timeout=1800,
        memory_heavy=True,
    ),
    "max_filter": AppConfig(
        name="max_filter",
        generator_source="apps/max_filter/max_filter_generator.cpp",
        generator_name="max_filter",
        function_name="max_filter",
        driver_source="apps/max_filter/filter.cpp",
        driver_args=["{input}", "{output}"],
        input_image="apps/images/rgba.png",
        output_artifact="out.png",
        run_timeout=600,
    ),
    "nl_means": AppConfig(
        name="nl_means",
        generator_source="apps/nl_means/nl_means_generator.cpp",
        generator_name="nl_means",
        function_name="nl_means",
        driver_source="apps/nl_means/process.cpp",
        # As for lens_blur: the app's Makefile passes 10 timing iterations,
        # 1 is used here. Timing only; the saved image is unaffected.
        driver_args=["{input}", "7", "7", "0.12", "1", "{output}"],
        needs_runtime=False,
        input_image="apps/images/rgb.png",
        output_artifact="out.png",
        run_timeout=900,
    ),
}

# `compositing` is listed in the thesis's Table 4 but does not exist in this
# Halide checkout: it lives only on the upstream side branch
# `abadams/compositing_app` and was never merged into release/16.x. The corpus
# reachable here is therefore 14 apps, not 15.
MISSING_FROM_CHECKOUT = {
    "compositing": "only on upstream branch abadams/compositing_app; not in release/16.x",
}


# The experiment arms: the full 65-operator Halide-native set, split by
# operator family. Two mutation routes are involved -- see ARM_ROUTE.
ARMS = {
    # The legacy 12 arithmetic operators: pairwise + - * / on Halide::Expr.
    # Every one has a direct C++ sibling.
    "arithmetic": [
        "Halide_add_to_mul", "Halide_add_to_sub", "Halide_add_to_div",
        "Halide_sub_to_mul", "Halide_sub_to_add", "Halide_sub_to_div",
        "Halide_mul_to_add", "Halide_mul_to_sub", "Halide_mul_to_div",
        "Halide_div_to_mul", "Halide_div_to_sub", "Halide_div_to_add",
    ],
    # The new schedule-directive family. No C++ or GPL sibling exists: these
    # mutate how the pipeline is scheduled, not what it computes.
    "schedule": [
        "Halide_vectorize_to_unroll", "Halide_vectorize_to_parallel",
        "Halide_unroll_to_vectorize", "Halide_unroll_to_parallel",
        "Halide_parallel_to_vectorize", "Halide_parallel_to_unroll",
        "Halide_compute_at_to_store_at", "Halide_store_at_to_compute_at",
    ],
    # The census-driven expansion: every Mull C++ mutator for which Halide::Expr
    # was empirically confirmed to overload the operator. Relational, logical,
    # bitwise, compound-assignment, min/max and the negation family.
    "generated": [
        "Halide_eq_to_ne", "Halide_ne_to_eq",
        "Halide_ge_to_gt", "Halide_ge_to_lt",
        "Halide_gt_to_ge", "Halide_gt_to_le",
        "Halide_le_to_gt", "Halide_le_to_lt",
        "Halide_lt_to_ge", "Halide_lt_to_le",
        "Halide_and_to_or", "Halide_or_to_and", "Halide_xor_to_or",
        "Halide_logical_and_to_or", "Halide_logical_or_to_and",
        "Halide_lshift_to_rshift", "Halide_rshift_to_lshift",
        "Halide_rem_to_div",
        "Halide_min_to_max", "Halide_max_to_min",
        "Halide_add_assign_to_sub_assign", "Halide_sub_assign_to_add_assign",
        "Halide_mul_assign_to_div_assign", "Halide_div_assign_to_mul_assign",
        "Halide_not_to_negate", "Halide_not_to_bitwise_not",
        "Halide_negate_to_not", "Halide_negate_to_bitwise_not",
        "Halide_bitwise_not_to_not", "Halide_bitwise_not_to_negate",
    ],
    # AST route from here down.
    "boundary_conditions": [
        "Halide_repeat_edge_to_repeat_image",
        "Halide_repeat_edge_to_mirror_image",
        "Halide_repeat_edge_to_mirror_interior",
        "Halide_repeat_image_to_repeat_edge",
        "Halide_repeat_image_to_mirror_image",
        "Halide_repeat_image_to_mirror_interior",
        "Halide_mirror_image_to_repeat_edge",
        "Halide_mirror_image_to_repeat_image",
        "Halide_mirror_image_to_mirror_interior",
        "Halide_mirror_interior_to_repeat_edge",
        "Halide_mirror_interior_to_repeat_image",
        "Halide_mirror_interior_to_mirror_image",
    ],
    "select_clamp": [
        "Halide_select_swap_branches",
        "Halide_clamp_swap_bounds",
    ],
    # Reported on its own: its yield is site-dependent (Halide's simplifier
    # folds the mutated intrinsic back to a Select wherever it can prove both
    # branches safe), so pooling it with select/clamp would hide that.
    "if_then_else": [
        "Halide_select_to_if_then_else",
    ],
}

# Which frontend instruments the generator TU for each arm. The IR route is a
# `-fpass-plugin=` LLVM pass matching mangled callee names; the AST route is a
# `-fplugin=` Clang plugin rewriting real AST nodes through Sema. Both share
# mull.yml, the env-var dispatch and the mutant-key format, so only stage 1
# differs.
ARM_ROUTE = {
    "arithmetic": "ir",
    "schedule": "ir",
    "generated": "ir",
    "boundary_conditions": "ast",
    "select_clamp": "ast",
    "if_then_else": "ast",
}

# Human-readable family names for the report.
ARM_FAMILY = {
    "arithmetic": "arithmetic",
    "schedule": "schedule directive",
    "generated": "relational/logical/bitwise/compound",
    "boundary_conditions": "BoundaryConditions",
    "select_clamp": "select/clamp",
    "if_then_else": "select->if_then_else",
}
