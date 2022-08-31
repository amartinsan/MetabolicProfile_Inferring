#!/bin/bash
#Name of the JOB
#$ -N QUAST
# OUTPUT AND ERROR STANDAR OUT:
#$ -j y
#$ -o /scratch/mcsanchez/Programas
#no. of threads
#$ -pe thread 32
#Fail for errors.
set -e -o pipefail

#module load programs:
source ~/.bashrc
module load compilers/python-3.6.6

cd $1
#Definition of assemblies to analyze:
FILE1=$(cat $2 | head -n $SGE_TASK_ID| tail -1)
echo $FILE1
num=$(($SGE_TASK_ID + 1))
FILE2=$(cat $2 | head -n $num| tail -1)
echo $FILE2

NAME=$(basename -s ".fasta" "${FILE1}")
Temp=$NAME
mkdir -p $Temp
PATH1=$1/$FILE1
PATH2=$1/$FILE2
cd $Temp
ln -s $PATH1
ln -s $PATH2

#Quast:
metaquast.py ${FILE1} ${FILE2} --threads $NSLOTS -o $Temp
