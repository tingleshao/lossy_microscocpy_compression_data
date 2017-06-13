# to save disk space, go over dilation between 10 to 24

#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]

import os
import sys
from scipy.misc import imread
import math
import numpy as np

# generate bianry code.m\
#

# code binary map.m

# assume this one correctly generates code
def generate_binary_code(img_name):
    # take a binary image, generate the binary code for that
    binary_img = imread(img_name)
    img_height = binary_img.shape[0]
    img_width = binary_img.shape[1]
    code_height = math.ceil(img_height / 16)
    code_width = math.ceil(img_width / 16)
    code = np.zeros((int(code_height)+1, int(code_width)+1), dtype=np.int)
#    print(binary_img.shape)
    for i in range(1,img_height+1):
        for j in range(1,img_width+1):
            code_y = math.ceil(float(i) / 16)
            code_x = math.ceil(float(j) / 16)
    #        print(i-1,j-1,code_y-1,code_x-1)
            if (binary_img[i-1][j-1] != 0):
                code[int(code_y-1)][int(code_x-1)] = 1
    code2 = []
    #print(code[0])
    #print(code[1])
    #print(code[2])
    #print(code[3])
    for c in code:
        for j in c:
            code2.append(j)
    #print code2
    return code2

# assume all binary images are there
real2_1_bin_dir = "/playpen2/cshao/paper2_data/lossy_comp_data_set/comp_data/real_050317_400_lossless/real_050317_400_1_comp_debug/bin_diff_img.pgm";
real2_2_bin_dir = "/playpen2/cshao/paper2_data/lossy_comp_data_set/comp_data/real_050317_400_lossless/real_050317_400_2_comp_debug/bin_diff_img.pgm";
real2_3_bin_dir = "/playpen2/cshao/paper2_data/lossy_comp_data_set/comp_data/real_050317_400_lossless/real_050317_400_3_comp_debug/bin_diff_img.pgm";
real2_4_bin_dir = "/playpen2/cshao/paper2_data/lossy_comp_data_set/comp_data/real_050317_400_lossless/real_050317_400_4_comp_debug/bin_diff_img.pgm";
real2_5_bin_dir = "/playpen2/cshao/paper2_data/lossy_comp_data_set/comp_data/real_050317_400_lossless/real_050317_400_5_comp_debug/bin_diff_img.pgm";
dirs = [real2_1_bin_dir, real2_2_bin_dir, real2_3_bin_dir,real2_4_bin_dir,real2_5_bin_dir]

qp_list = [1,2,3,4,5,6,7,8,9,10,20,30,40,50]
def run_compression():
    for exp_id in range(1,6):
        code = generate_binary_code(dirs[exp_id-1])
        # save code into file
        # change the code of x264
    #    with open("/playpen/cshao/ffmpeg-playpen/x264/encoder/analyse.c") as code:

    #    with open("/playpen2/custom_ffmpeg_data/bincode.txt", 'w') as bincode_file:
    #        bincode_file.write(" ".join([str(i) for i in code]))

        for qp in qp_list:
            # make_c_code
            ccode = make_c_code(code, qp)
            with open("/playpen/cshao/ffmpeg-playpen/x264/encoder/analyse.c", 'w') as ccode_file:
                ccode_file.write(ccode)
            cwd = os.getcwd()
            # change the current working path
            os.chdir("/playpen/cshao/ffmpeg-playpen/x264/")
            os.system("make")
            os.system("sudo make install")
            os.chdir(cwd)
            # save qp into file
    #        with open("/playpen2/custom_ffmpeg_data/fqp.txt", 'w') as qp_file:
    #            qp_file.write(str(qp))
            image_dir = "/playpen2/cshao/paper2_data/lossy_comp_data_set/exp_data/real_050317_400_start_from_0/real_050317_{0}/frame%4d.pgm".format(exp_id)
            output_dir = "/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet9_custom_ffmpeg_real2/real_{0}/qp_{1}.mkv".format(exp_id, qp)
            cmd = "/playpen/cshao/ffmpeg-playpen/custom_build/ffmpeg -i {0} -c:a copy -c:v libx264 -g 1800 {1}".format(image_dir, output_dir)
            os.system(cmd)

def make_c_code(code, fqp):
    with open("analyse_c.txt", 'r') as part1_file:
        part1 = part1_file.read()
    with open("analyse_c_3.txt", 'r') as part3_file:
        part3 = part3_file.read()
    part2 = """
    int bin[1271] = {{{0}}};

    if (bin[h->mb.i_mb_xy] == 1) {{
        h->mb.i_qp = {1};
    }}
    """.format(','.join([str(i) for i in code]), fqp)
    ccode = part1+part2+part3
    return ccode

if __name__ == "__main__":
    run_compression()
    #print(generate_binary_code("/Users/chongshao/dev/bin_diff_img.pgm"))
