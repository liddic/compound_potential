#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --mem=16000M
#SBATCH --cpus-per-task=8
python sunbad-resto_3_superfocus_fxns_hpc.py
