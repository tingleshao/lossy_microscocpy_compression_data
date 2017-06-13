# to save disk space, go over dilation between 10 to 24

#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]

import os
import sys
from scipy.misc import imread

import numpy as np
# generate bianry code.m
folder = 'real_10';
input_img = imread([folder, '/bin_diff_img.pgm']);

code = code_binary_map(input_img)
csvwrite([folder, '/', 'binary_code.csv'], code);
#

# code binary map.m
function [ code ] = code_binary_map( input_binary_map )
% takes the binary map, output a binary map code
% the code is a 2D array so that we don't need to worry about the reading
% order in x264
img_size = size(input_binary_map);
img_height = img_size(1)
img_width = img_size(2)
code_height = ceil(img_height / 16);
code_width = ceil(img_width / 16);
code = uint8(zeros(code_height, code_width));

for y = 1:img_height
    for x = 1:img_width
        code_y = ceil(y / 16);
        code_x = ceil(x / 16);
        if (input_binary_map(y,x) ~= 0)
            code(code_y,code_x) = 1;
        end
    end
end
end


# assume this one correctly generates code
def generate_binary_code(img_name):
    # take a binary image, generate the binary code for that
    binary_img = imread(img_name)
    img_height = binage_img.shape()[0]
    img_width = binary_img.shape()[1]
    code_height = math.ceil(img_height / 16)s
    code_width = math.ceil(img_width / 16)
    code = np.zeros(code_height, code_width)
    for i in range(img_height):
        for j in range(img_width):
            code_y = ceil(i / 16)
            code_x = ceil(j / 16)
            if (img_name[i,j] != 0)
            code(code_y, code_x) = 1;
    return code

# assume all binary images are there
real2_1_bin_dir = "";
real2_2_bin_dir = "";
real2_3_bin_dir = "";
real2_4_bin_dir = "";
real2_5_bin_dir = "";
dirs = [real2_1_bin_dir, real2_2_bin_dir, real2_3_bin_dir,real2_4_bin_dir,real2_5_bin_dir]

qp_list = [1,2,3,4,5,6,7,8,9,10,20,30,40,50]
def run_compression():
    for bin_dir in dirs:
        code = generate_binary_code(bin_dir)
        # save code into file
        with open("/playpen2/custom_ffmpeg_data/bincode.txt", 'w') as bincode_file:
            bincode_file.write(" ".join(code))
        for qp in qp_list:
            # save qp into file
            with open("/playpen2/custom_ffmpeg_data/fqp.txt", 'w') as qp_file:
             cmd = "/playpen/cshao/ffmpeg-playpen/custom_build/ffmpeg -i /playpen2/cshao/paper2_data/lossy_comp_data_set/exp_data/test_011015/test_011015_$1/nframe%4d.png -c:a copy -c:v libx264 -g 1800 test_$index/qp_$2.mkv"
            os.system(cmd)


if __name__ == "__main__":
    run_compression()
