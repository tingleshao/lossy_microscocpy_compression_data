
#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]

import os
import sys


def main():
    for exp_id in range(1, 6):
        for dil in range(1, 25):
            # make tracking folders
            os.system("mkdir real_{0}/dilate_{1}_tracking".format(exp_id, dil))
            # copy frames to the tracking folder
            os.system("cp real_{0}/dilate_{1}/compressed_0000.png real_{0}/dilate_{1}_tracking/".format(exp_id, dil))
            os.system("cp real_{0}/dilate_{1}/compressed_0001.png real_{0}/dilate_{1}_tracking/".format(exp_id, dil))
            os.system("cp real_{0}/dilate_{1}/compressed_0002.png real_{0}/dilate_{1}_tracking/".format(exp_id, dil))
            # run tracking
            os.system("/playpen2/cshao/paper2_code/lossy_comp/tracking_scripts/Run_VST4 real_{0}/dilate_{1}_tracking/compressed_0000.png real_{0}/dilate_{1}/compressed_0000.png real_{0}/dilate_{1}".format(exp_id, dil))


if __name__ == "__main__":
    main()
