import os
import datetime
import pandas as pd
import report_generator as report_generator


def generate_intermediate_reports(path_to_json_reports="./mutation/reports/mutation/0_json_reports"):
    '''
    Combines all the mull reports into one report

    params:
        path_to_reports: the path to the reports

    returns:
        a tuple containin:
            1. dataframe containing the combined reports
            2. dataframe containing the mutant mapping
    '''
    reports = pd.DataFrame()
    first_run = True
    for file in os.listdir(path_to_json_reports):
        if file.endswith(".json"):

            full_test_name = file.split("_")[0]
            temp_df = report_generator.generate_report(
                report_path=path_to_reports, report_prefix="mutation_report", json_file_path=os.path.join(path_to_json_reports, file),
                full_test_name=full_test_name)

            if first_run:
                first_run = False
                # Generate mutant mapping
                mutants_df = temp_df
                # Store mutant mapping using datetime.now to make the file name unique
                mutants_df.to_csv(os.path.join(path_to_reports, f"mutant_mapping_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                                  index=False, encoding='utf-8')

            # Concat the csv files into one file
            reports = pd.concat([reports, temp_df])

    # Use datetime.now to make the file name unique
    reports.to_csv(os.path.join(path_to_reports, f"mutation_report_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                   index=False, encoding='utf-8')

    print("Combined report generated successfully")
    return reports, mutants_df
