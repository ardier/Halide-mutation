
import pandas as pd
import datetime
import os
import tqdm


def generate_kill_matrix(killmap, mutants_df, test_names, killmatrix_path="./mutation/reports/mutation"):
    # TODO test this function
    '''
    Generates a killmatrix for mutants
    '''
    # Create a df with the same number of rows as the number of tests + 1 and columns as the number of mutants + 1
    # number the rows and columns from 0 to n
    # Initilize all values to 0
    kill_matrix = pd.DataFrame(
        0, index=range(len(test_names)), columns=range(len(mutants_df)))

    # iterate the killmap and update the kill_matrix accordingly
    for index, row in tqdm.tqdm(killmap.iterrows(), total=killmap.shape[0], desc="Generating kill matrix"):
        kill_matrix.at[row["test_id"], row["mutant_id"]] = 1

    # add test names as the first column

    kill_matrix.insert(0, "test_name", test_names["full_test_name"])

    # create the path if it doesn't exist
    if not os.path.exists(killmatrix_path):
        os.makedirs(killmatrix_path)

    # store kill_matrix using datetime.now to make the file name unique
    kill_matrix.to_csv(os.path.join(killmatrix_path, f"kill_matrix_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.csv"),
                       index=False, encoding='utf-8')

    print("Kill matrix generated successfully")

    return kill_matrix


if __name__ == "__main__":
    mutants_df = pd.read_csv("./mutation/reports/mutation/mutant_mapping.csv")
    test_names = pd.read_csv("./mutation/reports/mutation/test_mapping.csv")
    killmap = pd.read_csv("./mutation/reports/mutation/killmap.csv")
    generate_kill_matrix(killmap, mutants_df, test_names)
