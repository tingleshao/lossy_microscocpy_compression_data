addpath(genpath('/playpen/cshao/lossyComp/'));
addpath(genpath('/playpen/cshao/3dmfs/3dfmAnalysis/specific/modeling/'));
addpath(genpath('/playpen/cshao/3dmfs/3dfmAnalysis/'));

dilate_list = [6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
for test = 1:10
    for dilate = dilate_list
        % generate tracking frames
        mkdir(['test_', format_two_digit_number(test), '_tracking_dilate_', num2str(dilate)]);
        copyfile(['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '/compressed_0000.pgm'], ['test_', format_two_digit_number(test), '_tracking_dilate_', num2str(dilate)]);
        copyfile(['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '/compressed_0001.pgm'], ['test_', format_two_digit_number(test), '_tracking_dilate_', num2str(dilate)]);
        copyfile(['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '/compressed_0002.pgm'], ['test_', format_two_digit_number(test), '_tracking_dilate_', num2str(dilate)]);
        % tracking 
        search_frame_name = ['test_' format_two_digit_number(test), '_tracking_dilate_', num2str(dilate), '/compressed_0000.pgm'];
        first_frame_name = ['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '/compressed_0000.pgm'];
        out_name = ['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '_tracking'];
        call_tracking_script( search_frame_name, first_frame_name, out_name)
        % compute msd
        orig_tracking_name = ['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '_tracking'];
        save_msd_file_name = ['test_', format_two_digit_number(test), '/dilate_', num2str(dilate), '_bead1'];
        bead_id = 1;
        compute_msd_for_compression_exp(orig_tracking_name, bead_id, save_msd_file_name); 
    end
end