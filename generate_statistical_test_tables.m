% two tests:
% two-distibution hypothesis test (KS test?)
% KL divergence 
%addpath(genpath('/playpen/cshao/lossyComp'));


% read msd bead1 tracking data in 10 videos 
exp_01_qp_list = [2 4 6 8 10 11 12 13 14 20 30 40 50];
exp_02_qp_list = [41 42 43 44 45 46 47 48 49 50];
exp_03_dilation_list = [6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
exp_04_dilation_list = exp_03_dilation_list;
exp_05_qp_list = exp_01_qp_list;

exp_01_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet1_custom_ffmpeg/test_';
exp_02_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet2_standard_ffmpeg/test_';
exp_03_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet3_lossy_comp_by_dilation/test_';
exp_04_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet4_lossy_comp_by_dilation_noise_back/test_';
ref_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/reference_msds/test_';
exp_05_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet4_5_custom_ffmpeg_noise_back/test_';
exp_01_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet1/test_';
exp_02_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet2/test_';
exp_03_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet3/test_';
exp_04_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet4/test_';
ref_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/reference_msds/test_';
exp_05_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet4_5/test_';

close all

% get average file size
exp_01_avg_file_sizes = compute_file_sizes_for_the_exp(exp_01_dir, exp_01_qp_list, 1:10, 'qp');
exp_02_avg_file_sizes = compute_file_sizes_for_the_exp(exp_02_dir, exp_02_qp_list, 1:10, 'qp');
exp_03_avg_file_sizes = compute_file_sizes_for_the_exp(exp_03_dir, exp_03_dilation_list, 1:10, 'dilate');

exp_01_avg_file_sizes = [2.9377, 2.7286, 2.5144, 2.3255, 2.1645    2.0695    1.9982    1.9397    1.8577    1.4946    0.9047    0.2608    0.0077] * 1.0e7;
exp_02_avg_file_sizes = [3.2210, 1.8080, 0.8109, 0.1010, 0.0793    0.0626    0.0455    0.0317    0.0218    0.0114]* 1.0e7;
exp_03_avg_file_sizes = [1.1429, 1.1429, 1.2968, 1.2968, 1.4847    1.5462    1.7418    1.7418    1.9310    1.9310    2.1467    2.1467    2.3714    2.3714    2.6163    2.6163    2.8493    2.8493    3.0714    3.0714]* 1.0e7;

exp_01_avg_file_sizes = [28688, 26644, 24556, 22708, 21136, 20288, 19508, 18936, 18140, 14592, 8832, 2548, 80];
exp_02_avg_file_sizes = [31468, 17660, 7896, 988, 772, 608, 444, 312, 216, 116];
exp_03_avg_file_sizes = [7120, 7120, 8040, 8040, 9112, 15112, 16980, 16980, 18824, 18824, 20976, 20976, 23164, 23164, 25576, 25576, 27832, 27832, 30016, 30016];

%test_video_size = 569230200;
test_video_size = 554400;
h264_data_ratio = 554400 / 581310;

exp_01_avg_file_compression_ratios = test_video_size ./ exp_01_avg_file_sizes;
exp_02_avg_file_compression_ratios = test_video_size ./ exp_02_avg_file_sizes;
exp_03_avg_file_compression_ratios = test_video_size ./ exp_03_avg_file_sizes;


% read the bead msd data for given size 
% generate a 3D matrix 
% dim1: tau
% dim2: video 1~10 
% dim3: qp 
tau_size = 9;
test_size = 10;
exp_01_msd_data = read_msd_data(exp_01_dir, tau_size, test_size, exp_01_qp_list, 'qp'); 
exp_02_msd_data = read_msd_data(exp_02_dir, tau_size, test_size, exp_02_qp_list, 'qp'); 
exp_03_msd_data = read_msd_data(exp_03_dir, tau_size, test_size, exp_03_dilation_list, 'dilate'); 
exp_04_msd_data = read_msd_data(exp_04_dir, tau_size, test_size, exp_04_dilation_list, 'dilate'); 
exp_05_msd_data = read_msd_data(exp_05_dir, tau_size, test_size, exp_05_qp_list, 'qp'); 

% read the reference (original video) msd data 
orig_exp_msd = []; 
for test = 1:10
    msd_file_name = [ref_dir, format_two_digit_number(test), '_bead1.mat'];
    load(msd_file_name); 
    orig_exp_msd = [orig_exp_msd, msd_data]; 
end

% % plot and fit the distribution of one (qp) 10 video 1 bead msd 
% tau_index = 3;
% qp_index = 2;
% 
% msd_data_for_plot = exp_01_msd_data(tau_index, :, qp_index);
% orig_msd_data_for_plot = orig_exp_msd(tau_index, :);
% 
% figure;
% hold on 
% histdata = [msd_data_for_plot', orig_msd_data_for_plot'];
% hist(histdata);
% hold off 
% 
% % try a hist plot for exp_04 
% tau_index = 3;
% dilation_index = 15; 
% msd_data_for_plot = exp_04_msd_data(tau_index, :, dilation_index);
% 
% figure;
% hold on 
% histdata = [msd_data_for_plot', orig_msd_data_for_plot'];
% size(histdata)
% hist(histdata);
% hold off 

% generate the ks test result table 
% exp_01
tau_index = 3;
[exp_01_ks_test_h, exp_01_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_01_msd_data, tau_index, exp_01_qp_list);

% exp_02
[exp_02_ks_test_h, exp_02_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_02_msd_data, tau_index, exp_02_qp_list);

% exp_03
[exp_03_ks_test_h, exp_03_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_03_msd_data, tau_index, exp_03_dilation_list);

% exp_04 
[exp_04_ks_test_h, exp_04_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_04_msd_data, tau_index, exp_04_dilation_list);

% exp_05
[exp_05_ks_test_h, exp_05_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_05_msd_data, tau_index, exp_05_qp_list);

figure
hold on 
plot(exp_01_avg_file_compression_ratios, exp_01_ks_test_h, '-.k*',exp_02_avg_file_compression_ratios, exp_02_ks_test_h, '--ko', exp_03_avg_file_compression_ratios, exp_03_ks_test_h, ':ks',exp_03_avg_file_compression_ratios, exp_04_ks_test_h, '-kx',exp_01_avg_file_compression_ratios, exp_05_ks_test_h, '->k')
set(gca, 'XScale', 'log')

hold off
figure
hold on 
plot(exp_01_avg_file_compression_ratios, exp_01_ks_test_p, '-.k*', exp_02_avg_file_compression_ratios, exp_02_ks_test_p, '--ko', exp_03_avg_file_compression_ratios, exp_03_ks_test_p, ':ks', exp_03_avg_file_compression_ratios, exp_04_ks_test_p, '-kx', exp_01_avg_file_compression_ratios, exp_05_ks_test_p, '->k', exp_02_avg_file_compression_ratios, ones(size(exp_02_avg_file_compression_ratios))*0.05, '-r')
legend('custom ffmpeg (variation 2)', 'standard ffmpeg', 'dilation (variation 1)', 'dilation with post-processing (variation 1)', 'custom ffmpeg post-processing (variation 2)', 'Location', 'northeast');
set(gca, 'XScale', 'log')

hold off 
xlabel('file size in bytes');
ylabel('KS test p scores between compressed video MSD distributions and original video MSD distributions');



% generate the KL divergence result table 
% exp_01 
exp_01_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_01_msd_data, tau_index, exp_01_qp_list); 

% exp_02 
exp_02_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_02_msd_data, tau_index, exp_02_qp_list);

% exp_03
exp_03_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_03_msd_data, tau_index, exp_03_dilation_list);

% exp_04
exp_04_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_04_msd_data, tau_index, exp_04_dilation_list);
exp_05_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_05_msd_data, tau_index, exp_05_qp_list);

figure
hold on 
plot(exp_01_avg_file_compression_ratios, exp_01_kldiv_test_values, '-.k*',exp_02_avg_file_compression_ratios, exp_02_kldiv_test_values, '--ko', exp_03_avg_file_compression_ratios, exp_03_kldiv_test_values, ':ks',exp_03_avg_file_compression_ratios, exp_04_kldiv_test_values, '-kx',exp_01_avg_file_compression_ratios, exp_05_kldiv_test_values, '->k')
%set(gca, 'YScale', 'log')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

legend('custom ffmpeg (variation 2)', 'standard ffmpeg', 'dilation (variation 1)', 'dilation with post-processing (variation 1)', 'custom ffmpeg post-processing (variation 2)', 'Location', 'northeast');
hold off 
xlabel('file size in bytes');
ylabel('KL divergence values between compressed video MSD distributions and original video MSD distributions');

% plot single comparison plots 
figure
hold on 
plot(exp_02_avg_file_compression_ratios, exp_02_ks_test_p, '--ko', exp_01_avg_file_compression_ratios, exp_05_ks_test_p, '->k', exp_02_avg_file_compression_ratios, ones(size(exp_02_avg_file_compression_ratios))*0.05, '-r' , [18.5322, 18.5322], [0, 1], '-b', [h264_data_ratio, h264_data_ratio], [0,1], '-r')
legend('standard ffmpeg', 'custom ffmpeg post-processing (variation 2)', 'Location', 'northeast');
set(gca, 'XScale', 'log')
hold off 
xlabel('file size in bytes');
ylabel('KS test p scores between compressed video MSD distributions and original video MSD distributions');

figure
hold on 
plot(exp_02_avg_file_compression_ratios, exp_02_kldiv_test_values,'--ko', exp_01_avg_file_compression_ratios, exp_05_kldiv_test_values, '->k')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

legend('standard ffmpeg', 'custom ffmpeg post-processing (variation 2)', 'Location', 'northeast');
hold off 
xlabel('file size in bytes');
ylabel('KL divergence values between compressed video MSD distributions and original video MSD distributions');

