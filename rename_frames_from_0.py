import os


pgmfiles = [f for f in os.listdir('.') if len(f.split("."))>1 and f.split(".")[1] == "pgm"]
file_id = [x for x in range(1,422)]

pgmfiles.sort()
curr_idx = 0

for f in pgmfiles:
    os.system("mv {0} frame{1:04d}.pgm".format(f,file_id[curr_idx]))
    curr_idx = curr_idx + 1
