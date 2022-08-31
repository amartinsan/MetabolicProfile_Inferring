#!/bin/bash
## Author:María del Carmen Sánchez
## Script to download SRA files from SRAdb with fasterq-dump
## Provide:
## 1) File with the SRA id
set -e
set -u
set -o pipefail

samples=$1
sample_files=($(cut -f 1 "$samples"))
for sample in ${sample_files[@]}
do
        echo "${sample}"
        fasterq-dump $sample -O /home/msanchez/SRA_FILES_METAGENOMES/ -t /home/msanchez/SRA_FILES_METAGENOMES/tmp -e 15
done
