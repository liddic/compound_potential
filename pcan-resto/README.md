## Workflow on DeepThought HPC - People Cities & Nature (PCaN) urban forest ecosystem restoration soils (pilot) case study, using data from [Barnes et al 2023](https://data.agdr.org.nz/)

Notes:
- $WORKING_DIRECTORY and $LOCAL_WORKING_DIRECTORY should be substituted for appropriate folder paths
- [DeepThought HPC](https://deepthoughtdocs.flinders.edu.au/en/latest/) uses [SLURM](https://deepthoughtdocs.flinders.edu.au/en/latest/SLURM/SLURMIntro.html) job submission/queuing/management software

&nbsp;

**Step 1. Download raw fastq files**

PCaN pilot urban forest ecosystem restoration data are available on reasonable request from the [Aotearoa Genomic Data Repository](https://data.agdr.org.nz/).

Compressed metagenomics .gz files corresponding to 19 samples were downloaded to DeepThought (1 sample was later excluded due to missing pH data).

Files were uncompressed into folders based on sample code identifiers

```Shell
cd $WORKING_DIRECTORY/pcan-resto/nz_1_meta_raw_fastq
sbatch 1b_uncompress_gzfiles.sh
```

&nbsp;

**Step 2. Perform QA/QC**

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) reports were generated for a representative selection of raw sequence files

```Shell
cd $WORKING_DIRECTORY/zeller-crc/zcrc_1_meta_raw/fastqc_reports
sbatch zeller_crc_2a_fastqc_inspect_eg.sh
```

Next we performed [Fastp](https://github.com/OpenGene/fastp) quality control / trimming using [Snakemake](https://snakemake.github.io/).

To iterate through samples and R1/R2 reads this snakefile was used: [zeller_crc_2b_fastp_hpc.snakefile](zcrc_2_fastp_qc/zeller_crc_2b_fastp_hpc.snakefile)

```Shell 
cd $WORKING_DIRECTORY/zeller-crc/zcrc_2_fastp_qc
nohup snakemake -s zeller_crc_2b_fastp_hpc.snakefile --cluster 'sbatch --mem=32g --cpus-per-task 1 --time=2-00' -j 351 --latency-wait 60 & exit
```

Log back into the HPC.

[SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) only uses good R1 files, so cleanup files not used
```Shell
cd $WORKING_DIRECTORY/zeller-crc/zcrc_2_fastp_qc
find -type f -name '*_R2.good.fastq'
find -type f -name '*_R2.good.fastq' -delete

find -type f -name '*_R2.single.fastq'
find -type f -name '*_R2.single.fastq' -delete

find -type f -name '*_R1.single.fastq'
find -type f -name '*_R1.single.fastq' -delete
```

Note: with the specific QC parameters used here, the following sequence files failed to generate "good" R1 sequences (as required for SUPER-FOCUS): ERR479093, ERR479094, ERR479095, ERR479096, ERR479146, ERR479148, ERR479176, ERR479322.

&nbsp;

**Step 3. Perform [SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) functional annotation**

This runs the python script *[zeller-crc_3_superfocus_fxns_hpc.py](zcrc_3_superfocus_fxns/zeller-crc_3_superfocus_fxns_hpc.py)*.

The python script writes and submits a separate SLURM submission file for each sample, with all files copied to [job_files](zcrc_3_superfocus_fxns/job_files)

```Shell
cd $WORKING_DIRECTORY/zeller-crc/zcrc_3_superfocus_fxns
sbatch run__zeller-crc_3_superfocus_fxns_hpc.sh
```
List sub-folders containing SUPER-FOCUS outputs for each sample, and copy to text file
```Shell
ls -d */
```
Then on local machine create corresponding results folders
```Shell
cd $LOCAL_WORKING_DIRECTORY/zeller-crc
xargs mkdir <zeller-crc-superfocus-folder-list.txt
```

Now using FileZilla FTP, download all *output_all_levels_and_function.xls* results files for each sequence from HPC to Local machine.
Proceed with data analysis in R
