
#!/bin/bash
#assembly and qualitycheck

for file in *1.fastq.gz
do
	#if necessary NSLOTS
	NSLOTS=5
	fastq=$file
	#get R2 from R1 (derive)
	fastq2="${fastq/_1/_2}"

	#Spades_Assembly
	spades.py --meta -1 $fastq -2 $fastq2 -o $file\_SPADES_ASSEMBLY  -t $NSLOTS -m 250 -k 21,33,55,77,99,111,127 --only-assembler

	#CDHIT-EST for redundancy filter
	#cd-hit-est -i $file\_SPADES_ASSEMBLY/contigs.fasta -o $file\_SPADES_ASSEMBLY/contigsCDHIT.fasta -c 0.9 -M 50000 -aS 0.9 -G 0 -l 100 -p 1 -g 1 -T 20
	
	#MetaQuast for  quality evaluation
	#Contigs
	metaquast.py $file\_SPADES_ASSEMBLY/contigs.fasta -o scaffoldQuast_$file\_FOLDER -t 5
	#Scaffolds
	metaquast.py $file\_SPADES_ASSEMBLY/scaffolds.fasta -o scaffoldQUAST_$file\_FOLDER -t 5
	
	#MEGAHIT ASSEMBLY make option in nextflow
	#megahit -1 $fastq -2 $fastq2 -t 5 --k-list 21,33,55,77,99,111,127 -o $file\_MEGA_ASSEMBLY

done
