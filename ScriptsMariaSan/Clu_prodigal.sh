#!/bin/bash
## María del Carmen Sánchez 
#Nombre del job
#$ -N Prodigal

#Interrumpir por errores
set -e -o pipefail

#Cargar programa
source $HOME/.bashrc
module load programs/prodigal-2.6.3

#definir ensambles a analizar
ENS_SPADES=/home/mcsanchez/ERR1730306_contigs_spades.fasta
ENS_MEGAHIT=/home/mcsanchez/ERR1730306_final_contigs.fa

Temp=$HOME/Anotaciones_prodigal
mkdir -p $Temp
cd $Temp
ln -s $ENS_SPADES
ln -s $ENS_MEGAHIT

#Ejecutar Prodigal:
prodigal -i $ENS_SPADES -o spades.genes  -a my.proteins_spades.faa -p meta
prodigal -i $ENS_MEGAHIT -o megahit.genes -a my_proteins_megahit.faa -p meta
