#!/bin/bash
#make index files

for file in *1.fastq.gz
do

        NSLOTS=5
        fastq=$file
        #get R2 from R1 (derive)
        fastq2="${fastq/_1/_2}"

	cd $file\_SPADES_ASSEMBLY
	
	bowtie2-build scaffolds.fasta scaffolds.fasta.index 
	bowtie2 --very-sensitive -t --sam-no-qname-trunc -x scaffolds.fasta.index -1 ../$file -2 ../$file2 -S scaffolds.sam --threads 15
	samtools view -bS scaffolds.sam -o scaffolds.bam
	samtools sort scaffolds.bam -o  scaffolds.sort.bam
	samtools index scaffolds.sort.bam
	#Get stats
	samtools idxstats  contigs.sort.bam > contigs.sort_STATS.txt
	#move or delete intermediate files
	mkdir bowtieINDEX
	mv *.bt2 bowtieINDEX/
	jgi_summarize_bam_contig_depths --outputDepth depth contigs.sort.bam
	metabat -i  contigs.fasta  -a depth -o binning
	#runMetaBat.sh -m 1500 contigs.fasta contigs.sort.bam -o bins
	
	#CHECKM
	#checkm lineage_wf bins -x .fa checkm_bins

done


