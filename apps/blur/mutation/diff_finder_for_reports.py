# imports two reports
# if the status in the reports do not start with matching words, it prints the diffs on the screen


import pandas as pd


def diff_finder_for_reports(first_report_name="Source Code",
                            first_report_path="/Users/smadadi/Projects/final_reports/halide_bn/source_code_final_report.csv",
                            second_report_name="Base Mull",
                            second_report_path="/Users/smadadi/Projects/final_reports/halide_bn/base_mull_mutation_report.csv"):

    # import first report
    first_report = pd.read_csv(first_report_path)
    # import second report
    second_report = pd.read_csv(second_report_path)
    total_counter = 0
    # the number of times first included kill and second did not
    first_report_counter = 0
    # the number of times second included kill and first did not
    second_report_counter = 0

    # iterate the reports and update the report accordingly
    for index, row in first_report.iterrows():
        first_status = first_report.iloc[index]["status"]
        second_status = second_report.iloc[index]["status"]
        mutant_id = first_report.iloc[index]["id"]
        # check if the first five letters of the statuses match when lowercased
        if first_status[:5].lower() != second_status[:5].lower():
            print(
                f"For mutation id {mutant_id}: First report status: {first_status} Second report status: {second_status}")
            print("")
            total_counter += 1
            if first_status[:4].lower() == "kill" or "failed" in first_status.lower():
                first_report_counter += 1
            elif second_status[:4].lower() == "kill" or "failed" in second_status.lower():
                second_report_counter += 1
            else:
                print(f"Something went wrong on index: {index}")
    print("")
    print(f"Total number of diffs: {total_counter}")
    print(f"{first_report_name} counter: {first_report_counter}")
    print(f"{second_report_name} counter: {second_report_counter}")
    print("")


if __name__ == "__main__":
    diff_finder_for_reports()
