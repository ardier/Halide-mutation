# compiles the source code and exports the output to a log file.

import os
import pandas as pd
import subprocess
import sys


def compile(compile_command, log_file_path="./mutation/reports/compilation.log"):
    # print in bold and teal that the compilation is starting
    print("\033[1;36;40mCompilation Starting...\033[0m")

    # compile the source code using subprocess
    compile_result = subprocess.run(
        compile_command, shell=True, capture_output=True)

    # if the compilation fails
    if compile_result.returncode != 0:
       # print in bold and red that the compilation failed
        print("\033[1;31;40mCompilation Failed\033[0m")

        # print the error message
        print(compile_result.stderr.decode("utf-8"))

    else:
        # print in bold and green that the compilation was successful
        print("\033[1;32;40mCompilation Successful\033[0m")


def store_out_put(output_log_path):
    pass
    # TODO


if __name__ == "__main__":
    compile_command = sys.argv[1]
    compile(compile_command)
