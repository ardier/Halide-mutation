# creates a custom mull yaml file for each mutation operator supported by mull
# calls compiler_runner.py to compile the program using that custom yaml file
# creates the top-level reports directory for each job and passes it to test_runner.py

import compiler_runner
import test_runner
import sys
import os
import datetime


def compile(compile_command):
    compiler_runner.compile(compile_command=compile_command)


def generate_mull_config(mutop):
    # create a custom mull yaml file for the given mutation operator in the current directory
    content_to_write = f"""\
    mutators:
        - {mutop}
    timeout: 3000000 
    quiet: false
    """

    with open(f"mull.yml", "w") as f:
        f.write(content_to_write)

    print(f"Created mull.yaml for {mutop}")


def get_mutation_operators():
    return ["cxx_add_assign_to_sub_assign"  # Replaces += with -=
            ,
            "cxx_add_to_sub"  # Replaces + with -
            ,
            "cxx_and_assign_to_or_assign"  # Replaces &= with |=
            ,
            "cxx_and_to_or"  # Replaces & with |
            ,
            "cxx_assign_const"  # Replaces ‘a = b’ with ‘a = 42’
            ,
            "cxx_bitwise_not_to_noop"  # Replaces ~x with x
            ,
            "cxx_div_assign_to_mul_assign"  # Replaces /= with *=
            ,
            "cxx_div_to_mul"  # Replaces / with *
            ,
            "cxx_eq_to_ne"  # Replaces == with !=
            ,
            "cxx_ge_to_gt"  # Replaces >= with >
            ,
            "cxx_ge_to_lt"  # Replaces >= with <
            ,
            "cxx_gt_to_ge"  # Replaces > with >=
            ,
            "cxx_gt_to_le"  # Replaces > with <=
            ,
            "cxx_init_const"  # Replaces ‘T a = b’ with ‘T a = 42’
            ,
            "cxx_le_to_gt"  # Replaces <= with >
            ,
            "cxx_le_to_lt"  # Replaces <= with <
            ,
            "cxx_logical_and_to_or"  # Replaces && with ||
            ,
            "cxx_logical_or_to_and"  # Replaces || with &&
            ,
            "cxx_lshift_assign_to_rshift_assign"  # Replaces <<= with >>=
            ,
            "cxx_lshift_to_rshift"  # Replaces << with >>
            ,
            "cxx_lt_to_ge"  # Replaces < with >=
            ,
            "cxx_lt_to_le"  # Replaces < with <=
            ,
            "cxx_minus_to_noop"  # Replaces -x with x
            ,
            "cxx_mul_assign_to_div_assign"  # Replaces *= with /=
            ,
            "cxx_mul_to_div"  # Replaces * with /
            ,
            "cxx_ne_to_eq"  # Replaces != with ==
            ,
            "cxx_or_assign_to_and_assign"  # Replaces |= with &=
            ,
            "cxx_or_to_and"  # Replaces | with &
            ,
            "cxx_post_dec_to_post_inc"  # Replaces x– with x++
            ,
            "cxx_post_inc_to_post_dec"  # Replaces x++ with x–
            ,
            "cxx_pre_dec_to_pre_inc"  # Replaces –x with ++x
            ,
            "cxx_pre_inc_to_pre_dec"  # Replaces ++x with –x
            ,
            "cxx_rem_assign_to_div_assign"  # Replaces %= with /=
            ,
            "cxx_rem_to_div"  # Replaces % with /
            ,
            "cxx_remove_negation"  # Replaces !a with a
            ,
            "cxx_remove_void_call"  # Removes calls to a function returning void
            ,
            "cxx_replace_scalar_call"  # Replaces call to a function with 42
            ,
            "cxx_rshift_assign_to_lshift_assign"  # Replaces >>= with <<=
            ,
            "cxx_rshift_to_lshift"  # Replaces << with >>
            ,
            "cxx_sub_assign_to_add_assign"  # Replaces -= with +=
            ,
            "cxx_sub_to_add"  # Replaces - with +
            ,
            "cxx_xor_assign_to_or_assign"  # Replaces ^= with |=
            ,
            "cxx_xor_to_or"  # Replaces ^ with |
            ,
            "negate_mutator"  # Negates conditionals !x to x and x to !x
            ,
            "scalar_value_mutator"  # Replaces zeros with 42, and non-zeros with 0
            ]


def create_top_level_folder(parent_dir="./mutation/reports/jobs"):
    '''
    Creates a top directory for the reports for this job based on the current time

    returns:
        the path to the top directory
    '''
    # Create a top directory for the reports for this job based on the current time
    job_dir = os.path.join(
        parent_dir, datetime.datetime.now().strftime("%Y%m%d%H%M%S"))
    if not os.path.exists(job_dir):
        os.makedirs(job_dir)

    return job_dir


def handle_the_process(compiler_command):
    top_level_folder = create_top_level_folder()
    mutops = get_mutation_operators()
    for mutop in mutops:
        print(f"Compiling for {mutop}")
        generate_mull_config(mutop)
        # compile for each mutation operator
        compile(compile_command=compiler_command)
        print(f"Compilation for {mutop} complete")
        # run tests for each mutation operator
        print(f"Testing for {mutop}")
        test_runner.main(job_dir=top_level_folder,
                         new_job=True, generate_final_reports=True, mutop=mutop)
        print(f"Testing for {mutop} complete")
    print(f"Reports for this job are in {top_level_folder}")


if __name__ == "__main__":
    # compile_command = sys.argv[1]
    compiler_command = "python photoshop/jenkinspipeline/scripts/build_and_test.py --product halide_unit_tests  --platform mac --arch arm --config release --action build"
    handle_the_process(
        compiler_command="python photoshop/jenkinspipeline/scripts/build_and_test.py --product halide_unit_tests  --platform mac --arch arm --config release --action build")
