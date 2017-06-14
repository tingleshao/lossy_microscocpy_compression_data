# to save disk space, go over dilation between 10 to 24

#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]


import os
import sys


def main():
    for exp_id in range(1,6):
        for dil in range(1,25):
            orig_tracking_name = "real_{0}/dilate_{1}".format(exp_id, dil)
            save_msd_file_name = "real_{0}/dilate_{1}_bead_1".format(exp_id, dil)
            bead_id = 1
            os.system("matlab -nodesktop -nosplash -r \"compute_msd_for_compression_exp('{0}', {1}, '{2}'); quit();\"".format(orig_tracking_name, bead_id, save_msd_file_name))


if __name__ == "__main__":
    main()
