#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --mem=20000M
#SBATCH --cpus-per-task=10

# run fastqc

# example1
OUTDIR="/scratch/user/lidd0026/forslund-t2d/ft2d_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/forslund-t2d/ft2d_1_meta_raw/ERR260132_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example2
OUTDIR="/scratch/user/lidd0026/forslund-t2d/ft2d_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/forslund-t2d/ft2d_1_meta_raw/ERR260132_pass_2.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example3
OUTDIR="/scratch/user/lidd0026/forslund-t2d/ft2d_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/forslund-t2d/ft2d_1_meta_raw/ERR260242_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE
 
 
# example4
OUTDIR="/scratch/user/lidd0026/forslund-t2d/ft2d_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/forslund-t2d/ft2d_1_meta_raw/ERR260242_pass_2.fastq"
 
fastqc -o $OUTDIR -t 6 $INFILE