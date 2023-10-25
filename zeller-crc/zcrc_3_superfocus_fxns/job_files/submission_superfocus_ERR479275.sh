#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=4-0
#SBATCH --mem=64000M
#SBATCH --cpus-per-task=16
#SBATCH --nodes=1
export TMPDIR=/scratch/user/lidd0026/temp/ERR479275
superfocus -q /scratch/user/lidd0026/zeller-crc/zcrc_2_fastp_qc/ERR479275_R1.good.fastq -dir /scratch/user/lidd0026/zeller-crc/zcrc_3_superfocus_fxns/superfocus_out_ERR479275 -a diamond -db DB_100 --alternate_directory /home/lidd0026/miniconda3/lib/python3.8/site-packages/superfocus_app
