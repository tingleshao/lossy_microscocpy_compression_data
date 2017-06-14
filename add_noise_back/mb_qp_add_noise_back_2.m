function [] = mb_qp_add_noise_back_2(noise_stats, comp_data_dir, binary_code_file_name, number_of_frames, saved_qp_noiseback_frame_dir, w, h)
% do the actual work: save the noise back frame into the dir in last
% parameter
addpath(genpath('/playpen/cshao/lossyComp/'));

input_frame_header = [comp_data_dir, 'frame'];
curr_mask = generate_binary_code_mask_from_csv(binary_code_file_name, w, h);
max(max(curr_mask))
%figure;
curr_mask = curr_mask * 255;
% imshow(curr_mask,[0,255]);

for i = 1:number_of_frames
    input_frame_name = [input_frame_header, sprintf('%04d',i), '.pgm'];
    curr_img = imread(input_frame_name);

    bkgdNoise = normrnd(noise_stats(1), sqrt(noise_stats(2)), size(curr_img));

    noiseGP = uint8(int16(curr_img) .* int16((curr_mask) / 255) + int16(bkgdNoise) .* int16((255-curr_mask)/255));
    imwrite(noiseGP,strcat(saved_qp_noiseback_frame_dir,'/compressed_',sprintf('%04d',i),'.pgm'));
end
end
