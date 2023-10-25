#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=4-0
#SBATCH --mem=128000M
#SBATCH --cpus-per-task=32
#SBATCH --nodes=1
export TMPDIR=/scratch/user/lidd0026/temp/ERR260264
superfocus -q /scratch/user/lidd0026/forslund-t2d/ft2d_2_fastp_qc/ERR260264_R1.good.fastq -dir /scratch/user/lidd0026/forslund-t2d/ft2d_3_superfocus_fxns/superfocus_out_ERR260264 -a diamond -db DB_100 --alternate_directory /home/lidd0026/miniconda3/lib/python3.8/site-packages/superfocus_app