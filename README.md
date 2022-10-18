
## Generate a pipeline to proceess metagenome samples 

Make a dokcer container with all programs.

And both nextflow main.nf and nextflow.config.


## General idea

### Quality assesment

Instead of fastqc/multiqc and trimmomatic, the idea is to use fastp to filter low quality reads from pair end data.

Also a CD-HIT-DUP pass can be implemented to futher filter, althought it is very time consuming and not always recommended. 

-  [01_fastp.sh](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Process/01_fastp.sh)

 ##### output :
 
 - Quality proceessed seqs ("Q_" prefix)

- quality folder with orignal seqs and .json  and .html outputs of fastqc

### Assembly

Mestaspades or megagit assembly, followed by metaQuast ond contigs and scaffolds.

Also a cd-hit-est pass can be done, althought it takes a good ammount of time.

#### output:

-Directory /s with Q_"SAMPLE NAME"_SPADES_ASSEMBLY or_MEHAGIT_ASSEMBLY

-Two directories: contigs_Quast_"Q_SAMPLE_NAME" and scaffoldQUAST_"Q_SAMPLE_NAME" 

### Binning




## Workflow diagram


![Plot](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/workflow.png)



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
