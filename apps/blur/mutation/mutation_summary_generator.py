# This script takes a kill map and a mutation map and generates a mutation summary report.
# each mutant matches its id from the mutation map and if its status is either killed or survived, it is added to the report
# if a mutant is killed by at least one test, it is marked as killed. If it is killed, a third column is added to the report
# containing the tests that killed it.

import pandas as pd
import datetime
import os


def generate_mutation_summary_report(killmap_path="./mutation/reports/jobs/20231023174627/3_killmap/killmap_20231024200553.csv",
                                     mutation_map_path="./mutation/reports/jobs/20231023174627/2_mutant_mapping/mutant_mapping_20231024195120.csv",
                                     mutation_summary_report_path="./mutation/reports/jobs/20231023174627/5_mutation_summary"):
    # import mutation map
    mutation_map = pd.read_csv(mutation_map_path)
    mutation_map = mutation_map.drop(columns=['status'])
    # import killmap
    killmap = pd.read_csv(killmap_path)
    # create a dataframe for the report
    report = pd.DataFrame(
        columns=["mutant_id", "mutation", "status", "killing_tests", "start", "end"])

    # TODO add start and end
    # iterate the mutation map and add all mutants id's only to the report
    for index, row in mutation_map.iterrows():
        # get the mutant id
        mutant_id = row["id"]

        mutation = row["mutation"]
        start = row["start"]
        end = row["end"]
        # add the mutant id to the report
        report = pd.concat([report, pd.DataFrame(
            {"mutant_id": [mutant_id], "mutation": [mutation], "status": ["Survived"], "killing_tests": [""], "start": [start], "end": [end]})])

    # iterate the killmap and update the report accordingly
    for index, row in killmap.iterrows():
        # get the mutant id
        mutant_id = row["mutant_id"]
        # get the test id
        test_id = row["test_id"]

        # set the mutant status to killed using using
        report.loc[report["mutant_id"] ==
                   mutant_id, "status"] = "Killed"

        # append the test id to the killing_tests column
        report.loc[report["mutant_id"] ==
                   mutant_id, "killing_tests"] += f"{test_id},"

    # create the path if it doesn't exist
    if not os.path.exists(mutation_summary_report_path):
        os.makedirs(mutation_summary_report_path)

    # store the report with a unique name based on the current time
    report.to_csv(os.path.join(mutation_summary_report_path, f"mutation_summary_report_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                  index=False, encoding='utf-8')

    print("Mutation summary report generated successfully")


if __name__ == "__main__":
    generate_mutation_summary_report()
