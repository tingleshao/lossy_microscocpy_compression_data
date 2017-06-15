% two tests:
% two-distibution hypothesis test (KS test?)
% KL divergence 
%addpath(genpath('/playpen/cshao/lossyComp'));


% read msd bead1 tracking data in 10 videos 

exp_01_qp_list = [2 4 6 8 10 20 30 40];
exp_02_qp_list = 1:2:41;
exp_03_dilation_list = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 ];
exp_04_dilation_list = exp_03_dilation_list;
exp_05_qp_list = exp_01_qp_list;

%TODO: does ks test consider NaN as a smaller sample size? 
exp_01_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet9/real_';
exp_02_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet10/real_';
exp_03_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet11/real_';
exp_04_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet12/real_';
ref_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/reference_msds_real_2/real_050317_';
exp_05_dir = '/Users/chongshao/dev/lossy_microscocpy_compression_data/data2/sheet12_5/real_';

close all

% get average file size
%exp_01_avg_file_sizes = compute_file_sizes_for_the_exp(exp_01_dir, exp_01_qp_list, 1:10, 'qp');
%exp_02_avg_file_sizes = compute_file_sizes_for_the_exp(exp_02_dir, exp_02_qp_list, 1:10, 'qp');
% exp_03_avg_file_sizes = compute_file_sizes_for_the_exp(exp_03_dir, exp_03_dilation_list, 1:10, 'dilate');
% 
% exp_01_avg_file_sizes = [8.3816    7.2281    6.6401    6.6006    5.8559    5.3498    4.5603    3.6779    3.1272    0.2008    0.1286] * 1.0e5
% exp_02_avg_file_sizes = [ 2.5140    1.9156    1.6542    1.2102    0.6732    0.2446    0.1092    0.0648    0.0247    0.0129    0.0028    0.0019    0.0018    0.0015    0.0014    0.0013    0.0012    0.0011    0.0011    0.0011    0.0010] * 1.0e7
% exp_03_avg_file_sizes = [2.9218    3.3426    3.3426    3.7941    3.7941    4.2804    4.2804    4.6905    4.6905    5.1514    5.1514    5.6480    5.6480    6.0650    6.0650    6.5667    6.5667    7.0748    7.0748    7.5913    7.5913    8.0814    8.0814    8.5471    8.5471] * 1.0e5
% 
%exp_02_avg_file_sizes = [24560, 18716, 16160, 11816, 6560, 2404, 1060, 628, 232, 116, 24, 20, 16,16,12,12,12,12,12,12,12];
%exp_02_qp_list = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41];
exp_01_avg_file_sizes = [20876, 18888, 16004, 12876, 10256, 220, 48, 16];
exp_02_avg_file_sizes = [53368, 53364, 51512, 42832, 35300, 29060, 22816, 14572, 6628, 1636, 384, 180, 112, 76, 60, 48, 40, 28, 24, 20, 16];
exp_03_avg_file_sizes = [28, 32, 32, 32, 32, 36, 36, 36, 36, 40, 10628, 11696, 11696, 12628, 12628, 13676, 13676, 14728, 14728, 15748, 15748, 16708, 16708, 17604];
%  % test_video_size = 569230200/6;
test_video_size = 131372;
% h264_ratio = test_video_size / 37728;
exp_01_avg_file_compression_ratios = test_video_size ./ exp_01_avg_file_sizes;
exp_02_avg_file_compression_ratios = test_video_size ./ exp_02_avg_file_sizes;
exp_03_avg_file_compression_ratios = test_video_size ./ exp_03_avg_file_sizes;
% 

% read the bead msd data for given size 
% generate a 3D matrix 
% dim1: tau
% dim2: video 1~10 
% dim3: qp 
tau_size = 9;
test_size = 5;
exp_01_msd_data = read_msd_data(exp_01_dir, tau_size, test_size, exp_01_qp_list, 'qp'); 
exp_02_msd_data = read_msd_data(exp_02_dir, tau_size, test_size, exp_02_qp_list, 'crf'); 
exp_03_msd_data = read_msd_data(exp_03_dir, tau_size, test_size, exp_03_dilation_list, 'dilate'); 
exp_04_msd_data = read_msd_data(exp_04_dir, tau_size, test_size, exp_04_dilation_list, 'dilate'); 
exp_05_msd_data = read_msd_data(exp_05_dir, tau_size, test_size, exp_05_qp_list, 'qp'); 

% read the reference (original video) msd data 
orig_exp_msd = []; 
for test = 1:5
    msd_file_name = [ref_dir, num2str(test), '_bead1.mat'];
    load(msd_file_name); 
    orig_exp_msd = [orig_exp_msd, msd_data]; 
end

% % plot and fit the distribution of one (qp) 10 video 1 bead msd 
tau_index = 2;
% qp_index = 2;
% 
exp_01_ratio = [];
exp_05_ratio = [];
msd_data_for_plot = reshape(exp_01_msd_data(tau_index, :, :),5,8)';
msd_data_for_plot5 = reshape(exp_05_msd_data(tau_index, :, :),5,8)';
orig_msd_data_for_plot = orig_exp_msd(tau_index, :);
for i = 1:8
    exp_01_ratio = [exp_01_ratio, mean(msd_data_for_plot(i,:)-orig_msd_data_for_plot)]
    exp_05_ratio = [exp_05_ratio, mean(msd_data_for_plot5(i,:)-orig_msd_data_for_plot)]
end
exp_03_ratio = [];
exp_04_ratio = [];
msd_data_for_plot3 = reshape(exp_03_msd_data(tau_index, :, :),5,24)';
msd_data_for_plot4 = reshape(exp_04_msd_data(tau_index, :, :),5,24)';
orig_msd_data_for_plot = orig_exp_msd(tau_index, :);
for i = 1:24
    exp_03_ratio = [exp_03_ratio, mean(msd_data_for_plot3(i,:)-orig_msd_data_for_plot)];
    exp_04_ratio = [exp_04_ratio, mean(msd_data_for_plot4(i,:)-orig_msd_data_for_plot)];
end

figure
hold on 
exp_03_avg_file_compression_ratios2 = exp_03_avg_file_compression_ratios
exp_03_avg_file_compression_ratios2(1:5) = []
exp_04_ratio(1:5) = []
exp_03_ratio(1:5) = []
exp_01_avg_file_compression_ratios(7:8) = []

exp_01_ratio(7:8) = []
exp_05_ratio(7:8) = []
%exp_01_kldiv_test_values(7:8) = []
%exp_05_kldiv_test_values(7:8) = []

%exp_04_kldiv_test_values(1:5) = []
%exp_03_kldiv_test_values(1:5) = []


%plot(exp_02_avg_file_compression_ratios, exp_02_ks_test_p, '-ro','LineWidth', 3, 'MarkerSize', 8)
plot(exp_03_avg_file_compression_ratios2, abs(exp_03_ratio), '-*b', 'LineWidth', 3, 'MarkerSize', 8)
plot(exp_03_avg_file_compression_ratios2, abs(exp_04_ratio), '-g.', 'LineWidth', 3, 'MarkerSize', 20)
plot(exp_01_avg_file_compression_ratios, abs(exp_01_ratio), '-xc', 'LineWidth', 3, 'MarkerSize', 12)
plot(exp_01_avg_file_compression_ratios, abs(exp_01_ratio), '->m', 'LineWidth', 3, 'MarkerSize', 8)

%axis([10^(0.85), 10^(3.59), 0, 1.5])
% 
h = legend('Analysis-Aware (V1)', 'Analysis-Aware + Post Processing (V1)',  'Analysis-Aware (V2)', 'Analysis-Aware + Post Processing (V2)','Location', 'northeast');
set(h,'FontSize',14);
set(gca, 'XScale', 'log', 'FontSize', 14)
hold off 
xlabel('compression ratio');
ylabel('KS test p score');

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
tau_index = 2;
[exp_01_ks_test_h, exp_01_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_01_msd_data, tau_index, exp_01_qp_list);

% exp_02
[exp_02_ks_test_h, exp_02_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_02_msd_data, tau_index, exp_02_qp_list);

% exp_03
[exp_03_ks_test_h, exp_03_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_03_msd_data, tau_index, exp_03_dilation_list);

% exp_04 
[exp_04_ks_test_h, exp_04_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_04_msd_data, tau_index, exp_04_dilation_list);

% exp_05
[exp_05_ks_test_h, exp_05_ks_test_p] = compute_ks_test_row(orig_exp_msd, exp_05_msd_data, tau_index, exp_05_qp_list);

%figure
%hold on 
%plot(exp_01_avg_file_compression_ratios, exp_01_ks_test_h, '-.k*',exp_02_avg_file_compression_ratios, exp_02_ks_test_h, '--ko', exp_03_avg_file_compression_ratios, exp_03_ks_test_h, ':ks',exp_03_avg_file_compression_ratios, exp_04_ks_test_h, '-kx',exp_01_avg_file_compression_ratios, exp_05_ks_test_h, '->k')
%set(gca, 'XScale', 'log')
% 
%hold off

% figure
% hold on 
% plot(exp_01_avg_file_compression_ratios, exp_01_ks_test_p, '-.k*',exp_02_avg_file_compression_ratios, exp_02_ks_test_p, '--ko', exp_03_avg_file_compression_ratios, exp_03_ks_test_p, ':ks',exp_03_avg_file_compression_ratios, exp_04_ks_test_p, '-kx',exp_01_avg_file_compression_ratios, exp_05_ks_test_p, '->k', exp_02_avg_file_compression_ratios, ones(size(exp_02_avg_file_compression_ratios))*0.05, '-r')
% set(gca, 'XScale', 'log')
% 
% legend('custom ffmpeg (variation 2)', 'standard ffmpeg', 'dilation (variation 1)', 'dilation with post-processing (variation 1)', 'custom ffmpeg post-processing (variation 2)', 'Location', 'southwest');
% hold off 
% xlabel('file size in bytes');
% ylabel('KS test p scores between compressed video MSD distributions and original video MSD distributions');



% generate the KL divergence result table 
% exp_01 
tau_index = 2
 exp_01_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_01_msd_data, tau_index, exp_01_qp_list); 
% 
% % exp_02 
 exp_02_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_02_msd_data, tau_index, exp_02_qp_list);
% 
% % exp_03
 exp_03_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_03_msd_data, tau_index, exp_03_dilation_list);
% 
% % exp_04
 exp_04_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_04_msd_data, tau_index, exp_04_dilation_list);
 exp_05_kldiv_test_values = compute_kldiv_test_row(orig_exp_msd, exp_05_msd_data, tau_index, exp_05_qp_list);
% 
% figure
% hold on 
% plot(exp_01_avg_file_compression_ratios,exp_01_kldiv_test_values, '-.k*',exp_02_avg_file_compression_ratios,exp_02_kldiv_test_values, '--ko', exp_03_avg_file_compression_ratios, exp_03_kldiv_test_values, ':ks',exp_03_avg_file_compression_ratios, exp_04_kldiv_test_values, '-kx',exp_01_avg_file_compression_ratios, exp_05_kldiv_test_values, '->k')
% 
%plot(exp_04_kldiv_test_values, '-kx')

% set(gca, 'YScale', 'log')
% set(gca, 'XScale', 'log')
% 
% legend('custom ffmpeg (variation 2)', 'standard ffmpeg', 'dilation (variation 1)', 'dilation with post-processing (variation 1)', 'custom ffmpeg post-processing (variation 2)', 'Location', 'northwest');
% hold off 
% xlabel('file size in bytes');
% ylabel('KL divergence values between compressed video MSD distributions and original video MSD distributions');
% 

% plot single comparison plots 
figure
hold on 
%plot(exp_04_ks_test_h, '-kx')


exp_04_ks_test_p(1:5) = []
exp_03_ks_test_p(1:5) = []
exp_03_ks_test_p = [0.61,exp_03_ks_test_p]
exp_02_ks_test_p(16:21) = []
exp_02_avg_file_compression_ratios(16:21) = []
exp_02_kldiv_test_values(16:21) = []
exp_03_avg_file_compression_ratios3 = exp_03_avg_file_compression_ratios
exp_03_avg_file_compression_ratios3(1:5) = []
exp_03_avg_file_compression_ratios3 = [ 10^(3.59), exp_03_avg_file_compression_ratios3]
%exp_01_avg_file_compression_ratios(7:8) = []
exp_01_ks_test_p(7:8) = []
exp_05_ks_test_p(7:8) = []
exp_01_kldiv_test_values(7:8) = []
exp_05_kldiv_test_values(7:8) = []

exp_04_kldiv_test_values(1:5) = []
exp_03_kldiv_test_values(1:5) = []


plot(exp_02_avg_file_compression_ratios, exp_02_ks_test_p, '-o', 'Color', [124/255, 70/255, 34/255],'LineWidth', 3, 'MarkerSize', 8)
plot(exp_03_avg_file_compression_ratios3, exp_03_ks_test_p, '-*', 'Color', [44/255, 52/255, 162/255],'LineWidth', 3, 'MarkerSize', 8)
plot(exp_03_avg_file_compression_ratios2, exp_04_ks_test_p,  '-.', 'Color', [44/255, 139/255, 162/255], 'LineWidth', 3, 'MarkerSize', 20)
plot(exp_01_avg_file_compression_ratios, exp_01_ks_test_p, '-x', 'Color', [34/255, 124/255, 40/255], 'LineWidth', 3, 'MarkerSize', 12)
plot(exp_01_avg_file_compression_ratios, exp_05_ks_test_p, '->', 'Color', [53/255, 201/255, 16/255],'LineWidth', 3, 'MarkerSize', 8)

% %plot(exp_02_avg_file_compression_ratios, ones(size(exp_02_avg_file_compression_ratios))*0.05, '-k' ,'LineWidth', 3, 'MarkerSize', 8)
% 
% plot(5:100:10000, ones([100,1])*0.05, '-k' ,'LineWidth', 3, 'MarkerSize', 8)
% plot(5:100:10000, ones([100,1])*0.1, '-k' ,'LineWidth', 3, 'MarkerSize', 8)
% plot(5:100:10000, ones([100,1])*0.5, '-k' ,'LineWidth', 3, 'MarkerSize', 8)
plot(5:100:10000, ones([100,1])*0.9, '-k' ,'LineWidth', 3, 'MarkerSize', 8)
% 
% plot([45,45], [0, 1.5], '-k', 'LineWidth', 3, 'MarkerSize', 8) 

 plot([131372/13612, 131372/13612], [0, 1.5], '-k', 'LineWidth', 3, 'MarkerSize', 8) 
% %plot([h264_ratio, h264_ratio], [0,1], '-k' ,'LineWidth', 3, 'MarkerSize', 8)
% %plot([6000, 6000], [0, 1], '-k','LineWidth', 3, 'MarkerSize', 8)
% %plot([520, 520], [0, 1], '-k','LineWidth', 3, 'MarkerSize', 8)
% 
axis([10^(0.85), 10^(3.59), 0, 1.5])
% 
h = legend('H.264', 'Analysis-Aware (V1)', 'Analysis-Aware + Post Processing (V1)',  'Analysis-Aware (V2)', 'Analysis-Aware + Post Processing (V2)','Location', 'northeast');
set(h,'FontSize',14);
set(gca, 'XScale', 'log', 'FontSize', 14)
hold off 
xlabel('compression ratio');
ylabel('KS test p score');


figure
hold on 
plot(exp_02_avg_file_compression_ratios, exp_02_kldiv_test_values, '-o', 'Color', [124/255, 70/255, 34/255], 'LineWidth', 3, 'MarkerSize', 8)
plot(exp_03_avg_file_compression_ratios2, exp_03_kldiv_test_values, '-*', 'Color', [44/255, 52/255, 162/255], 'LineWidth', 3, 'MarkerSize', 8)
plot(exp_03_avg_file_compression_ratios2, exp_04_kldiv_test_values, '-.', 'Color', [44/255, 139/255, 162/255], 'LineWidth', 3, 'MarkerSize', 20)
plot(exp_01_avg_file_compression_ratios, exp_01_kldiv_test_values, '-x', 'Color', [34/255, 124/255, 40/255], 'LineWidth', 3, 'MarkerSize', 12)
plot(exp_01_avg_file_compression_ratios, exp_05_kldiv_test_values, '->', 'Color', [53/255, 201/255, 16/255], 'LineWidth', 3, 'MarkerSize', 8)

 plot([131372/13612, 131372/13612], [10e-8, 10e1], '-k', 'LineWidth', 3, 'MarkerSize', 8) 
axis([10^(0.85), 10^(3.59), 10e-8, 10e1])
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log', 'FontSize', 14)
h = legend('H.264', 'Analysis-Aware (V1)', 'Analysis-Aware + Post Processing (V1)',  'Analysis-Aware (V2)', 'Analysis-Aware + Post Processing (V2)','Location', 'northeast');
set(h,'FontSize',14);
hold off 
xlabel('compression ratio');
ylabel('KL divergence value');

