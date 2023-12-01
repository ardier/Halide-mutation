import pandas as pd
import datetime
import os
import tqdm


def generate_killmap(df_reports, mutant_mapping, test_mapping, killmap_path="./mutation/reports/mutation"):
    # TODO test this function
    '''
    Given a df of reports this function generates a killmap of test ids to mutant_id

    params:
        df_reports: a dataframe containing the reports
        mutant_mapping: a dataframe containing the mutant mapping
        test_mapping: a dataframe containing the test mapping
        path_to_reports: the path to the reports

    returns:
        a dataframe containing the killmap
    '''
    # Iterate the rows in df_reports
    # For each row, get the test id and mutant id and if did not survive, add it to the killmap
    columns = ["test_id", "mutant_id"]
    killmap = pd.DataFrame(columns=columns)
    for index, row in tqdm.tqdm(df_reports.iterrows(), total=df_reports.shape[0], desc="Generating killmap"):
        if row["status"] != "Survived":
            test_id = int(test_mapping[test_mapping["full_test_name"]
                                       == row["test"]]["id"])
            # TODO ensure that the mutant id is an int and that a mutant retains its id throughout the process
            mutant_id = int(row['id'])

            temp_df = pd.DataFrame(
                data=[[test_id, mutant_id]], columns=columns)
            killmap = pd.concat([killmap, temp_df])

    # create the path if it doesn't exist
    if not os.path.exists(killmap_path):
        os.makedirs(killmap_path)

    # remove duplicates
    killmap = killmap.drop_duplicates()

    # Store killmap using datetime.now to make the file name unique
    killmap.to_csv(os.path.join(killmap_path, f"killmap_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                   index=False, encoding='utf-8')

    print("Killmap generated successfully")

    return killmap


if __name__ == "__name__":
    mutant_mapping = pd.read_csv(
        "./mutation/reports/mutation/mutant_mapping.csv")
    test_mapping = pd.read_csv("./mutation/reports/mutation/test_mapping.csv")
    df_reports = pd.read_csv("./mutation/reports/mutation/reports.csv")

    generate_killmap(df_reports, mutant_mapping, test_mapping)
