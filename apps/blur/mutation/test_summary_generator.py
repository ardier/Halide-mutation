import pandas as pd
import datetime
import os
import tqdm


def generate_test_summary(kill_matrix, test_summary_path="./mutation/reports/mutation", test_info_csv_files_path="./mutation/reports/mutation"):
    # Test this function
    """
    # For each test print the number of mutants killed by it and a list of mutants killed by it
    """
    kill_count = pd.DataFrame(
        0, index=range(len(kill_matrix)), columns=["test_name", "status", "kill_count", "killed_mutants", "time"])

    for index, row in tqdm.tqdm(kill_matrix.iterrows(), total=kill_matrix.shape[0], desc="Generating kill count"):
        kill_count.at[index, "test_name"] = row["test_name"]
        kill_count.at[index, "kill_count"] = row[1:].sum()
        # iterate though the list list(row[1:][row[1:] == 1]) and store the mutant names as a comma-separated string
        kill_count.at[index, "killed_mutants"] = ",".join(
            list(row[1:][row[1:] == 1]))

        # import status and time from the intermediate file stored at test_info_csv_files_path
        test_info = pd.read_csv(os.path.join(
            test_info_csv_files_path, f"{row['test_name']}.csv"))
        kill_count.at[index, "status"] = test_info.at[0, "status"]
        kill_count.at[index, "time"] = test_info.at[0, "time"]

    # create the path if it doesn't exist
    if not os.path.exists(test_summary_path):
        os.makedirs(test_summary_path)

    # store kill_count using datetime.now to make the file name unique
    kill_count.to_csv(os.path.join(test_summary_path, f"kill_count_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                      index=False, encoding='utf-8')

    return kill_count
