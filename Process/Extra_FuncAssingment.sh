#!/usr/bin/bash

for file in *R1.fastq
do

	cd $file\_SPADES_ASSEMBLY/prodigal
  
  #blast
  blastp    blastp -query protein_spades.fasta  -db uniprot_sprot.pep  -num_threads $THREADS   -out swissblast_assingment.fasta
  #Diamond
  ./diamond blastp -d referenceDB -q protein_spades.fasta -o diamond_assingment_matches.tsv
  #hmmer
   hmmaling --amino hmmer_profileDATABASE proteins_spades.fasta 
  
done
