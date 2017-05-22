for test = 1:10
for dilate = 1
    command1 = ['mkdir test_', format_two_digit_number(test),'/dilate_',num2str(dilate)]
    system(command1)
    command2 = ['mkdir test_', format_two_digit_number(test),'_debug/dilate_',num2str(dilate)]
    system(command2) 
    command = ['/afs/cs.unc.edu/home/cshao/compression_project/dr_run/data_reduction/dr new_img -i /playpen2/cshao/paper2_data/lossy_comp_data_set/exp_data/test_011015/test_011015_', num2str(test), '/nframe0001.png ', num2str(dilate),' 1 1 70 test_', format_two_digit_number(test), '/dilate_', num2str(dilate),'/ test_', format_two_digit_number(test), '_debug/dilate_', num2str(dilate), '/']
    system(command)
end
end
