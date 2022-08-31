#!/bin/bash
set -e
set -u
set -o pipefail
## Author: Maria del Carmen Sanchez
#####
## Script for mapping reads with bowtie
##1) PATH WHERE READS AND ASSEMBLIES ARE e.g /home/maria/Data/Referencias
##2) FILE WITH only the forward name of the libraries 
##This program is to generate alignments for the reads and their assemblies and assign coverage per contig
#example: bash bowtie_cov.sh /home/maria/Data/Referencias/Duplicdos samples.txt
#####

cd $1
MSpad='_metaspades.scaffold.fasta'
Spa='_2_QF_Dp_SPa.fasta'
B='Bw'
IN='index'
Mghit='Mghit'
S='.sam'
BAM='.bam'
SORT='_sorted'
INX='_index'
STAT='_cov'
TXT='.txt'

sample_names=($(cut -f 1 "$2"))
for sample in ${sample_names[@]}
do
sample_name=$(basename -s "_1_Dp.fastq.gz" ${sample})
echo "Alineando muestra: ${sample_name}"
echo "INDEXING"
echo "bowtie2-build --threads 16 -q "${sample_name}$MG"  "${sample_name}$Mghit$B$IN""
bowtie2-build --threads 16 -q "${sample_name}$MG"  "${sample_name}$Mghit$B$IN"

echo "MAPPING"
echo "bowtie2 --very-sensitive -t --sam-no-qname-trunc -x "${sample_name}"$Mghit$B$IN -1 "${sample_name}_1_QF_Dp.fastq" -2 "${sample_name}_2_QF_Dp.fastq" -S "${sample_name}$Mghit$S" --threads 32 "
bowtie2 --very-sensitive -t --sam-no-qname-trunc -x "${sample_name}$Mghit$B$IN" -1 "${sample_name}_1_Dp.fastq.gz" -2 "${sample_name}_2_Dp.fastq.gz" -S "${sample_name}$Mghit$S" --threads 32

if [ $? -eq 0 ]
then
echo "SAMTOOLS"
echo "samtools view -bS "${sample_name}$Mghit$S" > "${sample_name}$Mghit$BAM""
samtools view -bS "${sample_name}$Mghit$S" > "${sample_name}$Mghit$BAM"
echo "samtools sort "${sample_name}$Mghit$BAM" -o  "${sample_name}$Mghit$SORT$BAM""
samtools sort "${sample_name}$Mghit$BAM" -o  "${sample_name}$Mghit$SORT$BAM"
echo "samtools index -m "${sample_name}$Mghit$SORT$BAM" "
samtools index  "${sample_name}$Mghit$SORT$BAM"
echo "samtools idxstats "${sample_name}$Mghit$SORT$BAM" > "${sample_name}$Mghit$SORT$STAT$BAM""
samtools idxstats "${sample_name}$Mghit$SORT$BAM" > "${sample_name}$Mghit$SORT$STAT$TXT"
rm -r *.bt2
else
echo "Error en Bowtie!!"
fi

done
