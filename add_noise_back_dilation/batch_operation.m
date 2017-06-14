addpath(genpath('/playpen/cshao/lossyComp/'));
addpath(genpath('/playpen/cshao/3dmfs/3dfmAnalysis/specific/modeling/'));
addpath(genpath('/playpen/cshao/3dmfs/3dfmAnalysis/'));

comp_data_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet11_lossy_comp_by_dilation_real2';
noise_back_data_dir = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet12_custom_ffmpeg_noise_back_real2';
exp_data_dir = '/playpen2/cshao/paper2_data/lossy_comp_data_set/exp_data/real_050317_400_start_from_0/real_050317_';

num_of_frames = 421;

for real = 2:5
    save_exp_data_test_dir = [noise_back_data_dir,'/real_', num2str(real),'/'];
    if  ~exist(save_exp_data_test_dir,'dir')
        disp(['mkdir ', save_exp_data_test_dir])
        mkdir(save_exp_data_test_dir);
    end
    for dilate = 1:24
        save_exp_data_dir_full = [noise_back_data_dir,'/real_', num2str(real), '/dilate_', num2str(dilate),'/'];

        the_comp_data_dir = [comp_data_dir, '/real_', num2str(real), '/dilate_', num2str(dilate),'/'];
        the_comp_data_debug_dir = [comp_data_dir, '/real_', num2str(real), '/dilate_', num2str(dilate),'_debug/'];
        windowed = 0;
        use_float_point = 0;

        % analyze the noise stats in the video
        if ~exist(save_exp_data_dir_full,'dir')
            the_noisy_data_dir = [exp_data_dir, num2str(real)];
            disp(['analyzing the noise stats for data: ', the_noisy_data_dir]);
            video_data = read_real2_video_data_start_from_0(the_noisy_data_dir, num_of_frames);
            noise_stats = find_noise_param(video_data, 0,0);
            noise_stats(1) = noise_stats(1);
            mkdir(save_exp_data_dir_full);
            disp(['adding noise back, store at: ', save_exp_data_dir_full]);
            % TODO: here change the output file name index to be the same as
            % the input file name index, (now in every folder they all starts
            % from 0)
            add_noise_back_real2(noise_stats, the_comp_data_dir, the_comp_data_debug_dir, num_of_frames, save_exp_data_dir_full, windowed, use_float_point);
        else
            disp(['the data with noise added back at ', save_exp_data_dir_full, ' has already been created. Do nothing...']);
        end
    end
end
