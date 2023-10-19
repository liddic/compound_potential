## Workflow on DeepThought HPC

Note $WORKING_DIRECTORY should be swapped for appropriate working folder

**Step 1. Download raw fastq files**

This runs python script: ami_1_meta_download_hpc.py

```Shell
cd $WORKING_DIRECTORY/ami_1_meta_raw_fastq
sbatch run_ami_1_meta_download_hpc.sh
```

**Step 2. Perform QA/QC**

#check fastqc reports for example raw sequence files


$ cd /scratch/user/lidd0026/ami_1_meta_raw_fastq/fastqc_reports
$ sbatch ami_2_fastqc_inspect_eg.sh


$ cd /scratch/user/lidd0026/ami_1_meta_raw_fastq/
$ find -name "*_R1.fastq.gz" | wc -l # qty 129
$ find -name "*_R1_001.fastq.gz" | wc -l # qty 34

79 total soil metagenomes. qty with _001 = 17

# navigate to - /scratch/user/lidd0026/ami_2_fastp_qc
$ cd /scratch/user/lidd0026/ami_2_fastp_qc

# sbatch option here - https://slurm.schedmd.com/sbatch.html 
$ scontrol show config
# --mem = Specify the real memory required per node 

## DeepThought
$ nohup snakemake -s ami_2_fastp_hpc.snakefile --cluster 'sbatch --mem=32g --cpus-per-task 1 --time=2-00' -j 129 --latency-wait 60 & exit

$ nohup snakemake -s ami_2_fastp_hpc_001files.snakefile --cluster 'sbatch --mem=32g --cpus-per-task 1 --time=2-00' -j 34 --latency-wait 60 & exit

# logged back into deepthought and check squeue

# sbatch run_ami_2_fastp_hpc-19471-only.sh

squeue -u lidd0026 | wc -l


cd /scratch/user/lidd0026/ami_2_fastp_qc

# clean up files not used by Superfocus

$ find -type f -name '*_R2.good.fastq'
$ find -type f -name '*_R2.good.fastq' -delete

$ find -type f -name '*_R2.single.fastq'
$ find -type f -name '*_R2.single.fastq' -delete

$ find -type f -name '*_R1.single.fastq'
$ find -type f -name '*_R1.single.fastq' -delete


#### 3 - Superfocus functional annotation

$ cd /scratch/user/lidd0026/ami_3_superfocus_fxns

$ sbatch run_ami_3_superfocus_fxns_hpc.sh

# sbatch job_files/submission_superfocus_19471.sh

squeue -u lidd0026 | wc -l

#list sub-folders with superfocus outputs for each sample
ls -d */

# copy list of sub-folders to text file
# then in local Mac terminal:
cd /Users/lidd0026/WORKSPACE/PROJ/Gut-and-soil/modelling/DT/ami
xargs mkdir <ami-superfocus-folder-list.txt

# download 'output_all_levels_and_function.xls' from DT to Mac
