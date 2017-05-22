# to save disk space, go over dilation between 10 to 24

#./dr [save_file] -i [image_file] [dilate_diameter] [threshold_for_correlation_in_percentage] [sliding_window_size] [hard_coded_threshold] [save_file_dir] [debugging_image_dir]


import os
import sys


def main():
    for dil in range(10, 25):
        orig_tracking_name = "dilate_{0}".format(dil)
        save_msd_file_name = "dilate_{0}_bead1".format(dil)
        bead_id = 1

        os.system("matlab -nodesktop -nosplash -r \"compute_msd_for_compression_exp('{0}', {1}, '{2}'); quit\"".format(orig_tracking_name, bead_id, save_msd_file_name))


if __name__ == "__main__":
    main()


"""
% compute msd
orig_tracking_name = ['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '_tracking'];
save_msd_file_name = ['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '_bead1'];
bead_id = 1;
compute_msd_for_compression_exp(orig_tracking_name, bead_id, save_msd_file_name);


function [ msd_data, tau ] = compute_msd_for_compression_exp( tracking_file_name, bead_id, save_msd_file_name )
% this function reads the tracking data from input tracking_file_name:

addpath(genpath('/playpen/cshao/3dmfs/3dfmAnalysis/'));
addpath(genpath('/playpen/cshao/paper2_lossy_compression_code/'));
addpath(genpath('/playpen/cshao/paper2_lossy_compression_data/'));

% read the tracking data from .csv
msd_data = [];
window = [1 2 5 10 20 50 100 200 1000]; % default

filemask = [tracking_file_name, '.csv'];
csvx = csvread(filemask,1,0);
% compute the MSD
t = 0:60/807:60-(60/807);
x1 = csvx(csvx(:,2)==bead_id,3);
y1 = csvx(csvx(:,2)==bead_id,4);
data = [x1 y1]; % retrieve one bead data from many
[tau,msd_data_n,count] = msd(t, data, window);
msd_data = [msd_data, msd_data_n];

save(save_msd_file_name, 'msd_data','tau');
end
"""
