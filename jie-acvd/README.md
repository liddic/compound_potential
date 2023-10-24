## Workflow on DeepThought HPC - Atherosclerotic cardiovascular disease (ACVD) case study, using data from Jie et al 2017

Notes:
- $WORKING_DIRECTORY and $LOCAL_WORKING_DIRECTORY should be substituted for appropriate folder paths
- [DeepThought HPC](https://deepthoughtdocs.flinders.edu.au/en/latest/) uses [SLURM](https://deepthoughtdocs.flinders.edu.au/en/latest/SLURM/SLURMIntro.html) job submission/queuing/management software

&nbsp;

**Step 1. Download raw fastq files**

Fastq files were downloaded using shell scripts in 4 batches, e.g., *[jie-acvd-sra-runs-download-SET1.sh](jacvd_1_meta_raw/jie-acvd-sra-runs-download-SET1.sh)*

```Shell
cd $WORKING_DIRECTORY/jie-acvd/jacvd_1_meta_raw
sbatch jie-acvd-sra-runs-download-SET1.sh
sbatch jie-acvd-sra-runs-download-SET2.sh
sbatch jie-acvd-sra-runs-download-SET3.sh
sbatch jie-acvd-sra-runs-download-SET4.sh
```

&nbsp;

**Step 2. Perform QA/QC**

Run [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) reports for a representative selection of raw sequence files

```Shell
cd $WORKING_DIRECTORY/ami_1_meta_raw_fastq/fastqc_reports
sbatch ami_2_fastqc_inspect_eg.sh
```

Now perform [Fastp](https://github.com/OpenGene/fastp) quality control / trimming using [Snakemake](https://snakemake.github.io/).

AMI fastq files have two formats, so snakefiles were developed for each format - [_R1.fastq/_R2.fastq](ami_2_fastp_qc/ami_2_fastp_hpc.snakefile) and [_R1_001.fastq/_R2_001.fastq](ami_2_fastp_qc/ami_2_fastp_hpc_001files.snakefile) 

```Shell 
cd $WORKING_DIRECTORY/ami_2_fastp_qc
nohup snakemake -s ami_2_fastp_hpc.snakefile --cluster 'sbatch --mem=32g --cpus-per-task 1 --time=2-00' -j 129 --latency-wait 60 & exit
nohup snakemake -s ami_2_fastp_hpc_001files.snakefile --cluster 'sbatch --mem=32g --cpus-per-task 1 --time=2-00' -j 34 --latency-wait 60 & exit
```

Log back into the HPC.

[SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) only uses good R1 files, so cleanup files not used
```Shell
cd $WORKING_DIRECTORY/ami_2_fastp_qc
$ find -type f -name '*_R2.good.fastq'
$ find -type f -name '*_R2.good.fastq' -delete

$ find -type f -name '*_R2.single.fastq'
$ find -type f -name '*_R2.single.fastq' -delete

$ find -type f -name '*_R1.single.fastq'
$ find -type f -name '*_R1.single.fastq' -delete
```

&nbsp;

**Step 3. Perform [SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) functional annotation**

This runs the python script *[ami_3_superfocus_fxns_hpc.py](ami_3_superfocus_fxns/ami_3_superfocus_fxns_hpc.py)*.

The python script writes and submits a separate SLURM submission file for each sample, with all files copied to [job_files](ami_3_superfocus_fxns/job_files)

```Shell
cd $WORKING_DIRECTORY/ami_3_superfocus_fxns
sbatch run_ami_3_superfocus_fxns_hpc.sh
```
List sub-folders containing SUPER-FOCUS outputs for each sample, and copy to text file
```Shell
ls -d */
```
Then on local machine create corresponding results folders
```Shell
cd $LOCAL_WORKING_DIRECTORY/ami
xargs mkdir <ami-superfocus-folder-list.txt
```

Now using FileZilla FTP, download all *output_all_levels_and_function.xls* results files for each sequence from HPC to Local machine.
Proceed with data analysis in R
