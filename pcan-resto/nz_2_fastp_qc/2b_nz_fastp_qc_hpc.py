# # # # # # # # # # # # # # # #
# # Fastp - QC for NZ PCaN pilot metagenomics
# # # # # # # # # # # # # # # #
#$ sinfo -N -o "%N %C %e %m"   # get cluster usage info
#$ cd <check run folder!!>

# Shift + Option + E  # to run code chunks
# Code completion: (Basic) Ctrl + Space  ;  (SmartType) Ctrl + Shift + Space

import os
import sys
import time
#import re
#import glob
import pandas as pd


print(sys.path)

# directory for raw fastq files
READDIR = '/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq'

# directory for QC outputs
OUTDIR = '/scratch/user/lidd0026/nz/pilot/nz_2_fastp_qc'

# set working directory
workDir = OUTDIR
os.chdir(workDir)
print("Current Working Directory: ",os.getcwd())

def mkdir_p(dir):
    '''make a directory (dir) if it doesn't exist'''
    if not os.path.exists(dir):
        os.mkdir(dir)


job_directory = "%s/job_index" % os.getcwd()
mkdir_p(job_directory)

## read in manifest of sampleID and corresponding raw fastq R1/R2 files
table = pd.read_csv('input-fastq-files-tsv.txt', sep='\t')

# extract info from pandas data table
samples = table["SampleID"]
names = table["Name"]
r1_files = table["R1_filenames"]
r2_files = table["R2_filenames"]

# iterate through creating jobs for fastp QC of each sample
n = len(samples)
for i in range(n):
    #i=0
    job_file = os.path.join(job_directory, "%s.sh" % samples[i])

    input_r1 = os.path.join(READDIR,"%s/%s" % (samples[i],r1_files[i]))
    input_r2 = os.path.join(READDIR, "%s/%s" % (samples[i], r2_files[i]))

    output_r1 = os.path.join(OUTDIR,"%s_R1.good.fastq" % samples[i] )
    output_s1 = os.path.join(OUTDIR,"%s_R1.single.fastq" % samples[i] )
    #output_b1 = os.path.join(OUTDIR,"%s_R1.bad.fastq" % samples[i] )

    output_r2 = os.path.join(OUTDIR,"%s_R2.good.fastq" % samples[i] )
    output_s2 = os.path.join(OUTDIR,"%s_R2.single.fastq" % samples[i] )
    #output_b2 = os.path.join(OUTDIR,"%s_R2.bad.fastq" % samples[i] )

    #with open(job_file) as fh:
    fh = open(job_file, "w")
    fh.writelines("#!/bin/bash\n")
    #fh.writelines("#SBATCH --job-name=%s.job\n" % samples[i])
    #fh.writelines("#SBATCH --output=.out/%s.out\n" % samples[i])
    #fh.writelines("#SBATCH --error=.out/%s.err\n" % samples[i])
    fh.writelines("#SBATCH --ntasks=1\n")
    fh.writelines("#SBATCH --time=1-0\n")
    fh.writelines("#SBATCH --mem=32000\n")
    fh.writelines("#SBATCH --cpus-per-task=8\n")
    fh.writelines("#SBATCH --nodes=1\n")
    #fh.writelines("#SBATCH --qos=normal\n")
    #fh.writelines("#SBATCH --mail-type=ALL\n")
    #fh.writelines("#SBATCH --mail-user=email_address\n")
    
    fh.writelines("fastp --length_required 60 --average_qual 25 --n_base_limit 1 --dedup \\\n")
    fh.writelines("    --trim_front1 15 --trim_tail1 5 --trim_front2 15 --trim_tail2 5 \\\n")
    fh.writelines("    --cut_mean_quality 30 --cut_window_size 10 --cut_front --cut_tail \\\n")
    fh.writelines("    --out1 %s --unpaired1 %s \\\n" % (output_r1,output_s1))
    fh.writelines("    --out2 %s --unpaired2 %s \\\n" % (output_r2, output_s2))
    fh.writelines("    --in1 %s --in2 %s\n" % (input_r1,input_r2))

    fh.close()
    time.sleep(2)
    os.system("sbatch %s" % job_file)

## END