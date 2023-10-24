#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --mem=20000M
#SBATCH --cpus-per-task=10

# run fastqc

# example1
OUTDIR="/scratch/user/lidd0026/jie-acvd/jacvd_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/jie-acvd/jacvd_1_meta_raw/ERR2017802_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example2
OUTDIR="/scratch/user/lidd0026/jie-acvd/jacvd_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/jie-acvd/jacvd_1_meta_raw/ERR2017802_pass_2.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example3
OUTDIR="/scratch/user/lidd0026/jie-acvd/jacvd_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/jie-acvd/jacvd_1_meta_raw/ERR2017610_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example4
OUTDIR="/scratch/user/lidd0026/jie-acvd/jacvd_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/jie-acvd/jacvd_1_meta_raw/ERR2017610_pass_2.fastq"

fastqc -o $OUTDIR -t 6 $INFILE