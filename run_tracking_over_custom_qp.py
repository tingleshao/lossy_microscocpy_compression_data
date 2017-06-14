import os


qp_list = [1,2,3,4,5,6,7,8,9,10,20,30,40,50]


def run_tracking():
    for exp_id in range(1,6):
        for qp in qp_list:
            os.system("mkdir real_{0}/qp_{1}".format(exp_id, qp))
            os.system("mkdir real_{0}/qp_{1}_tracking".format(exp_id, qp))
            # generate frames
            os.system("/playpen/cshao/ffmpeg_latest_static_build/ffmpeg-2.4.2-64bit-static/ffmpeg -i real_{0}/qp_{1}.mkv real_{0}/qp_{1}/compressed_%04d.png".format(exp_id, qp))
            # copy frames to the tracking folder
            os.system("cp real_{0}/qp_{1}/compressed_0001.png real_{0}/qp_{1}_tracking/".format(exp_id, qp))
            os.system("cp real_{0}/qp_{1}/compressed_0002.png real_{0}/qp_{1}_tracking/".format(exp_id, qp))
            os.system("cp real_{0}/qp_{1}/compressed_0003.png real_{0}/qp_{1}_tracking/".format(exp_id, qp))
            # run tracking
            os.system("/playpen2/cshao/paper2_code/lossy_comp/tracking_scripts/Run_VST4 real_{0}/qp_{1}_tracking/compressed_0001.png real_{0}/qp_{1}/compressed_0001.png real_{0}/qp_{1}_".format(exp_id, qp))


if __name__ == "__main__":
    run_tracking()
