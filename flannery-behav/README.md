## Workflow on DeepThought HPC - Childhood anxious-depressive behaviors case study, using data from [Flannery et al 2020](https://doi.org/10.1128/mBio.02780-19)

Notes:
- $WORKING_DIRECTORY and $LOCAL_WORKING_DIRECTORY should be substituted for appropriate folder paths
- [DeepThought HPC](https://deepthoughtdocs.flinders.edu.au/en/latest/) uses [SLURM](https://deepthoughtdocs.flinders.edu.au/en/latest/SLURM/SLURMIntro.html) job submission/queuing/management software

&nbsp;

**Step 1. Download raw fastq files**

Fastq files were downloaded from NCBI [Sequence Read Archive (SRA)](https://www.ncbi.nlm.nih.gov/sra) using the shell script *[flannery-behav_1_meta_raw_download.sh](flan_beh_1_meta_raw/flannery-behav_1_meta_raw_download.sh)*

A total of 40 SRA sequencing Runs corresponding to n = 40 subjects were initially downloaded.

```Shell
cd $WORKING_DIRECTORY/flannery-behav/flan_beh_1_meta_raw
sbatch flannery-behav_1_meta_raw_download.sh
```

&nbsp;

**Step 2. Perform QA/QC**

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) reports were generated for a representative selection of raw sequence files

```Shell
cd $WORKING_DIRECTORY/flannery-behav/flan_beh_1_meta_raw/fastqc_reports
sbatch flannery-behav_2a_fastqc_inspect_eg.sh
```

Next we performed [Fastp](https://github.com/OpenGene/fastp) quality control / trimming using [Snakemake](https://snakemake.github.io/).

To iterate through samples and R1/R2 reads this snakefile was used: [flannery-behav_2b_fastp_hpc.snakefile](flan_beh_2_fastp_qc/flannery-behav_2b_fastp_hpc.snakefile)

```Shell 
cd $WORKING_DIRECTORY/flannery-behav/flan_beh_2_fastp_qc
nohup snakemake -s flannery-behav_2b_fastp_hpc.snakefile --cluster 'sbatch --mem=30g --cpus-per-task 1 --time=2-00' -j 40 --latency-wait 60 & exit
```

Log back into the HPC.

[SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) only uses good R1 files, so cleanup files not used
```Shell
cd $WORKING_DIRECTORY/flannery-behav/flan_beh_2_fastp_qc
find -type f -name '*_R2.good.fastq'
find -type f -name '*_R2.good.fastq' -delete

find -type f -name '*_R2.single.fastq'
find -type f -name '*_R2.single.fastq' -delete

find -type f -name '*_R1.single.fastq'
find -type f -name '*_R1.single.fastq' -delete
```

&nbsp;

**Step 3. Perform [SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) functional annotation**

This runs the python script *[flannery-behav_3_superfocus_fxns_hpc.py](flan_beh_3_superfocus_fxns/flannery-behav_3_superfocus_fxns_hpc.py)*.

The python script writes and submits a separate SLURM submission file for each sample, with all files copied to [job_files](flan_beh_3_superfocus_fxns/job_files)

```Shell
cd $WORKING_DIRECTORY/flannery-behav/flan_beh_3_superfocus_fxns
sbatch run__flannery-behav_3_superfocus_fxns_hpc.sh
```
List sub-folders containing SUPER-FOCUS outputs for each sample, and copy to text file
```Shell
ls -d */
```
Then on local machine create corresponding results folders
```Shell
cd $LOCAL_WORKING_DIRECTORY/flannery-behav
xargs mkdir <flannery-behav-superfocus-folder-list.txt
```

Now using FileZilla FTP, download all *output_all_levels_and_function.xls* results files for each sequence from HPC to Local machine.
Proceed with [data analysis in R](../Compound-potential-R-code-final.R)
