#!/bin/bash


#make index files
	#Can also use bbmaper

	#define prefix

for file in *R1.fastq
do
	cd $file\_SPADES_ASSEMBLY

	bwa index contigs.fasta -p bwa-
	bwa mem bwa- ../out.Sample_soil_R1.fastq ../out.Sample_soil_R2.fastq > output.sam
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
