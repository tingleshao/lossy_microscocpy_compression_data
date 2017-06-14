# to save disk space, go over dilation between 10 to 24

#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]


import os
import sys


qp_list = [1,2,3,4,5,6,7,8,9,10,20,30,40,50]


def main():
    for exp_id in range(1,6):
        for qp in qp_list:
            orig_tracking_name = "real_{0}/qp_{1}_".format(exp_id, qp)
            save_msd_file_name = "real_{0}/qp_{1}_bead_1".format(exp_id, qp)
            bead_id = 1
            os.system("matlab -nodesktop -nosplash -r \"compute_msd_for_compression_exp('{0}', {1}, '{2}'); quit();\"".format(orig_tracking_name, bead_id, save_msd_file_name))


if __name__ == "__main__":
    main()
