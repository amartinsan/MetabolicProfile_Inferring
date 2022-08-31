#!/bin/bash
# María del Carmen
# This script is to get the number of reads from your files (libraries)
sample_file=$1
samples_files=($(cut -f 1 "$sample_file" | uniq ))

echo " "
for  fastq_gz_file in ${samples_files[@]}
do
        echo "$fastq_gz_file:"
        NO_READS=$(zcat "$fastq_gz_file" | wc -l)
        expr $NO_READS / 4
done
