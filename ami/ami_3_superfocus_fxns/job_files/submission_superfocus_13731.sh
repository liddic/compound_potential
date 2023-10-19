#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=4-0
#SBATCH --mem=128000M
#SBATCH --cpus-per-task=32
#SBATCH --nodes=1
export TMPDIR=/scratch/user/lidd0026/temp/13731
superfocus -q /scratch/user/lidd0026/ami_2_fastp_qc/13731_1_PE_550bp_BASE_UNSW_H2TKNBCXX_CGGCTATG-CCTATCCT_L001_R1.good.fastq -q /scratch/user/lidd0026/ami_2_fastp_qc/13731_1_PE_550bp_BASE_UNSW_H2TKNBCXX_CGGCTATG-CCTATCCT_L002_R1.good.fastq -dir /scratch/user/lidd0026/ami_3_superfocus_fxns/superfocus_out_13731 -a diamond -db DB_100 --alternate_directory /home/lidd0026/miniconda3/lib/python3.8/site-packages/superfocus_app
