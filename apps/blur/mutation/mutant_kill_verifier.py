class TestResult:
    def __init__(self, stdout: str, stderr: str, returncode: int):
        self.stdout = stdout
        self.stderr = stderr
        self.returncode = returncode

    def __str__(self):
        return f"Return Code: {self.returncode}\nStdout: {self.stdout}\nStderr: {self.stderr}"
    info = __str__

# Example usage:
result = TestResult("This is stdout", "This is stderr", 0)
print(result)  


# 1. changes the source code to manually add a mutation that survived all tests
# 2. compiles the source code
# 3. runs the tests
# 4. checks whether any of the tests killed the mutant or whether the testing was aborted
# 5. generates a final report


import os
import pandas as pd
import subprocess
import time
import tempfile



def mutate_and_test_all(mutant_summary_df_path="./apps/blur/mutation/reports/jobs/1/2_final_reports/final_report.csv",
                        final_report_df_path="./apps/blur/mutation/reports/jobs/1/2_final_reports/final_report.csv",
                        compile_command="./compile_cpp_and_test.sh",
                        test_command="./apps/blur/bin/host/test",
                        root_="/Users/smadadi/Projects/halide_16_for_llvm14/apps/blur/mutation",
                        output_folder="./apps/blur/mutation/reports/jobs/1/output_99"):
    mutants_summary_df = pd.read_csv(mutant_summary_df_path)
    final_report = mutants_summary_df.copy()
    final_report["Duration"] = None
    nth = "2nd"


    # iterate mutants
    for index, row in mutants_summary_df.iterrows():
        start_time = time.time()
        path_ = f"{row['file']}"
        # if the status of mutant is Survived
        if not f"{nth}" in final_report.loc[index, "status"] or not f"aborted" in final_report.loc[index, "status"]:
            previous_status = final_report.loc[index, "status"]
            print(f"working on entry {index}")
            
            # mutate the source code by using the start and end line numbers and column numbers for a file path as well as the mutant

            # copy the source code to a temp file in this directory
            
            os.system(f"cp {path_} .")


            # update the source code with the mutant
            start_line = int(row["start"].split(":")[0])
            end_line = row["end"].split(":")[0]
            start_column = int(row["start"].split(":")[1])
            end_column = int(row["end"].split(":")[1])
            mutant = row["replacement"]
            if str(mutant) == 'nan':
                mutant = ""
            # get the original character
            original = row["mutatorName"].replace("Replaced ", "").replace(f" with {mutant}", "")

            # replace the original character with the mutant at the start line and column
            # if the mutant is a newline character
            if mutant == "\\n":
                os.system(
                    f"sed -i '{start_line} s/.$/\\n/' {row['file'].split('/')[-1]}")
            else:
                # sed 'm s/\(^.\{n-1\}\)x/\1y/' /Users/a/b/c.h
                # command = f"sed -i '{start_line} s/.\\{{{start_column}\\}}/{mutant}/' {row2['file']}"
                # os.system(command)

                with open(path_, 'r') as file_:
                    lines = file_.readlines()

                # Modify the specific character on the specific line
                # Remember that list indexing is zero-based, so we subtract 1 from the line number and character position
                line = lines[start_line - 1]
                modified_line = line[:start_column - 1] + mutant + line[end_column-1:]
                print(f"Modified line is {modified_line}")
                lines[start_line - 1] = modified_line

                # Write the modified content back to the file
                with open(path_, 'w') as file_:
                    file_.writelines(lines)

            compile = True
            compile_result = None
            if compile:
                # compile the source code using subprocess
                print("Compiling...")
                final_report.loc[index, "status"] = "Compiling"
                final_report.to_csv(final_report_df_path, index=False)
                compile_result = subprocess.run(
                    f"cd {root_} && {compile_command}", shell=True, capture_output=True)

            # if the compilation fails
            if compile_result != None and compile_result.returncode != 0:
                # update the final report
                # continue

                # replace the temp file with the original file
                os.system(f"rm {path_}")
                os.system(
                    f"mv {path_.split('/')[-1]} {path_}")

                # update the final report changing the status to Compilation Failed
                final_report.loc[index, "status"] = "Compilation Failed"

                # TODO undo copy and continue



            else:
                print(f"starting test with command: {test_command}")
                final_report.loc[index, "status"] = "Testing"
                final_report.to_csv(final_report_df_path, index=False)
                test_result = TestResult("", "", -1)
                # run the tests using subprocess
                test_result = subprocess.run(
                    test_command, shell=True, capture_output=True)



                # Start the subprocess with stdout and stderr as pipes
                # test_ = "./dist/xcode_macos/Release/universal/build/photoshop/pie_unit_tests/pie_unit_tests/pie_unit_tests"
                # test_1 = "-o /Users/ardi/Projects/ps7_pie_compcore_no_mull/photoshop/adobepie/test/unit_tests/output -i /Users/ardi/Projects/ps7_pie_compcore_no_mull/artifacts/adobepie/test_files -r /Users/ardi/Projects/ps7_pie_compcore_no_mull/artifacts/photoshop_presets -t /Users/ardi/Projects/ps7_pie_compcore_no_mull/dist/git/adobe/photoshop/bravo/source/cooltype/typesupport --logger=HRF,test_suite,stdout --logger=JUNIT,warning,/Users/ardi/Projects/ps7_pie_compcore_no_mull/photoshop/adobepie/test/unit_tests/output/unit_test_report_mac_release.xml --plugins_directory=/Users/ardi/Projects/ps7_pie_compcore_no_mull/dist/xcode_macos/Release/universal/build/photoshop/pie_unit_tests/pie_unit_tests --dump_composite_failure"
                # test_1 = test_1.split()
                # commands = test_ + test_1
                # cmd = ['./dist/xcode_macos/Release/universal/build/photoshop/pie_unit_tests/pie_unit_tests/pie_unit_tests', 
                #                          '-o', '/Users/ardi/Projects/ps7_pie_compcore_no_mull/photoshop/adobepie/test/unit_tests/output',
                #                         '-i', '/Users/ardi/Projects/ps7_pie_compcore_no_mull/artifacts/adobepie/test_files', 
                #                         '-r', '/Users/ardi/Projects/ps7_pie_compcore_no_mull/artifacts/photoshop_presets', 
                #                         '-t', '/Users/ardi/Projects/ps7_pie_compcore_no_mull/dist/git/adobe/photoshop/bravo/source/cooltype/typesupport',
                #                         '--logger=HRF,test_suite,stdout', 
                #                         '--logger=JUNIT,warning,/Users/ardi/Projects/ps7_pie_compcore_no_mull/photoshop/adobepie/test/unit_tests/output/unit_test_report_mac_release.xml',
                #                         '--plugins_directory=/Users/ardi/Projects/ps7_pie_compcore_no_mull/dist/xcode_macos/Release/universal/build/photoshop/pie_unit_tests/pie_unit_tests' 
                #                         '--dump_composite_failure']

                # timeout = 60  # timeout in seconds


                
                # # Use subprocess.run
                # try:
                #     # Create temporary files for stdout and stderr
                #     with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_stdout,\
                #     tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_stderr:

                #         # Start the subprocess using Popen
                #         process = subprocess.Popen(test_command, shell=True, stdout=temp_stdout, stderr=temp_stderr)

                #         time.sleep(timeout)
                #         # communite_result = process.communicate()
                #         # Check if the subprocess is still running
                #         test_result.returncode = process.returncode
                #         if test_result.returncode == None:
                #             # set it to timeout explicitly if it is timed out
                #             test_result.returncode = 124
                #         if process.poll() is None:
                #             # Terminate the process if it's still running after 2 minutes
                #             process.terminate()

                #     # Read from temporary files to get the output generated so far
                #     with open(temp_stdout.name, 'r') as f_stdout, open(temp_stderr.name, 'r') as f_stderr:
                #         str(test_result.stdout) = f_stdout.read()
                #         str(test_result.stderr) = f_stderr.read()

                        

                # except subprocess.TimeoutExpired:
                #     print("Process timed out")
                

                
                # # Optional: Delete temporary files if needed
                # # os.remove(stdout_path)
                # # os.remove(stderr_path)

                print("Tests finished running.")
                

            # if the testing was by checking if the word "Aborted" is present in the output
            if "abort" in str(test_result.stderr):
                # update the final report
                final_report.loc[index, "status"] = f"Testing Aborted - note. Was {previous_status}"

            # check if the testing was successful, did any of the tests kill the mutant (failed) by checking if the word "Failed" is present in the output
            elif "FAILED" in str(test_result.stdout):
                # update the final report
                final_report.loc[index, "status"] = f"Killed on {nth} pass. Was {previous_status}"
                # TODO get killing tests and add them to the report by spliting over "\n[  FAILED  ] "
                split_failed_output = str(test_result.stdout).split("\n[  FAILED  ] ")
                if "listed below" in str(test_result.stdout):
                    split_failed_output = split_failed_output[next((i for i, string in enumerate(split_failed_output) if "listed below:" in string), None)+1:]
                    split_failed_output[-1] = split_failed_output[-1].split('\n\n', 1)[0]
                    split_failed_output = [item.split(',')[0] for item in split_failed_output]
                    split_failed_output = [item.replace("/", "_") for item in split_failed_output]
                else:
                    split_failed_output = str(test_result.stdout).split("\n[  FAILED  ] ")[1:]
                final_report.loc[index, "test"] = str(split_failed_output)
                print(split_failed_output)


            elif "[  PASSED  ]" in  str(test_result.stdout) or "No errors detected" in  str(test_result.stderr) or test_result.returncode == 0:
                # we should never reach here
                # update the final report
                final_report.loc[index, "status"] = f"Survived on {nth} pass. Was {previous_status}"
                
                final_report.loc[index, "test"] = ""


            elif "Error: " in  str(test_result.stdout):
                final_report.loc[index, "test"] = f"{str(test_result.stdout).split('Error: ')[0].split()[-1][1:]} - Error: {str(test_result.stdout).split('Error: ')[1].replace(',', '')}"
                final_report.loc[index, "status"] = f"Killed on {nth} pass. Was {previous_status}"
            
            elif test_result.returncode != 0:
                final_report.loc[index, "status"] = f"Test failed or aborted on {nth} pass with error code: {test_result.returncode}. Was {previous_status}"

            else:
                # we should never reach here
                # update the final report
                final_report.loc[index, "status"] = f"Unknown on {nth} pass. Was {previous_status}"

            # TODO save test output

            # replace the temp file with the original file
            os.system(f"rm {path_}")
            os.system(
                f"mv {path_.split('/')[-1]} {path_}")
            
            print(f"status was: {final_report.loc[index, 'status']}\n")
            
            save_results(test_result, index, output_folder=output_folder)

            final_report.at[index, 'Duration'] = time.time() - start_time
            print(f"Duration was {final_report.at[index, 'Duration']}")
            # TODO save the current version of report
            final_report.to_csv(final_report_df_path, index=False)

        else:
            if "Testing" in final_report.loc[index, "status"]: 
                final_report.loc[index, "status"] = "Crashed in testing"

                # TODO factor info own func
                print("Restoring the orignal file")
                os.system(f"rm {path_}")
                os.system(
                    f"mv {path_.split('/')[-1]} {path_}")
                
            elif "Compiling" in final_report.loc[index, "status"]: 
                final_report.loc[index, "status"] = f"Crashed in compiling on {nth} round"

                # TODO factor info own func
                print("Restoring the orignal file")
                os.system(f"rm {path_}")
                os.system(
                    f"mv {path_.split('/')[-1]} {path_}")
                
            elif "Unknown" in final_report.loc[index, "status"]: 
                final_report.loc[index, "status"] = f"Unknown on {nth} round"

                # TODO factor info own func
                print("Restoring the orignal file")
                os.system(f"rm {path_}")
                os.system(
                    f"cp {path_.split('/')[-1]} {path_}")
            
            print(f"status was for mutant {index}: {final_report.loc[index, 'status']}\n")
                    # replace the temp file with the original file




        # TODO save the final version of report
        final_report.to_csv(final_report_df_path, index=False)


def save_results(test_result, mutant, output_folder = "./mutation/reports/jobs/1/output"):
    # Create an 'output' folder if it doesn't exist
    
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Replace '/' with '_' in test_name to create a valid file name
    file_name = str(mutant) + ".log"

    # Create a full file path to save the file in the 'output' folder
    file_path = os.path.join(output_folder, file_name)

    # Decode the stdout and save it to a file
    with open(file_path, 'w') as file:
        file.write(str(test_result.stdout) + "\n\n" + str(test_result.stderr))

    print(f"Output saved to {file_path}")

if __name__ == "__main__":
    mutate_and_test_all()

  