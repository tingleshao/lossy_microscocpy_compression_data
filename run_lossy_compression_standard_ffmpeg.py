# to save disk space, go over dilation between 10 to 24

#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]

import os
import sys


def main():
    ffmpeg = "/playpen/cshao/ffmpeg_latest_static_build/ffmpeg-2.4.2-64bit-static/ffmpeg"
    for real_id in range(1, 6):
        input_frame_name = "/playpen2/cshao/paper2_data/lossy_comp_data_set/exp_data/real_050317_400/real_050317_{0}/frame%4d.pgm".format(real_id)
        for crf in range(1, 51):
            os.system(ffmpeg + "-i {0} -c:v libx264 -preset ultrafast -crf {1} crf_{1}.mkv".format(input_frame_name, crf))
            os.system("mkdir real_{0}".format(real_id))
            os.system("mkdir real_{0}/crf_{1}".format(real_id, crf))
            os.system(ffmpeg + " -i crf_{0}.mkv -r 20 real_{1}/crf_{0}/output_%04d.png".format(crf, real_id))


if __name__ == "__main__":
    main()
