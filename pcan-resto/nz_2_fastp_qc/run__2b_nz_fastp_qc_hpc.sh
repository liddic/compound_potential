#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --mem=16000M
#SBATCH --cpus-per-task=8
python 2b_nz_fastp_qc_hpc.py
