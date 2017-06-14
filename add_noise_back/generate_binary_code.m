folder1 = '/playpen2/cshao/paper2_data/lossy_comp_data_set/comp_data/real_050317_400_lossless/real_050317_400_1_comp_debug'
folder = '/playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet9_custom_ffmpeg_real2/real_1'; 
input_img = imread([folder1, '/bin_diff_img.pgm']);

code = code_binary_map(input_img)
csvwrite([folder, '/', 'binary_code.csv'], code);
