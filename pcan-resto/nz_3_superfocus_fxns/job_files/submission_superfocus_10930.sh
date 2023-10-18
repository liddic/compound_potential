#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=4-0
#SBATCH --mem=128000M
#SBATCH --cpus-per-task=32
#SBATCH --nodes=1
export TMPDIR=/scratch/user/lidd0026/temp/10930
superfocus -q /scratch/user/lidd0026/nz/pilot/nz_2_fastp_qc/10930_R1.good.fastq -dir /scratch/user/lidd0026/nz/pilot/nz_5_superfocus_fxns/superfocus_out_10930 -a diamond -db DB_100 --alternate_directory /home/lidd0026/miniconda3/lib/python3.8/site-packages/superfocus_app
