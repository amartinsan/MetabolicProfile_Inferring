#!/bin/bash
#author: María del Carmen Sánchez (cluster)
## Provide:
## 1) Path where the files are.
## 2) Name of the file that have a list of the libraries of DNA to analyze. (forward and reverse)
## 3) Types of files to process: 1 -fasta, 2-fasta.gz, 3-fastq and 4-fastq.gz

#Command example to use in the cluster:
## qsub -R y -l h_rt=23:59:59 -t 1-4 Clu_assem_spades.sh  /scratch/mcsanchez/Data/ libraries.txt 4

# Name of the job
#$ -N  Clu_assem_spades
#$ -l h_vmem=30G #how much memory do use to do the assembly
# Stderr (output and standard error) in the same dircetory: 
#$ -j y
#$ -o /scratch/mcsanchez/Programas
#Number of threads to use:
#$ -pe thread 32

#Loading programs:
source ~/.bashrc
source /share/apps/Profiles/share-profile.sh
module load programs/spades-3.14.0

if [ $# -ge 3 ]; then
cd $1


C='_SPa'
FAS='.fasta'
FASQ='.fastq'
TEM='_temp'
T='_tmp'
STR=''

#Definition of files:
FILE2=$(cat $2 | head -n $SGE_TASK_ID| tail -1)
echo $FILE2
num=$(($SGE_TASK_ID + 1))
FILE1=$(cat $2 | head -n $num| tail -1)
echo $FILE1


if [ $3 -eq 1 ]; then
TYPE='.fasta'
TYPEF='.fasta'
elif  [ $3 -eq 2 ]; then
TYPE='.fasta.gz'
TYPEF='.fasta'
elif  [ $3 -eq 3 ]; then
TYPE='.fastq'
TYPEF='.fastq'
else
TYPE='.fastq.gz'
TYPEF='.fastq'
fi

FL=${FILE1/$TYPE/$STR} # Just take the name without extensions.
echo $FL
echo "   "


echo "ASSEMBLING READS..."
FLR=$FL$C
OUT=./$FLR
echo "spades.py --meta  -1 $FILE2 -2 $FILE1 -o $OUT --disable-gzip-output -t $NSLOTS -m 250 -k  21,33,55,77,99,111,127"
spades.py --meta -1 $FILE2 -2 $FILE1 -o $OUT --disable-gzip-output -t $NSLOTS -m 250 -k  21,33,55,77,99,111,127 --only-assembler #21,31,41,51 (Illumina 75bp)
if [ $? -eq 0 ]
then
cat $OUT/K*/final_contigs.fasta >$FL$C$T$FAS
echo "Numero de contigs ensamblados:"
grep -c ^'>' $FL$C$T$FAS
echo "End"
fi

fi
