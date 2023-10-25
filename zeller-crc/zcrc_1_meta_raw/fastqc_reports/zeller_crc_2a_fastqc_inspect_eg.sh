#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --mem=12000M
#SBATCH --cpus-per-task=6

# run fastqc

# example1
OUTDIR="/scratch/user/lidd0026/zeller-crc/zcrc_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/zeller-crc/zcrc_1_meta_raw/ERR478958_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example2
OUTDIR="/scratch/user/lidd0026/zeller-crc/zcrc_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/zeller-crc/zcrc_1_meta_raw/ERR478958_pass_2.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example3
OUTDIR="/scratch/user/lidd0026/zeller-crc/zcrc_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/zeller-crc/zcrc_1_meta_raw/ERR478967_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example4
OUTDIR="/scratch/user/lidd0026/zeller-crc/zcrc_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/zeller-crc/zcrc_1_meta_raw/ERR478967_pass_2.fastq"

fastqc -o $OUTDIR -t 6 $INFILE