#!/bin/bash
#$ -N Metaphlan2_first

#DEFINE PATH, if installed with conda justa activate conda

export PATH=/home/install/miniconda3/envs/metaphlan2/bin/:$PATH

metaphlan2.py sample_0.R1.fq.gz --input_type fastq --nproc 3 --bowtie2db /OUTPUT_PATH > sample0_R1_profile.txt
metaphlan2.py sample_0.R2.fq.gz --input_type fastq --nproc 3 --bowtie2db /OUTPUT_PATH > sample0_R2_profile.txt
