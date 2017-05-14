# to save disk space, go over dilation between 10 to 24

#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]

import os
import sys


def main():
    for dil in range(10, 25):
        input_framename = sys.argv[1]
        threshold = sys.argv[2]
        os.system("mkdir dilate_" + str(dil) + "_debug")
        os.system("/afs/cs.unc.edu/home/cshao/compression_project/dr_run/data_reduction/dr test -i " + input_framename + " " + str(dil) + " 1 1 " + threshold + " dilate_" + str(dil) + "/ dilate_" + str(dil) + "_debug/")


if __name__ == "__main__":
    main()
