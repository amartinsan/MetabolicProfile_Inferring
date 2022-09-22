#!/bin/bash
#Quality check and filter to sample fasta
#############Process 1###########

##### for any fasta file
#!!!!!!!IMPORANTE PROCESAR COMO PAIR-END para evitar fastq con difernte numero de secuencias!!!!!!!!#

RUTA='/hd1/amartinsan/MetaINFER/MetabolicProfile_Inferring/Process'

#for file in $RUTA/*.fastq
for file in *.fastq
do
        fastq=$file
        #get R2 from R1 (derive)
        fastq2="${fastq/R1/R2}"


	fastp -i $fastq -I $fastq2 -o Q_$fastq -O Q_$fastq2 \
 		-V \
 		-q 17 \
 		-g --poly_g_min_len=10 \
 		-x --poly_x_min_len=20 \
 		-l 50 \
 		-n 15 \
 		-p -P 20 \
 		-y -Y 30 \
		-w 5 \
		--json=""$file".json" \
 		--html=""$file".html"
done

#Filter f duplicate sequences, PCR product or optical duplicates.
#WE NEED cd-hit-dup for pair end data
#for file in Q_*
#do
#
#	cd-hit -i $file -o CD-$file -c 1.00 -T 5

#done

mkdir quality
mv *json quality/
mv *html quality/
mv *.fastq quality/
#mv quality/CD-* .
mv *clstr quality/
mv quality/Q_* .

#Final
