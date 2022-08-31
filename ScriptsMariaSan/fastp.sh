#!/bin/bash
set -e
set -u
set -o pipefail
#Author: María del Carmen Sánchez
##Provide:
###1) The file with the name of  paired-end libraries
## example use: fastp.sh libraries.txt

sample_names=($(cut -f 1 "$1"))

for sample in ${sample_names[@]}
do
sample_name=$(basename -s ".fastq.gz" ${sample})
path=$2
cd $path
echo "Cleaning sample: ${sample_name}"

nohup /hd1/msanchez/Programas/./fastp -i "${sample_name}_1.fastq.gz" -I "${sample_name}_2.fastq.gz" \
-o "${sample_name}_1_Q.fastp.gz" -O  "${sample_name}_2_Q.fastp.gz" \
 -V -w 5 -q 15 -x --poly_x_min_len=40 -g --poly_g_min_len=10 -l 40 -n 15 -P 20 -p -y -Y 30 -t 5 -T 5 --html="${sample_name}.html" &
done
