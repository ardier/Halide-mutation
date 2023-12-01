'''
This script collects the name of all tests/parameters used by gtest and runs them while storing the results in various csv files as the tests run.
'''
import subprocess
import os
import pandas as pd
import report_generator
import killmatrix_generator
import killmap_generator
import test_summary_generator
import datetime
from multiprocessing import Pool


def run_command(command):
    '''
    Runs a command and returns the results

    params:
        command: the command to be run

    returns:
        the result of the command
    '''
    result = None
    try:
        result = subprocess.run(command, shell=True, check=True,
                                stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, text=True)

    except subprocess.CalledProcessError as e:
        result = e.output

    return result


def collect_test_names(gtest_binary="./dist/xcode_macos/Release/universal/build/photoshop/halide_bn_test/halide_bn_test/halide_bn_test",
                       filter="-\*Speed\*", override=False, test_names_path="./test_names.csv"):
    '''
    Collects the names of all tests in the gtest binary and returns them as a list
    It only runs if the override flag is set to true or if the test_names.csv file does not exist
    This function assumes the test names csv does not exists already and will override it if it does

    params:
        gtest_binary: the path to the gtest binary
        filter: a filter for the tests to be collected
        override: a flag to override the test_names.csv file if it already exists
        test_names_path: the path to the test_names.csv file

    returns:
        a dataframe containing the names of all tests and their subtests

    '''

    initial_test_output = run_command(
        f"{gtest_binary}  --gtest_filter={filter}")

    test_names = convert_std_out_to_test_names(initial_test_output)

    return store_test_names(test_names)


def convert_std_out_to_test_names(std_out):
    '''
    Converts the output of collect_test_names to a mapping of test names to their parameters (subtests)

    params:
        std_out: the output of collect_test_names

    returns:
        a mapping of test names to their parameters (subtests)
    '''
    test_names = {}
    for line in std_out.stdout.splitlines():
        if line.startswith("[ RUN"):
            full_test_name = line.split("] ")[-1]
            test_name, subtest_name = full_test_name.split(".")
            if test_name in test_names:
                test_names[test_name].append(subtest_name)
            else:
                test_names[test_name] = [subtest_name]

    return test_names


def store_test_names(test_names: dict):
    '''
    Stores the names of all tests in a csv file.
    Adds a header for test names and subtest names before storing the data.
    Returns the dataframe.
    This function assumes the test names csv does not exists already and will override it if it does

    params:
        test_names: a mapping of test names to their parameters (subtests)

    returns:   
        a dataframe containing the names of all tests and their subtests
    '''
    columns = ["id", "test_name", "subtest_name"]
    df = pd.DataFrame(columns=columns)
    id = 0
    for test_name in test_names:
        for subtest_name in test_names[test_name]:
            temp_df = pd.DataFrame(
                [[id, test_name, subtest_name]], columns=columns)
            df = pd.concat([df, temp_df])
            id += 1

    df["status"] = -1
    df.to_csv("test_names.csv", index=False)

    return df


def get_test_names_df(test_info_csv_files_path):
    '''
    Returns the test names dataframe

    returns:
        the test names dataframe
    '''
    if os.path.exists("test_names.csv"):
        results = pd.read_csv("test_names.csv")

        # set the status to -1 to indicate that the test has not been run yet
        results["status"] = -1

    else:
        print("Test names file does not exist. Running collect_test_names() to generate it")
        # Generate test status files as well to be used in parallel cases
        results = collect_test_names()
    generate_test_status_files(results, test_info_csv_files_path)
    return results


def generate_test_status_files(results, test_info_csv_files_path):
    """
    iterate the name of the tests in results and for each test name, create a csv file in test_info_csv_files_path



    """

    # make the directory if it doesn't exist
    if not os.path.exists(test_info_csv_files_path):
        os.makedirs(test_info_csv_files_path)

    for index, row in results.iterrows():
        test_name = row["test_name"]
        subtest_name = row["subtest_name"]
        full_test_name = f"{test_name}.{subtest_name}"

        full_test_name = full_test_name.replace("/", "_")

        df = pd.DataFrame(columns=["status", "time"])
        # set the status to -2 to indicate that the test has not been run yet
        df.loc[0] = [-1, 0]

        df.to_csv(os.path.join(test_info_csv_files_path,
                               f"{full_test_name}.csv"), index=False)

        print(f"Created test info file for {full_test_name}")


def run_tests(job_dir, test_names: pd.DataFrame, start_test_index=0, end_test_index=-1, mull_runner_path="./mutation/mull/build.dir/tools/mull-runner/mull-runner-14",
              mull_flags="-ide-reporter-show-killed --reporters Elements --report-dir ",
              gtest_path="./dist/xcode_macos/Release/universal/build/photoshop/halide_bn_test/halide_bn_test/halide_bn_test"):
    '''
    Runs the tests for mutants using Mulls wrapper (mull-runner) and stores the results in a csv file after each test is run
    This ensures that if the tests crash, the results are still stored
    To do this, it add a column to the dataframe called "status" and stores the status of each test in it.

    params:
        test_names: a dataframe containing the names of all tests to be run
        start_test_index: the index of the test to start running from
        end_test_index: the index of the test to stop running at
        mull_runner_path: the path to the mull-runner executable
        mull_flags: the flags to be passed to mull-runner
        gtest_path: the path to the gtest binary
        mull_report_path: the path to the mull reports

    '''

    # Create json reports directory
    json_reports_path = os.path.join(job_dir, "0_json_reports")

    if not os.path.exists(json_reports_path):
        os.makedirs(json_reports_path)

    # update mull flags to include the job dir
    mull_flags = f"{mull_flags}{json_reports_path} "

    num_tests = len(test_names)
    for index, row in test_names.iterrows():
        test_name = row["test_name"]
        subtest_name = row["subtest_name"]
        full_test_name = f"{test_name}.{subtest_name}"
        start_time = datetime.datetime.now()

        print(
            f"Running test: {index + 1} / {num_tests} {test_name}.{subtest_name}")

        # Skip tests that have already been run successfully. In this case, status = 0 or 1 is considered successful
        if row["status"] != -1:
            print(
                f"\t\tSkipping test {test_name}.{subtest_name} as it has already been run successfully")
            continue

        command = f"{mull_runner_path} {mull_flags} -- {gtest_path} --gtest_filter={full_test_name}"
        test_output = run_command(command)
        end_time = datetime.datetime.now()
        print(
            f"\t\tTest {test_name}.{subtest_name} finished in {end_time - start_time} for all mutants.")
        # Generate reports for each test
        status = handle_test_output(
            test_output,  test_name=full_test_name, index=index, reports_path=json_reports_path)
        test_names.at[index, "status"] = status
        test_names.to_csv("test_names.csv", index=False)


def run_tests_in_parallel(job_dir, test_names: pd.DataFrame, start_test_index=0, end_test_index=-1,
                          mull_runner_path="./mutation/mull/build.dir/tools/mull-runner/mull-runner-14",
                          mull_flags="-ide-reporter-show-killed --reporters Elements --report-dir ",
                          gtest_path="./dist/xcode_macos/Release/universal/build/photoshop/halide_bn_test/halide_bn_test/halide_bn_test", workers_per_job=1,
                          jobs=8,
                          test_info_path="./mutation/reports/jobs/20230928121517/6_test_info",
                          test_output_path="./mutation/reports/jobs/20230928121517/7_test_output"):
    '''
    Runs the tests for mutants using Mulls wrapper (mull-runner) and stores the results in a csv file after each test is run
    This ensures that if the tests crash, the results are still stored
    To do this, it add a column to the dataframe called "status" and stores the status of each test in it.

    params:
        test_names: a dataframe containing the names of all tests to be run
        start_test_index: the index of the test to start running from
        end_test_index: the index of the test to stop running at
        mull_runner_path: the path to the mull-runner executable
        mull_flags: the flags to be passed to mull-runner
        gtest_path: the path to the gtest binary
        mull_report_path: the path to the mull reports

    '''

    # Create json reports directory
    json_reports_path = os.path.join(job_dir, "0_json_reports")

    if not os.path.exists(json_reports_path):
        os.makedirs(json_reports_path)

    # update mull flags to include the job dir
    mull_flags = f"{mull_flags}{json_reports_path} --workers {workers_per_job}"

    num_tests = len(test_names)

    # execute the tests in parallel using the multiprocessing library from test_names.iterrows()
    row_data = list(test_names.iterrows())

    # Create a Pool of worker processes
    with Pool(jobs) as pool:
        # Map the 'process_row' function to the list of row data
        pool.map(inner_run_parallel, [(index, row, num_tests, mull_runner_path, mull_flags,
                 gtest_path, json_reports_path, test_info_path, test_output_path) for index, row in row_data])


def inner_run_parallel(args):
    index, row, num_tests, mull_runner_path, mull_flags, gtest_path, json_reports_path, test_info_path, test_output_path = args
    test_name = row["test_name"]
    subtest_name = row["subtest_name"]
    full_test_name = f"{test_name}.{subtest_name}"

    # TODO factor this out into a function to ensure the renaming is consistent
    full_test_name = full_test_name.replace("/", "_")

    start_time = datetime.datetime.now()

    print(
        f"Running test: {index + 1} / {num_tests} {test_name}.{subtest_name}")

    # Skip tests that have already been run successfully. In this case, status = 0 or 1 is considered successful
    # Read the tests' individual test files to determine if they have been run successfully
    if row["status"] == 0:
        print(
            f"\t\tSkipping test {test_name}.{subtest_name} as it has already been run successfully")
        return
    elif row["status"] == -2:
        print(
            f"\t\tSkipping test {test_name}.{subtest_name} because it failed before and needs to be inspected manually")
        return
    else:
        # save a time stamp for the test in case if
        save_test_info(full_test_name, "-2", start_time -
                       start_time, test_info_path)

    command = f"{mull_runner_path} {mull_flags} -- {gtest_path} --gtest_filter={full_test_name}"
    test_output = run_command(command)
    end_time = datetime.datetime.now()
    print(
        f"\t\tTest {test_name}.{subtest_name} finished in {end_time - start_time} for all mutants.")
    # Generate reports for each test
    status = handle_test_output(
        test_output,  test_name=full_test_name, index=index, reports_path=json_reports_path)

    store_test_output(test_output, full_test_name, test_output_path)

    # Saving into disk a csv containing the test name, status, and length of time it took to run the test
    save_test_info(full_test_name, status, end_time -
                   start_time, test_info_path)


def store_test_output(test_output, full_test_name, test_output_path):
    # store both the output and the error in a file named after the test within the test_output_path suffixed .log

    # check if the file folder exists and create it if it doesn't
    if not os.path.exists(test_output_path):
        os.makedirs(test_output_path)

    with open(os.path.join(test_output_path, f"{full_test_name}.log"), "w") as f:
        f.write(test_output)

    print(f"Stored test output for {full_test_name}")


def save_test_info(full_test_name, status, test_time, test_info_path):
    """
        Creates a csv file containing the test infos
    """
    # if not os.path.exists(test_times_path):
    #     os.makedirs(test_times_path)

    # test_times.to_csv(os.path.join(test_times_path,
    #                                "test_times.csv"), index=False)

    # import test dataframe as csv from test_info_path using its full_test_name as the filename.csv
    # if the file does not exist, don't create it. instead give an error
    # if the file exists, update the info in it and overwrite it

    # check if the file exists first
    if not os.path.exists(test_info_path):
        os.makedirs(test_info_path)
        df = pd.DataFrame(columns=["status", "time"])
        df.loc[0] = [status, test_time]
    else:

        df = pd.read_csv(os.path.join(test_info_path,
                                      f"{full_test_name}.csv"))

    # update the status and time columns
    df["status"] = status
    df["time"] = test_time

    df.to_csv(os.path.join(test_info_path,
                           f"{full_test_name}.csv"), index=False)


def handle_test_output(test_output: str, reports_path,  test_name="test", index=0):
    '''
    Handles the output of a test run by:
        1. renames the report file to include the test name for more clarity
        2. extracts and returns the status of the test run

    params:
        test_output: the output of the test run
        reports_path: the path to the reports
        test_name: the name of the test
        index: the index of the test in the test_names dataframe

    returns:
        the status of the test run

     '''
    # Extract the status of the test run from the output
    # TODO this is hardcoded for the time being but needs to be logic-based in the future
    status = 0

    # Rename the report file to include the test name by extracting the report file name from the output
    test_output_lines = test_output.splitlines()
    original_json_file_name = test_output_lines[-3].split(
        "generating report to ")[-1].split(reports_path)[-1].replace("/", "").strip()

    test_name = test_name.replace("/", "_")
    # Rename the file to have the test name as well as its original name in it
    report_file_name = f"{test_name}_{original_json_file_name}"
    os.rename(os.path.join(reports_path, original_json_file_name),
              os.path.join(reports_path, report_file_name))

    return status


def top_dir_generator(parent_dir="./mutation/reports/jobs"):
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


def retrive_job_dir(parent_dir="./mutation/reports/jobs"):
    '''
        Retirives the job dir based on the direcotry with the latest timestamp
    '''
    dirs = os.listdir(parent_dir)
    dirs.sort()
    # remove the .DS_Store file if it exists
    if dirs[0] == ".DS_Store":
        dirs.pop(0)

    return os.path.join(parent_dir, dirs[-1])


def main(job_dir=None, new_job=True, generate_final_reports=True, mutop=None):

    if new_job and job_dir is None:
        # Create a top directory for the reports for this job based on the current time
        job_dir = top_dir_generator()
    elif job_dir is None:
        # job_dir = retrive_job_dir()
        job_dir = "./mutation/reports/jobs/20230928121517"

    json_files_path = f"{job_dir}/0_json_reports"
    intermediate_csv_files_path = f"{job_dir}/1_intermediate_reports"
    final_csv_files_path = f"{job_dir}/2_final_reports"
    test_info_csv_files_path = f"{job_dir}/5_test_info"
    test_mapping_path = f"{job_dir}/7_test_mapping"
    mutant_mapping_path = f"{job_dir}/2_mutant_mapping"
    killmap_path = f"{job_dir}/3_killmap"
    killmatrix_path = f"{job_dir}/4_killmatrix"
    test_summary_path = f"{job_dir}/6_test_summary"
    test_output_path = f"{job_dir}/8_test_output"

    test_names = get_test_names_df(test_info_csv_files_path)
    print(test_names)

    if new_job:
        # run_tests(job_dir, test_names)
        run_tests_in_parallel(job_dir, test_names,
                              test_info_path=test_info_csv_files_path,
                              test_output_path=test_output_path)

    if generate_final_reports:
        reports, mutants_df = report_generator.generate_full_report_for_finished_tests(
            json_files_path=json_files_path,
            mutant_mapping_path=mutant_mapping_path,
            report_prefix="mutation_report",
            intermediate_report_path=intermediate_csv_files_path,
            final_report_path=final_csv_files_path, first_run=True)

    else:
        reports = pd.read_csv(
            "./mutation/reports/jobs/20230928121517/2_final_reports/mutation_report_20230928155914.csv")
        mutants_df = pd.read_csv(
            "mutation/reports/jobs/20230928121517/2_mutant_mapping/mutant_mapping_20230928123433.csv")

    # Create a new column in test_names called full_test_name by combining the test_name and subtest_name with a "."
    test_names["full_test_name"] = test_names["test_name"] + \
        "." + test_names["subtest_name"]

    # TODO factor this out into a function to ensure the renaming is consistent
    # replace all instances "Consistency/" with "Consistency." in the reports test column to match the test names

    reports["test"] = reports["test"].str.replace(
        "/", "_")

    test_names["full_test_name"] = test_names["full_test_name"].str.replace(
        "/", "_")

    # generate a test map file using the test names by just copying the test_names.csv file to
    # the test_mapping_path folder
    # make the directory if it doesn't exist
    if not os.path.exists(test_mapping_path):
        os.makedirs(test_mapping_path)

    test_names.to_csv(os.path.join(test_mapping_path,
                      "test_mapping.csv"), index=False)

    # Generate killmap
    killmap = killmap_generator.generate_killmap(
        reports, mutants_df, test_names, killmap_path=killmap_path)

    # Generate killmatrix
    kill_matrix = killmatrix_generator.generate_kill_matrix(
        killmap, mutants_df, test_names, killmatrix_path=killmatrix_path)

    # Generate test summary (kill count + status + time)
    # For each test print the number of mutants killed by it and a list of mutants killed by it
    test_summary = test_summary_generator.generate_test_summary(
        kill_matrix=kill_matrix, test_summary_path=test_summary_path, test_info_csv_files_path=test_info_csv_files_path)

    # TODO 5. generate test mutant subtest mapping


if __name__ == "__main__":
    main()
