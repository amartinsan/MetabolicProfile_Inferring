#!/bin/bash
#$ -N kraken2
#$ -cwd
#$ -pe thread 21

conda activate kraken


kraken2 \
--threads 20 \
--db Plus  
--fastq-input 
--gzip-compressed 
--report plus_SAMPLE.report 
-paired *_R1_001.fastq.gz  *_R2_001.fastq.gz > plus_SAMPLE.kraken

#use bracken to generate reports

bracken -d PATH_TO_DB_DIR -i kraken2.report -o bracken.species.txt -l S


