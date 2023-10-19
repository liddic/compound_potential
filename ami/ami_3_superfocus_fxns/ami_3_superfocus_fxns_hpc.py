# # # # # # # # # # # # # # # #
# # Run Superfocus fxn annotations from reads - for AMI soil metagenomics samples
# # Run from Deep Thought folder - /scratch/user/lidd0026/ami_3_superfocus_fxns
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

## directory for raw fastq files
#RAWREADDIR = '/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq'

# qc reads and sample manifest table are here
READDIR = '/scratch/user/lidd0026/ami_2_fastp_qc'

# set working directory
workDir = '/scratch/user/lidd0026/ami_3_superfocus_fxns'

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
table = pd.read_csv(os.path.join(READDIR,'sample-nos-ami-temperate-7-5-to-45-clay-content-tsv.txt'), sep='\t')

# extract info from pandas data table
samples = table["samp_no"]


## identify the read files
qcreadsFileNames = [ name for name in os.listdir(READDIR) if os.path.isfile(os.path.join(READDIR, name)) ]

#len(qcreadsFileNames) #
#print(qcreadsFileNames)

# only keep '*_R1.good.fastq' files
reads = [i for i in qcreadsFileNames if i.endswith('_R1.good.fastq')]

#print("no of _R1.good.fastq reads: ",len(reads))


# convert to full paths
reads_fullpath = []
for element in reads:
    reads_fullpath.append(os.path.join(READDIR, element))


# iterate through creating jobs for Superfocus
n = len(samples)

for i in range(n):
    #i=0
    job_file = os.path.join(job_directory, "submission_superfocus_%s.sh" % samples[i])

    #qc_read_r1 = os.path.join(READDIR, "%s_R1.good.fastq" % samples[i])
    
    # create string for all R1 reads for that sample
    # '*_R1.good.fastq' files already isolated
    reg = re.compile(r'%s' % samples[i])  # Compile the regex
    samp_reads = list(filter(reg.search, reads_fullpath))  # Create iterator using filter, cast to list
    samp_reads = " -q ".join(samp_reads) # i.e. like: paste0(<all read1s>, collapse = " -q ")
    
    # superfocus -q fastq1.fastq -q fastq2.fastq -q directory/ -dir output
    query_r1_string = samp_reads
    

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
    fh.writelines("#SBATCH --mem=128000M\n")
    fh.writelines("#SBATCH --cpus-per-task=32\n")
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
    #fh.writelines("superfocus -q %s -dir %s -a diamond -db DB_100 --alternate_directory %s\n" % (qc_read_r1,OUTDIR,path_to_db_dir))
    fh.writelines("superfocus -q %s -dir %s -a diamond -db DB_100 --alternate_directory %s\n" % (query_r1_string,OUTDIR,path_to_db_dir))
    # -b --alternate_directory # Alternate directory for your databases

    fh.close()

    time.sleep(2)  # Wait between submitting jobs

    os.system("sbatch %s" % job_file) # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

## END