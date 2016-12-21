function [ exp_avg_file_sizes ] = compute_file_sizes_for_the_exp( exp_dir, exp_param_list, test_list, param_name )
% get average file_size
exp_file_sizes = [];
for test = test_list
    if strcmp(param_name, 'qp')
        exp_file_info_for_the_test = dir(fullfile([exp_dir, format_two_digit_number(test), '/*.mkv']));
    else
        exp_file_info_for_the_test = dir(fullfile([exp_dir, format_two_digit_number(test), '/compressed_videos/*.mkv']));
    end 
    len_of_file_array = length(exp_file_info_for_the_test);
    exp_file_size_unsorted_for_the_test = [];
    exp_file_names_for_the_test = cell(len_of_file_array, 1);
    for i = 1:len_of_file_array
        exp_file_size_unsorted_for_the_test = [exp_file_size_unsorted_for_the_test, exp_file_info_for_the_test(i).bytes];
        exp_file_names_for_the_test{i} = exp_file_info_for_the_test(i).name;
    end
    % sort the size list    
    exp_file_size_sorted_for_the_test = [];
    for param = exp_param_list
        file_name = [param_name, '_', num2str(param), '.mkv'];
        elem_index_C = strfind(exp_file_names_for_the_test, file_name);
        elem_index = find(not(cellfun('isempty', elem_index_C)));
        exp_file_size_sorted_for_the_test = [exp_file_size_sorted_for_the_test; exp_file_size_unsorted_for_the_test(elem_index)];
    end
    exp_file_sizes = [exp_file_sizes, exp_file_size_sorted_for_the_test];
end
exp_avg_file_sizes = mean(exp_file_sizes, 2);

