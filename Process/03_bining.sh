#!/bin/bash


#make index files
	#Can also use bbmaper

	#define prefix

for file in *R1.fastq
do

        NSLOTS=5
        fastq=$file
        #get R2 from R1 (derive)
        fastq2="${fastq/R1/R2}"


	cd $file\_SPADES_ASSEMBLY

	bwa index contigsCDHIT.fasta -p bwa-
	bwa mem bwa- ../$file ../$file2 > output.sam
	samtools sort output.sam -o output.bam
	samtools index  output.bam
	#Make depth file
	jgi_summarize_bam_contig_depths --outputDepth depth output.bam
	metabat -i  contigs.fasta  -a depth -o binning
	#Run metabatat with index
	#runMetaBat.sh -m 1500 contigs.fasta output.bam -o bins
	mkdir bwaOUT
	mv bwa-* bwaOUT


done
