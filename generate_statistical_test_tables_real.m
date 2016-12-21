% two tests:
% two-distibution hypothesis test (KS test?)
% KL divergence 
%addpath(genpath('/playpen/cshao/lossyComp'));


% read msd bead1 tracking data in 10 videos 

exp_01_qp_list = [1 2 3 4 5 6 7 8 9 20 30];
exp_02_qp_list = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41];
exp_03_dilation_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
exp_04_dilation_list = exp_03_dilation_list;
exp_05_qp_list = exp_01_qp_list;


exp_01_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet5_custom_ffmpeg_real/real_';
exp_02_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet6_standard_ffmpeg_real/real_';
exp_03_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet7_lossy_comp_by_dilation_real/real_';
exp_04_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet8_lossy_comp_by_dilation_noise_back_real/real_';
exp_05_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet8_5_custom_ffmpeg_noise_back_real/real_';
ref_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/reference_msds_real/real_';


% get average file size
exp_01_avg_file_sizes = compute_file_sizes_for_the_exp(exp_01_dir, exp_01_qp_list, 1:10, 'qp');
exp_02_avg_file_sizes = compute_file_sizes_for_the_exp(exp_02_dir, exp_02_qp_list, 1:10, 'qp');
exp_03_avg_file_sizes = compute_file_sizes_for_the_exp(exp_03_dir, exp_03_dilation_list, 1:10, 'dilate');

test_video_size = 569230200;

exp_01_avg_file_compression_ratios = log(test_video_size ./ exp_01_avg_file_sizes);
exp_02_avg_file_compression_ratios = log(test_video_size ./ exp_02_avg_file_sizes);
exp_03_avg_file_compression_ratios = log(test_video_size ./ exp_03_avg_file_sizes);


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
hold off
figure
hold on 
plot(exp_01_avg_file_compression_ratios, log(exp_01_ks_test_p), '-.k*',exp_02_avg_file_compression_ratios, log(exp_02_ks_test_p), '--ko', exp_03_avg_file_compression_ratios, log(exp_03_ks_test_p), ':ks',exp_03_avg_file_compression_ratios, log(exp_04_ks_test_p), '-kx',exp_01_avg_file_compression_ratios, log(exp_05_ks_test_p), '->k', exp_02_avg_file_compression_ratios, log(ones(size(exp_02_avg_file_compression_ratios))*0.05), '-r')
legend('custom ffmpeg (variation 2)', 'standard ffmpeg', 'dilation (variation 1)', 'dilation with post-processing (variation 1)', 'custom ffmpeg post-processing (variation 2)', 'Location', 'southwest');
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
plot(exp_01_avg_file_compression_ratios,exp_01_kldiv_test_values, '-.k*',exp_02_avg_file_compression_ratios,exp_02_kldiv_test_values, '--ko', exp_03_avg_file_compression_ratios, exp_03_kldiv_test_values, ':ks',exp_03_avg_file_compression_ratios, exp_04_kldiv_test_values, '-kx',exp_01_avg_file_compression_ratios, exp_05_kldiv_test_values, '->k')
legend('custom ffmpeg (variation 2)', 'standard ffmpeg', 'dilation (variation 1)', 'dilation with post-processing (variation 1)', 'custom ffmpeg post-processing (variation 2)', 'Location', 'northwest');
hold off 
xlabel('file size in bytes');
ylabel('KL divergence values between compressed video MSD distributions and original video MSD distributions');


