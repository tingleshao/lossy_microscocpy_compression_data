
#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]

import os
import sys


def main():
    for dil in range(12, 25):
        # make tracking folders
        os.system("mkdir dilate_" + str(dil) + "_tracking")
        # copy frames to the tracking folder
        os.system("cp dilate_" + str(dil) + "/compressed_0000.pgm dilate_" + str(dil) + "_tracking")
        os.system("cp dilate_" + str(dil) + "/compressed_0001.pgm dilate_" + str(dil) + "_tracking")
        os.system("cp dilate_" + str(dil) + "/compressed_0002.pgm dilate_" + str(dil) + "_tracking")
        # run tracking
        os.system("/playpen2/cshao/paper2_code/lossy_comp/tracking_scripts/Run_VST4 dilate_" + str(dil) + "_tracking/compressed_0000.pgm dilate_" + str(dil) + "/compressed_0000.pgm dilate_" + str(dil))


if __name__ == "__main__":
    main()
