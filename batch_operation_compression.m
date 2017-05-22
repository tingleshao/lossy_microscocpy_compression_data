for i = 10
for j = 16:25
    command = ['/playpen/cshao/ffmpeg_latest_static_build/ffmpeg-2.4.2-64bit-static/ffmpeg -i /playpen2/cshao/paper2_data/lossy_comp_video_size_exp_chart/sheet3_lossy_comp_by_dilation/test_', num2str(i), '/dilate_', num2str(j), '/compressed_%4d.pgm -c:a copy -c:v libx264 -g 1800 -qp 0 test_', num2str(i), '/compressed_videos/dilate_', num2str(j), '.mkv']
    system(command)
end
end
