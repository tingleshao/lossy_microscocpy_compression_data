function [ exp_msd_data ] = read_msd_data( exp_dir, tau_size, test_size, param_list, param_name )
exp_msd_data = zeros(tau_size, test_size, length(param_list));
for test = 1:test_size
    for param_index = 1:length(param_list)
        msd_file_name = [exp_dir, format_two_digit_number(test), '/', param_name, '_', num2str(param_list(param_index)), '_bead1.mat'];
        load(msd_file_name);
        exp_msd_data(:, test, param_index) = msd_data; 
    end
end 
end

