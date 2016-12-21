function [ exp_kldiv_test_values ] = compute_kldiv_test_row( orig_exp_msd, exp_msd_data, tau_index, param_list)
exp_kldiv_test_values = []; 
orig_msd_data = orig_exp_msd(tau_index, :); 
for param_index = 1:length(param_list)
    msd_data = exp_msd_data(tau_index, :, param_index); 
    res = KLDiv(msd_data, orig_msd_data); 
    exp_kldiv_test_values = [exp_kldiv_test_values, res]; 
end
end

