#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=1-0
#SBATCH --mem=32000
#SBATCH --cpus-per-task=8
#SBATCH --nodes=1
fastp --length_required 60 --average_qual 25 --n_base_limit 1 --dedup \
    --trim_front1 15 --trim_tail1 5 --trim_front2 15 --trim_tail2 5 \
    --cut_mean_quality 30 --cut_window_size 10 --cut_front --cut_tail \
    --out1 /scratch/user/lidd0026/nz/pilot/nz_2_fastp_qc/10924_R1.good.fastq --unpaired1 /scratch/user/lidd0026/nz/pilot/nz_2_fastp_qc/10924_R1.single.fastq \
    --out2 /scratch/user/lidd0026/nz/pilot/nz_2_fastp_qc/10924_R2.good.fastq --unpaired2 /scratch/user/lidd0026/nz/pilot/nz_2_fastp_qc/10924_R2.single.fastq \
    --in1 /scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/10924/QGOJO327GU_20210506225159__S9_R1_001.fastq.gz --in2 /scratch/user/lidd0026/nz/pilot/nz_1_meta_raw_fastq/10924/QGOJO327GU_20210506225159__S9_R2_001.fastq.gz
