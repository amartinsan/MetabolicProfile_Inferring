#!/usr/bin/bash
set -e
set -u
set -o pipefail

## Author: María del Carmen Sánchez
## Provide:
## 1) File with the names of the assemblies

FILE=$1
names=($(cut -f 1 | uniq $FILE))
for sample in ${names[@]}
do
echo "${sample}"
echo "metaphlan  "${sample}" --input_type  fasta -o  "${sample}.txt""
metaphlan  "${sample}" --input_type  fasta -o  "${sample}.txt"
done
