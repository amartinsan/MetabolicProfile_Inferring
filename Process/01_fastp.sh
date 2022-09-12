#!/bin/bash





#Quality check and filter to sample fasta
#Process 1

##### for any fasta file
####Checar sintaxis para pair-end cambia si se procesan aparte o solo es para  tener ambos pares en un archivo?####

RUTA='/hd1/amartinsan/MetaINFER/MetabolicProfile_Inferring/Process'

#for file in $RUTA/*.fastq
for file in *.fastq
do

	fastp -i $file -o $file\_out.fastq \
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
for file in *_out.fastq
do

	cd-hit -i $file -o noDUP-$file -c 1.00 -T 5

done

#Final
