#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]

import os
import sys

def main():
    input_framename = sys.argv[1]
    output_dir = sys.argv[2]
    output_debug_dir = sys.argv[3]
    threshold = sys.argv[4]
    os.system("/afs/cs.unc.edu/home/cshao/compression_project/dr_run/data_reduction/dr test -i " + input_framename + " 25 1 1 " + threshold + " " + output_dir + " " + output_debug_dir)


if __name__ == "__main__":
    main()
