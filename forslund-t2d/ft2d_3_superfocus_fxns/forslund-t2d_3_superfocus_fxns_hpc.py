# # # # # # # # # # # # # # # #
# # Run Superfocus fxn annotations from reads - for Forslund et al T2D case study metagenomics samples
# # Run from Deep Thought folder - /scratch/user/lidd0026/forslund-t2d/ft2d_3_superfocus_fxns
# # # # # # # # # # # # # # # #
# Shift-Option-E  to run line or chunk
#$ sinfo -N -o "%N %C %e %m"   # get cluster usage info
#$ cd <check run folder!!>

import os
import sys
import time
import pandas as pd
import re


print(sys.path)

# qc reads and sample manifest table are here
READDIR = '/scratch/user/lidd0026/forslund-t2d/ft2d_2_fastp_qc'

# set working directory
workDir = '/scratch/user/lidd0026/forslund-t2d/ft2d_3_superfocus_fxns'

# change to workDir
os.chdir(workDir)
print("Current Working Directory: ",os.getcwd())

def mkdir_p(dir):
    '''make a directory (dir) if it doesn't exist'''
    if not os.path.exists(dir):
        os.mkdir(dir)


# set job directory for sbatch submissions
job_directory = "%s/job_files" % os.getcwd()
mkdir_p(job_directory)

# set temp directory
TEMP_DIR_START = '/scratch/user/lidd0026/temp'

## read in manifest of sampleID and corresponding raw fastq R1/R2 files
table = pd.read_csv(os.path.join(READDIR,'Forslund-T2D-SWE-subjects-status-sra-run-list.txt'), sep=',')

# extract info from pandas data table
samples = table["Run"]

# iterate through creating jobs for data prep & running MetaCoAG
n = len(samples)

for i in range(n):
    #i=0
    job_file = os.path.join(job_directory, "submission_superfocus_%s.sh" % samples[i])

    qc_read_r1 = os.path.join(READDIR, "%s_R1.good.fastq" % samples[i])

    OUTDIR = "%s/superfocus_out_%s" % (os.getcwd(),samples[i])
    #mkdir_p(OUTDIR)  # this output directory will be made by superfocus

    path_to_db_dir = "/home/lidd0026/miniconda3/lib/python3.8/site-packages/superfocus_app"

    #path_to_diamond_db_dir = "/home/lidd0026/miniconda3/lib/python3.8/site-packages/superfocus_app/db/static/diamond/"
    # 100_clusters.db.dmnd

    temp_directory = "%s/%s" % (TEMP_DIR_START, samples[i])
    mkdir_p(temp_directory)

    # write and launch submission scripts
    fh = open(job_file, "w")
    fh.writelines("#!/bin/bash\n")
    #fh.writelines("#SBATCH --job-name=%s.job\n" % samples[i])
    #fh.writelines("#SBATCH --output=.out/%s.out\n" % samples[i])
    #fh.writelines("#SBATCH --error=.out/%s.err\n" % samples[i])
    fh.writelines("#SBATCH --ntasks=1\n")
    fh.writelines("#SBATCH --time=4-0\n")
    fh.writelines("#SBATCH --mem=64000M\n")
    fh.writelines("#SBATCH --cpus-per-task=16\n")
    fh.writelines("#SBATCH --nodes=1\n")
    #fh.writelines("#SBATCH --nodelist=hpc-node0XX,hpc-node0XX,hpc-node0XX,hpc-node0XX,hpc-node0XX,hpc-node0XX\n")
    #fh.writelines("#SBATCH --nodelist=hpc-node019,hpc-node020,hpc-node021\n")
    #fh.writelines("#SBATCH --qos=normal\n")
    #fh.writelines("#SBATCH --mail-type=ALL\n")
    #fh.writelines("#SBATCH --mail-user=email_address\n")

    # set the TMPDIR environment variable
    fh.writelines("export TMPDIR=%s\n" % (temp_directory))
    #fh.writelines("export SUPERFOCUS_DB=%s\n" % (path_to_db_dir))

    ### Run Superfocus - just on R1 reads

    # superfocus -q <path-to-fasta/q-files-or-directory> -dir <path-to-output-directory> -a <aligner> -db DATABASE
    fh.writelines("superfocus -q %s -dir %s -a diamond -db DB_100 --alternate_directory %s\n" % (qc_read_r1,OUTDIR,path_to_db_dir))
    # -b --alternate_directory # Alternate directory for your databases

    fh.close()

    time.sleep(2)  # Wait between submitting jobs

    os.system("sbatch %s" % job_file) # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

## END