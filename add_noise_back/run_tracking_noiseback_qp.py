
#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]

import os
import sys

#qp_list = [1,2,3,4,5,6,7,8,9,10,20,30,40,50]

qp_list = [2, 4, 6, 8, 10, 20, 30, 40, 50];

def main():
    for exp_id in range(1, 6):
        for qp in qp_list:
            # make tracking folders
            os.system("mkdir real_{0}/qp_{1}_tracking".format(exp_id, dil))
            # copy frames to the tracking folder
            os.system("cp real_{0}/qp_{1}/compressed_0001.png real_{0}/qp_{1}_tracking/".format(exp_id, qp))
            os.system("cp real_{0}/qp_{1}/compressed_0002.png real_{0}/qp_{1}_tracking/".format(exp_id, qp))
            os.system("cp real_{0}/qp_{1}/compressed_0003.png real_{0}/qp_{1}_tracking/".format(exp_id, qp))
            # run tracking
            os.system("/playpen2/cshao/paper2_code/lossy_comp/tracking_scripts/Run_VST4 real_{0}/qp_{1}_tracking/compressed_0001.png real_{0}/qp_{1}/compressed_0001.png real_{0}/qp_{1}".format(exp_id, qp))


if __name__ == "__main__":
    main()
