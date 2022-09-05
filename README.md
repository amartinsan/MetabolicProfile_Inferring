
## Generate a pipeline to proceess metagenome samples 

Maybe all scripts in a Docker container app or a process in nextflow or even snakemake



![Plot](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Diagram.png)



# List of program  needed

Half the battle is having the right tools

## Quality and filter

- fastp https://github.com/OpenGene/fastp
-	CD-Hit  http://weizhong-cluster.ucsd.edu/cd-hit/

## Assembly and binning

-	megahit https://github.com/voutcn/megahit

-	metaspades https://github.com/ablab/spades#sec2

-	MetaQuast http://quast.sourceforge.net/metaquast

-	DAStool https://anaconda.org/bioconda/das_tool

-	Metabat https://bitbucket.org/berkeleylab/metabat/src/master/

 
## Functional Assingment 

-	mmaper http://eggnog-mapper.embl.de
-	diamond https://github.com/bbuchfink/diamond
-	hmmer  https://github.com/EddyRivasLab/hmmer

## Mapping of reads to contigs

•	bowtie2 http://bowtie-bio.sourceforge.net/bowtie2/index.shtml

## Extras

For gene predicition, functional annotatino or pipeline manager

-	prodigal https://github.com/hyattpd/Prodigal
-	orfm https://github.com/wwood/OrfM
-	trinnotate https://github.com/Trinotate/Trinotate.github.io/wiki
-	Docker https://www.docker.com/
-	Nextflow  https://www.nextflow.io/
