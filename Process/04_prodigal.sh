#!/bin/bash


for file in *R1.fastq
do
	prodigal -i $file\_SPADES_ASSEMBLY/contigs.fasta -o $file\_SPADES_ASSEMBLY/spades.genes -a $file\_SPADES_ASSEMBLY/protein_spades.fasta -p meta

	mkdir $file\_SPADES_ASSEMBLY/prodigal
	mv $file\_SPADES_ASSEMBLY/spades.genes $file\_SPADES_ASSEMBLY/prodigal/
	mv $file\_SPADES_ASSEMBLY/protein_spades.fasta $file\_SPADES_ASSEMBLY/prodigal/


done
