## Workflow on DeepThought HPC - Type 2 diabetes case study, using data from [Forslund et al 2015](https://doi.org/10.1038/nature15766)

Notes:
- $WORKING_DIRECTORY and $LOCAL_WORKING_DIRECTORY should be substituted for appropriate folder paths
- [DeepThought HPC](https://deepthoughtdocs.flinders.edu.au/en/latest/) uses [SLURM](https://deepthoughtdocs.flinders.edu.au/en/latest/SLURM/SLURMIntro.html) job submission/queuing/management software

&nbsp;

**Step 1. Download raw fastq files**

Fastq files were downloaded from NCBI [Sequence Read Archive (SRA)](https://www.ncbi.nlm.nih.gov/sra) using shell scripts in 4 batches, e.g., *[forslund-t2d-SWE-sra-runs-download-SET1.sh](ft2d_1_meta_raw/forslund-t2d-SWE-sra-runs-download-SET1.sh)*

We used Forslund et al's Swedish population dataset (n = 145). 

```Shell
cd $WORKING_DIRECTORY/forslund-t2d/ft2d_1_meta_raw
sbatch forslund-t2d-SWE-sra-runs-download-SET1.sh
sbatch forslund-t2d-SWE-sra-runs-download-SET2.sh
sbatch forslund-t2d-SWE-sra-runs-download-SET3.sh
sbatch forslund-t2d-SWE-sra-runs-download-SET4.sh
```

&nbsp;

**Step 2. Perform QA/QC**

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) reports were generated for a representative selection of raw sequence files

```Shell
cd $WORKING_DIRECTORY/forslund-t2d/ft2d_1_meta_raw/fastqc_reports
sbatch forslund_t2d_2a_fastqc_inspect_eg.sh
```

Next we performed [Fastp](https://github.com/OpenGene/fastp) quality control / trimming using [Snakemake](https://snakemake.github.io/).

To iterate through samples and R1/R2 reads this snakefile was used: [forslund_t2d_2b_fastp_hpc.snakefile](ft2d_2_fastp_qc/forslund_t2d_2b_fastp_hpc.snakefile)

```Shell 
cd $WORKING_DIRECTORY/forslund-t2d/ft2d_2_fastp_qc
nohup snakemake -s forslund_t2d_2b_fastp_hpc.snakefile --cluster 'sbatch --mem=32g --cpus-per-task 1 --time=2-00' -j 145 --latency-wait 60 & exit
```

Log back into the HPC.

[SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) only uses good R1 files, so cleanup files not used
```Shell
cd $WORKING_DIRECTORY/forslund-t2d/ft2d_2_fastp_qc
find -type f -name '*_R2.good.fastq'
find -type f -name '*_R2.good.fastq' -delete

find -type f -name '*_R2.single.fastq'
find -type f -name '*_R2.single.fastq' -delete

find -type f -name '*_R1.single.fastq'
find -type f -name '*_R1.single.fastq' -delete
```

&nbsp;

**Step 3. Perform [SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) functional annotation**

This runs the python script *[forslund-t2d_3_superfocus_fxns_hpc.py](ft2d_3_superfocus_fxns/forslund-t2d_3_superfocus_fxns_hpc.py)*.

The python script writes and submits a separate SLURM submission file for each sample, with all files copied to [job_files](ft2d_3_superfocus_fxns/job_files)

```Shell
cd $WORKING_DIRECTORY/forslund-t2d/ft2d_3_superfocus_fxns
sbatch run__forslund-t2d_3_superfocus_fxns_hpc.sh
```

&nbsp;

We encountered a number of failed jobs (n = 24), so SUPER-FOCUS was rerun with increased memory allocation. The rerun submission files were copied to [job_files_RERUNS](ft2d_3_superfocus_fxns/job_files_RERUNS)

```Shell
cd $WORKING_DIRECTORY/forslund-t2d/ft2d_3_superfocus_fxns/job_files_RERUNS
find -type f -name 'submission_superfocus_*'
sbatch ./submission_superfocus_ERR275252.sh
sbatch ./submission_superfocus_ERR260272.sh
sbatch ./submission_superfocus_ERR260267.sh
sbatch ./submission_superfocus_ERR260264.sh
sbatch ./submission_superfocus_ERR260261.sh
sbatch ./submission_superfocus_ERR260241.sh
sbatch ./submission_superfocus_ERR260231.sh
sbatch ./submission_superfocus_ERR260224.sh
sbatch ./submission_superfocus_ERR260223.sh
sbatch ./submission_superfocus_ERR260222.sh
sbatch ./submission_superfocus_ERR260215.sh
sbatch ./submission_superfocus_ERR260204.sh
sbatch ./submission_superfocus_ERR260190.sh
sbatch ./submission_superfocus_ERR260188.sh
sbatch ./submission_superfocus_ERR260187.sh
sbatch ./submission_superfocus_ERR260183.sh
sbatch ./submission_superfocus_ERR260182.sh
sbatch ./submission_superfocus_ERR260177.sh
sbatch ./submission_superfocus_ERR260174.sh
sbatch ./submission_superfocus_ERR260169.sh
sbatch ./submission_superfocus_ERR260158.sh
sbatch ./submission_superfocus_ERR260150.sh
sbatch ./submission_superfocus_ERR260145.sh
sbatch ./submission_superfocus_ERR260140.sh
```

&nbsp;

List sub-folders containing SUPER-FOCUS outputs for each sample, and copy to text file
```Shell
ls -d */
```
Then on local machine create corresponding results folders
```Shell
cd $LOCAL_WORKING_DIRECTORY/forslund-t2d
xargs mkdir <forslund-t2d-superfocus-folder-list.txt
```

Now using FileZilla FTP, download all *output_all_levels_and_function.xls* results files for each sequence from HPC to Local machine.
Proceed with [data analysis in R](../Compound-potential-R-code-final.R)
