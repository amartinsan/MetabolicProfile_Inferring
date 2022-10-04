#!/bin/bash

###QUality###
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

##ASSEMBLY###
	#Spades_Assembly
	spades.py --meta -1 $fastq -2 $fastq2 -o $file\_SPADES_ASSEMBLY  -t $NSLOTS -m 250 -k 21,33,55,77,99,111,127 --only-assembler

	#CDHIT-EST for redundancy filter
	cd-hit-est -i $file\_SPADES_ASSEMBLY/contigs.fasta -o $file\_SPADES_ASSEMBLY/contigsCDHIT.fasta -c 0.9 -M 50000 -aS 0.9 -G 0 -l 100 -p 1 -g 1 -T 5

	#MetaQuast for  quality evaluation
	#Contigs
	metaquast.py $file\_SPADES_ASSEMBLY/contigs.fasta -o scaffoldQuast_$file\_FOLDER -t 5
	#Scaffolds
	metaquast.py $file\_SPADES_ASSEMBLY/scaffolds.fasta -o scaffoldQUAST_$file\_FOLDER -t 5


	#MEGAHIT ASSEMBLY make option in nextflow
	#megahit -1 $fastq -2 $fastq2 -t 5 --k-list 21,33,55,77,99,111,127 -o $file\_MEGA_ASSEMBLY


####BINNING###
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
  
  cd ../
  
  ###prodigal###
  prodigal -i $file\_SPADES_ASSEMBLY/contigsCDHIT.fasta -o $file\_SPADES_ASSEMBLY/spades.genes -a $file\_SPADES_ASSEMBLY/protein_spades.fasta -p meta

	mkdir $file\_SPADES_ASSEMBLY/prodigal
	mv $file\_SPADES_ASSEMBLY/spades.genes $file\_SPADES_ASSEMBLY/prodigal/
	mv $file\_SPADES_ASSEMBLY/protein_spades.fasta $file\_SPADES_ASSEMBLY/prodigal/
  
  
  
 ###ASSINGMENT###
 
DB=DB
CLU=clu
SEQ=seq
FAS=fasta
GEN=genes

#IN AGORA
#RUTA=/hd1/msanchez/Programas/mmseqs/bin/



	cd $file\_SPADES_ASSEMBLY/prodigal
	pwd=$(pwd)

/mmseqs createdb protein_spades.fasta $pwd/$file\_$DB
	mmseqs cluster $file\_$DB $file\_$DB\_$CLU  -c 0.95 --min-seq-id 0.95 --cov-mode 1 --cluster-mode 2 tmp --threads 5
	mmseqs createseqfiledb  $file\_$DB $file\_$DB\_$CLU $file\_$DB\_$CLU\_$SEQ
	mmseqs result2flat $file\_$DB $file\_$DB $file\_$DB\_$CLU\_$SEQ $file\_$DB\_$CLU\_$SEQ\.$FAS
	rm -r tmp
	#install database in serve from apart
  emapper.py --cpu 10 --data_dir /data/databases/eggnog_db -i $file\_$DB\_$CLU\_$SEQ\.$FAS --itype proteins -o $file\_$DB\_$CLU\_$SEQ\.$FAS\_$GEN

