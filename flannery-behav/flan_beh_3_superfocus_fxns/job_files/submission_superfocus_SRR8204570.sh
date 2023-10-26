#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=4-0
#SBATCH --mem=64000M
#SBATCH --cpus-per-task=16
#SBATCH --nodes=1
export TMPDIR=/scratch/user/lidd0026/temp/SRR8204570
superfocus -q /scratch/user/lidd0026/flannery-behav/flan_beh_2_fastp_qc/SRR8204570_R1.good.fastq -dir /scratch/user/lidd0026/flannery-behav/flan_beh_3_superfocus_fxns/superfocus_out_SRR8204570 -a diamond -db DB_100 --alternate_directory /home/lidd0026/miniconda3/lib/python3.8/site-packages/superfocus_app
