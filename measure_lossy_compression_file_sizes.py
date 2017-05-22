# measures lossy compression files sizes
# two options:
#  lossy comp by dilation: dilate 10..24
#  lossy comp by custom h264: qp xxx


import os
# lossy comp by dilation:
# h264 lossless mode
def main():
    for dil in range(12, 25):
        os.system("ffmpeg -i dilate_{0}/compressed_%4d.pgm -c:v libx264 -preset ultrafast -crf 0 dilate_{0}.mkv".format(dil))
        

if __name__ == "__main__":
    main()

#
