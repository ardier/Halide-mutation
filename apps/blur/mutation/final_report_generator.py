# imports 1. The test mapping
# imports 2. The base mull report
# imports 3. the parallel mull report
# imports 4. the source code report
# imports 5. old final report

# checks if the the status in the source code report contains kill but does not contain kill in any of the other three reports
# if yes, it prompts the user to choose which report to trust
# saves the new report as final_comparison_report.csv

import pandas as pd
import os
import datetime


def generate_final_comparison_report(test_mapping_path="/Users/smadadi/Projects/final_reports/halide_bn/test_mapping.csv",
                                     base_mull_report_path="/Users/smadadi/Projects/final_reports/halide_bn/base_mull_mutation_report.csv",
                                     parallel_mull_report_path="/Users/smadadi/Projects/final_reports/halide_bn/parallel_mutation_summary_report.csv",
                                     source_code_report_path="/Users/smadadi/Projects/final_reports/halide_bn/source_code_final_report.csv",
                                     old_final_comparison_report_path="/Users/smadadi/Projects/final_reports/halide_bn/old_mutation_report.csv",
                                     final_comparison_report_path="/Users/smadadi/Projects/final_reports/halide_bn/"):

    # import test mapping
    test_mapping = pd.read_csv(test_mapping_path)
    # import base mull report
    base_mull_report = pd.read_csv(base_mull_report_path)
    # import parallel mull report
    parallel_mull_report = pd.read_csv(parallel_mull_report_path)
    # import source code report
    source_code_report = pd.read_csv(source_code_report_path)
    # import old final comparison report
    old_final_comparison_report = pd.read_csv(old_final_comparison_report_path)

    # create a dataframe for the report
    report = pd.DataFrame(
        columns=["mutant_id", "mutation", "status", "killing_tests", "start", "end", "comment", "source_code_status", "base_mull_status", "parallel_mull_status", "old_final_comparison_status"])

    # iterate the source code report and add all mutants id's only to the report
    for index, row in base_mull_report.iterrows():
        # get the mutant id
        mutant_id = row["id"]

        mutation = parallel_mull_report.iloc[index]["mutation"]
        start = row["start"]
        end = row["end"]
        # add the mutant id to the report
        report = pd.concat([report, pd.DataFrame(
            {"mutant_id": [mutant_id], "mutation": [mutation], "status": source_code_report.iloc[index]["status"], "killing_tests": [""], "start": [start], "end": [end]})])

    # since all the reports have the same number of rows, we can iterate over all of them at once

    # iterate the reports and update the report accordingly
    counter = 0
    for index, row in base_mull_report.iterrows():
        # get the mutant id
        mutant_id = report.iloc[index]["mutant_id"]
        # get the status
        status = report.iloc[index]["status"]
        # get the killing tests
        killing_tests = report.iloc[index]["killing_tests"]

        # get different statuses from the other reports
        parallel_mull_report_status = parallel_mull_report.iloc[index]["status"]
        old_final_comparison_report_status = old_final_comparison_report.iloc[index]["Status"]
        base_mull_report_status = base_mull_report.iloc[index]["status"]

        # if the source code report includes the string survived in the status, but one of the other reports includes the string killed or crashed in the status promopt the user to choose which report to trust
        if "Survived" in status and (("Killed" in parallel_mull_report_status or "Crashed" in parallel_mull_report_status) or ("Killed" in old_final_comparison_report_status or "Crashed" in old_final_comparison_report_status) or ("Killed" in base_mull_report_status or "Crashed" in base_mull_report_status)):
            # prompt the user to choose which report to trust
            print(
                f"Mutant {mutant_id} has different status in the source code report and one of the other reports")
            print(f"Source code report status: {status}")
            print(f"Base mull report status: {base_mull_report_status}")
            print(
                f"Parallel mull report status: {parallel_mull_report_status}")
            print(
                f"Old final comparison report status: {old_final_comparison_report_status}")
            print(f"Choose which report to trust: ")
            print("1. Source code report")
            print("2. Base mull report")
            print("3. Parallel mull report")
            print("4. Old final comparison report")

            # get the user input
            user_input = input()

            comment = input("Enter comment: ")
            # update the comment
            report.loc[report["mutant_id"] == mutant_id,
                       "comment"] = comment

            # update the source code status
            report.loc[report["mutant_id"] == mutant_id,
                       "source_code_status"] = status
            # update the base mull status
            report.loc[report["mutant_id"] == mutant_id,
                       "base_mull_status"] = base_mull_report_status
            # update the parallel mull status
            report.loc[report["mutant_id"] == mutant_id,
                       "parallel_mull_status"] = parallel_mull_report_status
            # update the old final comparison status
            report.loc[report["mutant_id"] == mutant_id,
                       "old_final_comparison_status"] = old_final_comparison_report_status

            # while the user input is not valid, prompt the user to choose again
            while user_input not in ["1", "2", "3", "4"]:
                print("Invalid input, please choose again")
                user_input = input()

            # update the status based on the user input
            if user_input == "1":
                report.loc[report["mutant_id"] ==
                           mutant_id, "status"] = status
            elif user_input == "2":
                report.loc[report["mutant_id"] ==
                           mutant_id, "status"] = base_mull_report_status
            elif user_input == "3":
                report.loc[report["mutant_id"] ==
                           mutant_id, "status"] = parallel_mull_report_status
            elif user_input == "4":
                report.loc[report["mutant_id"] ==
                           mutant_id, "status"] = old_final_comparison_report_status

        # append the test id to the killing_tests column
        report.loc[report["mutant_id"] ==
                   mutant_id, "killing_tests"] += f"{killing_tests},"

        # store the report with a unique name based on the current time
        report.to_csv(os.path.join(final_comparison_report_path, f"final_comparison_report_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                      index=False, encoding='utf-8')

    # store the report with a unique name based on the current time
    report.to_csv(os.path.join(final_comparison_report_path, f"final_comparison_report_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                  index=False, encoding='utf-8')


if __name__ == "__main__":
    generate_final_comparison_report()
