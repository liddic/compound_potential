"""
Snakefile running on Flinders Uni DeepThought HPC

To perform QC on AMI metagenome data using fastp 0.23.2

Run from Deep Thought folder - /scratch/user/lidd0026/ami_2_fastp_qc

Adapted from a Rob Edwards example
"""

import os
import sys


# set this to directory with raw Fastq files
READDIR = '/scratch/user/lidd0026/ami_1_meta_raw_fastq'

# directory for QC outputs
OUTDIR = '/scratch/user/lidd0026/ami_2_fastp_qc'


# Note that this example requires an R1 file AND an R2 file
# and that each file should match *_R1* and *_R2*
SAMPLES,EXTENSIONS = glob_wildcards(os.path.join(READDIR, '{sample}_R1_001.{extensions}'))

# just get the first file extension as we don't need to iterate all of them
file_extension = EXTENSIONS[0]


# just check there is something to actually do!
if len(SAMPLES) == 0:
    sys.stderr.write("FATAL: We could not detect any samples at all.\n")
    sys.stderr.write("Do you have a directory called {READDIR} with some fastq files in it?\n")
    sys.stderr.write("Do those fastq files have _R1 and _R2?\n")
    sys.exit()


rule all:
    input:
        expand(os.path.join(OUTDIR, "{sample}_R1.good.fastq"), sample=SAMPLES)

rule run_fastp:
    input:
        r1 = os.path.join(READDIR, "{sample}_R1_001." + file_extension),
        r2 = os.path.join(READDIR, "{sample}_R2_001." + file_extension)
    output:
        r1 = os.path.join(OUTDIR, "{sample}_R1.good.fastq"),
        s1 = os.path.join(OUTDIR, "{sample}_R1.single.fastq"),
        r2 = os.path.join(OUTDIR, "{sample}_R2.good.fastq"),
        s2 = os.path.join(OUTDIR, "{sample}_R2.single.fastq")
    shell:
        """
        fastp --length_required 60 --average_qual 25 --n_base_limit 1 --dedup \
            --trim_front1 5 --trim_tail1 5 --trim_front2 5 --trim_tail2 5 \
            --cut_mean_quality 30 --cut_window_size 10 --cut_front --cut_tail \
            --out1 {output.r1} --unpaired1 {output.s1} \
            --out2 {output.r2} --unpaired2 {output.s2} \
            --in1 {input.r1} --in2 {input.r2};
        """