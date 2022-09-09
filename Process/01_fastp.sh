#!/bin/bash


#Quality check and filter to sample fasta
#standarMariaSan
#for sample in  ${sample_names[@]}
#do
#fastp -i "${sample_name}_1.fastq.gz" -I "${sample_name}_2.fastq.gz" -o "${sample_name}_1_Q.fastp.gz" -O  "${sample_name}_2_Q.fastp.gz" \
#-V -w 5 -q 15 -x --poly_x_min_len=40 -g --poly_g_min_len=10 -l 40 -n 15 -P 20 -p -y -Y 30 -t 5 -T 5 --html="${sample_name}.html" &
#done


##### for any fasta file
####Checar sitnaxis del Output para R1 y R2

for file in *.fastq
do
fastp -i $file -o out\$file
 -V \
 -w 5 \
 -q 17 \
 -g --poly_g_min_len=10 \
 -x --poly_x_min_len=20 \
 -l 50 \
 -n 15 \
 -p -P 20 \
 -y -Y 30 \
 --html=""$file"" 
done






