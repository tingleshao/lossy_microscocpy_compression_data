% what to plot:
% under a fixed tau, the compression size vs MSD ratio ( the msd values for
% the same tau, ratio between the compressed version and the original
% version)
%
% exps description: 
% exp_01: custom_ffmpeg
% exp_02: standard_ffmpeg
% exp_03: lossy_comp_by_dilation
% exp_04: lossy_comp_by_dilation_noise_back


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

% read the bead msd datas and generate the result
[exp_01_msd_means, exp_01_msd_stdevs] = compute_mean_stdev_over_tests_for_different_params(exp_01_qp_list, 1:10, exp_01_dir, 'qp');
[exp_02_msd_means, exp_02_msd_stdevs] = compute_mean_stdev_over_tests_for_different_params(exp_02_qp_list, 1:10, exp_02_dir, 'qp');
[exp_03_msd_means, exp_03_msd_stdevs] = compute_mean_stdev_over_tests_for_different_params(exp_03_dilation_list, 1:10, exp_03_dir, 'dilate');
[exp_04_msd_means, exp_04_msd_stdevs] = compute_mean_stdev_over_tests_for_different_params(exp_04_dilation_list, 1:10, exp_04_dir, 'dilate');
[exp_05_msd_means, exp_05_msd_stdevs] = compute_mean_stdev_over_tests_for_different_params(exp_05_qp_list, 1:10, exp_05_dir, 'qp');


% read the reference (original video) msd data 
exp_msd = []; 
for test = 1:10
    msd_file_name = [ref_dir, format_two_digit_number(test), '_bead1.mat'];
    load(msd_file_name); 
    exp_msd = [exp_msd, msd_data]; 
end
exp_ref_msd_mean = mean(exp_msd, 2);

% set tau index
tau_index = 2;

% get average file size
exp_01_avg_file_sizes = compute_file_sizes_for_the_exp(exp_01_dir, exp_01_qp_list, 1:10, 'qp');
exp_02_avg_file_sizes = compute_file_sizes_for_the_exp(exp_02_dir, exp_02_qp_list, 1:10, 'qp');
exp_03_avg_file_sizes = compute_file_sizes_for_the_exp(exp_03_dir, exp_03_dilation_list, 1:10, 'dilate');

test_video_size = 569230200;

exp_01_avg_file_compression_ratios = log(test_video_size ./ exp_01_avg_file_sizes);
exp_02_avg_file_compression_ratios = log(test_video_size ./ exp_02_avg_file_sizes);
exp_03_avg_file_compression_ratios = log(test_video_size ./ exp_03_avg_file_sizes);


% normalize the values. exp04 is noise added back, same size as exp_03
exp_ref_msd_mean_divider_01 = repmat(exp_ref_msd_mean,[1, length(exp_01_qp_list)]);
exp_ref_msd_mean_divider_02 = repmat(exp_ref_msd_mean,[1, length(exp_02_qp_list)]);
exp_ref_msd_mean_divider_03 = repmat(exp_ref_msd_mean,[1, length(exp_03_dilation_list)]);
exp_ref_msd_mean_divider_04 = repmat(exp_ref_msd_mean,[1, length(exp_04_dilation_list)]);
exp_ref_msd_mean_divider_05 = repmat(exp_ref_msd_mean,[1, length(exp_05_qp_list)]);


exp_01_msd_means = exp_01_msd_means ./ exp_ref_msd_mean_divider_01;
exp_02_msd_means = exp_02_msd_means ./ exp_ref_msd_mean_divider_02;
exp_03_msd_means = exp_03_msd_means ./ exp_ref_msd_mean_divider_03;
exp_04_msd_means = exp_04_msd_means ./ exp_ref_msd_mean_divider_04;
exp_05_msd_means = exp_05_msd_means ./ exp_ref_msd_mean_divider_05;

exp_01_msd_stdevs = exp_01_msd_stdevs ./ exp_ref_msd_mean_divider_01; 
exp_02_msd_stdevs = exp_02_msd_stdevs ./ exp_ref_msd_mean_divider_02; 
exp_03_msd_stdevs = exp_03_msd_stdevs ./ exp_ref_msd_mean_divider_03; 
exp_04_msd_stdevs = exp_04_msd_stdevs ./ exp_ref_msd_mean_divider_04; 
exp_05_msd_stdevs = exp_05_msd_stdevs ./ exp_ref_msd_mean_divider_05; 

% select the data
chosen_exp_01_msd_mean = exp_01_msd_means(tau_index, :);
chosen_exp_02_msd_mean = exp_02_msd_means(tau_index, :);
chosen_exp_03_msd_mean = exp_03_msd_means(tau_index, :);
chosen_exp_04_msd_mean = exp_04_msd_means(tau_index, :);
chosen_exp_05_msd_mean = exp_05_msd_means(tau_index, :);


chosen_exp_01_msd_stdev = exp_01_msd_stdevs(tau_index, :); 
chosen_exp_02_msd_stdev = exp_02_msd_stdevs(tau_index, :); 
chosen_exp_03_msd_stdev = exp_03_msd_stdevs(tau_index, :); 
chosen_exp_04_msd_stdev = exp_04_msd_stdevs(tau_index, :); 
chosen_exp_05_msd_stdev = exp_05_msd_stdevs(tau_index, :); 


size(exp_03_avg_file_sizes)
size(chosen_exp_04_msd_mean)

figure
hold on 
plot(exp_01_avg_file_compression_ratios, chosen_exp_01_msd_mean, '-.k*', exp_02_avg_file_compression_ratios, chosen_exp_02_msd_mean, '--ko',exp_03_avg_file_compression_ratios, chosen_exp_03_msd_mean, ':ks',exp_03_avg_file_compression_ratios, chosen_exp_04_msd_mean, '-kx',exp_01_avg_file_compression_ratios, chosen_exp_05_msd_mean, '->k', exp_02_avg_file_compression_ratios, ones(size(exp_02_avg_file_sizes)), 'k-')
legend('custom ffmpeg (variation 2)', 'standard ffmpeg', 'dilation (variation 1)', 'dilation with post-processing (variation 1)', 'custom ffmpeg post-processing (variation 2)', 'Location', 'northeast');
hold off 
xlabel('file size in bytes');
ylabel('MSDs for fixed \tau scaled by the values on original video');

% TODO: make another plot with two comparisons and the analysis-aware
% result



% TODO: make another plot (same) on real video.
