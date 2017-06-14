function [ video ] = read_real2_video_data_start_from_0( frame_dir, number_of_frames_per_seg )
% do the subsampling here.
frame_header = [frame_dir, '/frame'];
sp = regexp(frame_dir,'_','split');
spl = length(sp);
a = sp{spl};
seg_id = str2num(a);
ratio = 4;
first_frame_name = [frame_header, sprintf('%04d.pgm', 1)];
test_frame = imread(first_frame_name);
[h,w] = size(test_frame);
video = zeros(h/ratio, w/ratio, number_of_frames_per_seg);
for i = 1:number_of_frames_per_seg
    frame_name = [frame_header, sprintf('%04d.pgm', i)];
    img = imread(frame_name);
    small_img = sample_image(img, ratio);
    video(:,:,i) = small_img;
end
end
