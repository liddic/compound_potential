#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=3-0
#SBATCH --mem=32000M
#SBATCH --cpus-per-task=16
python ami_1_meta_download_hpc.py