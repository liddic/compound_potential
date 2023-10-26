#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --mem=32000M
#SBATCH --cpus-per-task=16

# run fastqc

# example1
OUTDIR="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/SRR8204590_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example2
OUTDIR="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/SRR8204590_pass_2.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example3
OUTDIR="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/SRR8204580_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example4
OUTDIR="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/SRR8204580_pass_2.fastq"

fastqc -o $OUTDIR -t 6 $INFILE

# example5
OUTDIR="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/SRR8204567_pass_1.fastq"

fastqc -o $OUTDIR -t 6 $INFILE


# example6
OUTDIR="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/fastqc_reports"
INFILE="/scratch/user/lidd0026/flannery-behav/flan_beh_1_meta_raw/SRR8204567_pass_2.fastq"

fastqc -o $OUTDIR -t 6 $INFILE