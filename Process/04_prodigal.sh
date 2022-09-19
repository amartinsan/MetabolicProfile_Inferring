#!/bin/bash


for file in *R1.fastq
do
	prodigal -i $file\_SPADES_ASSEMBLY/contigsCDHIT.fasta -o $file\_SPADES_ASSEMBLY/spades.genes -a $file\_SPADES_ASSEMBLY/protein_spades.fasta -p meta

	mkdir $file\_SPADES_ASSEMBLY/prodigal
	mv $file\_SPADES_ASSEMBLY/spades.genes prodigal
	mv $file\_SPADES_ASSEMBLY/protein_spades.fasta prodigal


done
