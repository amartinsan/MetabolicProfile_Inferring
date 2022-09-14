#!/bin/bash


for file in *R1.fastq
do

       # NSLOTS=5
        fastq=$file
        #get R2 from R1 (derive)
        fastq2="${fastq/R1/R2}"

        #Assembly



megahit -1 $fastq -2 $fastq2 -t 5 --k-list 21,33,55,77,99,111,127 -o $file\_MEGA_ASSEMBLY

done
