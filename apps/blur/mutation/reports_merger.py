# merges the reports from the mutation testing tool
# remvoes the duplicates
# and stores the merged reports in a csv file

import os
import datetime
import pandas as pd


def merge_reports(path_to_reports="./mutation/reports/mutation"):
    # TODO test this function
    '''
    Merges the reports from the mutation testing tool

    params:
        path_to_reports: the path to the reports

    returns:
        a dataframe containing the merged reports
    '''
    # Get all the reports
    reports = [os.path.join(path_to_reports, file) for file in os.listdir(
        path_to_reports) if file.endswith(".csv") and file != "reports.csv"]

    # Merge the reports
    df_reports = pd.concat([pd.read_csv(report) for report in reports])

    # Remove the duplicates
    df_reports.drop_duplicates(inplace=True)

    # Store the reports using datetime.now to make the file name unique
    df_reports.to_csv(os.path.join(path_to_reports, f"reports_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                      index=False, encoding='utf-8')

    return df_reports


if __name__ == "__main__":
    merge_reports()
