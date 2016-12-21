function [ out_num ] = format_two_digit_number( num )
if num ~= 10
    out_num = ['0', num2str(num)];
else
    out_num = '10';
end

