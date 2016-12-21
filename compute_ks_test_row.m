function [ exp_ks_test_h, exp_ks_test_p ] = compute_ks_test_row( orig_exp_msd, exp_msd_data, tau_index, param_list)
exp_ks_test_h = [];
exp_ks_test_p = [];
orig_msd_data = orig_exp_msd(tau_index, :);
for param_index = 1:length(param_list)
    msd_data = exp_msd_data(tau_index, :, param_index);
    [h, p] = ks_test(msd_data, orig_msd_data); 
    exp_ks_test_h = [exp_ks_test_h, h]; 
    exp_ks_test_p = [exp_ks_test_p, p]; 
end 
end

