# to save disk space, go over dilation between 10 to 24

#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]


import os
import sys


def main():
    for exp in range(1, 6):
        orig_tracking_name = "real_050317_{0}".format(exp)
        save_msd_file_name = "real_050317_{0}_bead1".format(exp)
        bead_id = 1

        os.system("matlab -nodesktop -nosplash -r \"compute_msd_for_compression_exp('{0}', {1}, '{2}'); quit\"".format(orig_tracking_name, bead_id, save_msd_file_name))


if __name__ == "__main__":
    main()
