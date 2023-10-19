#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --mem=12000M
#SBATCH --cpus-per-task=6

# run fastqc

# example1
OUTDIR="/scratch/user/lidd0026/ami_1_meta_raw_fastq/fastqc_reports"
INFILE="/scratch/user/lidd0026/ami_1_meta_raw_fastq/9468_1_PE_550bp_BASE_UNSW_H3WYNBCXX_TCCGCGAA-GTACTGAC_L001_R1.fastq.gz"

fastqc -o $OUTDIR -t 6 $INFILE


# example2
OUTDIR="/scratch/user/lidd0026/ami_1_meta_raw_fastq/fastqc_reports"
INFILE="/scratch/user/lidd0026/ami_1_meta_raw_fastq/9468_1_PE_550bp_BASE_UNSW_H3WYNBCXX_TCCGCGAA-GTACTGAC_L001_R2.fastq.gz"

fastqc -o $OUTDIR -t 6 $INFILE


# example3
OUTDIR="/scratch/user/lidd0026/ami_1_meta_raw_fastq/fastqc_reports"
INFILE="/scratch/user/lidd0026/ami_1_meta_raw_fastq/12590_1_PE_550bp_BASE_UNSW_HFMJGBCXX_TCCGCGAA-GTACTGAC_L002_R2_001.fastq.gz"

fastqc -o $OUTDIR -t 6 $INFILE


# example4
OUTDIR="/scratch/user/lidd0026/ami_1_meta_raw_fastq/fastqc_reports"
INFILE="/scratch/user/lidd0026/ami_1_meta_raw_fastq/12590_1_PE_550bp_BASE_UNSW_HFMJGBCXX_TCCGCGAA-GTACTGAC_L002_R1_001.fastq.gz"

fastqc -o $OUTDIR -t 6 $INFILE