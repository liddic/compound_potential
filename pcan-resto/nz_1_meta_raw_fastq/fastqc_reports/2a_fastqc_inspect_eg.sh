#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --mem=12000M
#SBATCH --cpus-per-task=6

# run fastqc


# example1
OUTDIR="/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/fastqc_reports"
INFILE="/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/10922/QGOJO329GC_20210506225159__S11_R1_001.fastq.gz"

fastqc -o $OUTDIR -t 6 $INFILE


# example2
OUTDIR="/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/fastqc_reports"
INFILE="/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/10922/QGOJO329GC_20210506225259__S11_R2_001.fastq.gz"

fastqc -o $OUTDIR -t 6 $INFILE


# example3
OUTDIR="/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/fastqc_reports"
INFILE="/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/10930/QGOJO337G3_20210506225359__S19_R1_001.fastq.gz"

fastqc -o $OUTDIR -t 6 $INFILE
 
 
# example4
OUTDIR="/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/fastqc_reports"
INFILE="/scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/10930/QGOJO337G3_20210506225359__S19_R2_001.fastq.gz"
 
fastqc -o $OUTDIR -t 6 $INFILE