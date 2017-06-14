addpath(genpath('/playpen/cshao/lossyComp/'));
addpath(genpath('/playpen/cshao/3dmfs/3dfmAnalysis/specific/modeling/'));
addpath(genpath('/playpen/cshao/3dmfs/3dfmAnalysis/'));

dilate_list = 1:25 
for real = 1:10
    for dilate = dilate_list
        % generate tracking frames
        mkdir(['real_', format_two_digit_number(real), '_tracking_dilate_', num2str(dilate)]);
        copyfile(['real_', format_two_digit_number(real), '/dilate_', num2str(dilate), '/cframe_noise0000.pgm'], ['real_', format_two_digit_number(real), '_tracking_dilate_', num2str(dilate)]);
        copyfile(['real_', format_two_digit_number(real), '/dilate_', num2str(dilate), '/cframe_noise0001.pgm'], ['real_', format_two_digit_number(real), '_tracking_dilate_', num2str(dilate)]);
        copyfile(['real_', format_two_digit_number(real), '/dilate_', num2str(dilate), '/cframe_noise0002.pgm'], ['real_', format_two_digit_number(real), '_tracking_dilate_', num2str(dilate)]);
        % tracking 
        search_frame_name = ['real_' format_two_digit_number(real), '_tracking_dilate_', num2str(dilate), '/cframe_noise0000.pgm'];
        first_frame_name = ['real_', format_two_digit_number(real), '/dilate_', num2str(dilate), '/cframe_noise0000.pgm'];
        out_name = ['real_', format_two_digit_number(real), '/dilate_', num2str(dilate), '_tracking'];
        call_tracking_script( search_frame_name, first_frame_name, out_name)
        % compute msd
        orig_tracking_name = ['real_', format_two_digit_number(real), '/dilate_', num2str(dilate), '_tracking'];
        save_msd_file_name = ['real_', format_two_digit_number(real), '/dilate_', num2str(dilate), '_bead1'];
        bead_id = 1;
        compute_msd_for_compression_exp(orig_tracking_name, bead_id, save_msd_file_name); 
    end
end
