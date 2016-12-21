function [ exp_msd_means, exp_msd_stdevs ] = compute_mean_stdev_over_tests_for_different_params( param_list, test_list, exp_dir, param_name)
%COMPUTE_MEAN_STDEV_OVER_TESTS_FOR_DIFFERENT_PARAMS Summary of this function goes here
%   Detailed explanation goes here
exp_msd_means = [];
exp_msd_stdevs = [];
exp_msd_for_curr_param = [];
for param = param_list
    for test = test_list
        msd_file_name = [exp_dir, format_two_digit_number(test), '/', param_name, '_', num2str(param), '_bead1.mat'];
        load(msd_file_name);
        exp_msd_for_curr_param = [exp_msd_for_curr_param, msd_data];
    end
    exp_msd_for_curr_param_mean = mean(exp_msd_for_curr_param, 2);
    exp_msd_for_curr_param_stdev = std(exp_msd_for_curr_param, 0, 2);
    
    exp_msd_means = [exp_msd_means, exp_msd_for_curr_param_mean];
    exp_msd_stdevs = [exp_msd_stdevs, exp_msd_for_curr_param_stdev];
end





