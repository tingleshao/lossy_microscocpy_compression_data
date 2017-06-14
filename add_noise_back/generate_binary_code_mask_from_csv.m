function [ mask ] = generate_binary_mask_from_code(code, w, h)

binary_code_file_name

% TODO: read txt file
code_mask = csvread(binary_code_file_name);

code_mask = uint8(code_mask);
max(max(code_mask))
mask = uint8(zeros(16*size(code_mask,1), 16*size(code_mask,2)));
%imshow(code_mask,[0,1]);

for i = 1:w
    for j = 1:h
        for x = 1:16
            for y = 1:16
                mask((j-1)*16+y, (i-1)*16+x) = code_mask(j,i);
            end
        end
    end
end

mask = mask(1:484, 1:648);
end
