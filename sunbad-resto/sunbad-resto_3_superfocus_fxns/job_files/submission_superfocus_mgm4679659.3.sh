#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=4-0
#SBATCH --mem=64000M
#SBATCH --cpus-per-task=16
#SBATCH --nodes=1
export TMPDIR=/scratch/user/lidd0026/temp/mgm4679659.3
superfocus -q /scratch/user/lidd0026/sunbad-resto/sunbad-resto_2_mgrast_screened/mgm4679659.3/mgm4679659.3.299.screen.passed.fna -dir /scratch/user/lidd0026/sunbad-resto/sunbad-resto_3_superfocus_fxns/superfocus_out_mgm4679659.3 -a diamond -db DB_100 --alternate_directory /home/lidd0026/miniconda3/lib/python3.8/site-packages/superfocus_app
