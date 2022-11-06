
## A pipeline to proceess metagenome samples 

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

## Blastp with  Swissprot database

 Download : https://www.uniprot.org/help/downloads
 
 
 Command for protein_spades.fasta (output of assembly and prodigal).
 
       blastp -query protein_spades.fasta  -db uniprot_sprot.pep  -num_threads $THREADS   -out swissblast.fasta

### Can be done useing DIAMOND with KEGG or other DB and HMMER alingment also

For diamond the chosen database has to be in a reference format

        /diamond makedb --in reference.fastaCHOSEN-DATABASE -d reference
        # running a search in blastp mode
        ./diamond blastp -d reference -q queries.fasta -o matches.tsv

For hmmer the database has to be in a profile form 

## Docker for reproducibility

The Dockerfile for making a container

#### example

      docker build -t my_dockerpipeline my_FOLDER/
      
for using the docker you have to use a docker share folder 

     mkdir $PATH/dockershare
     cd $PATH/dockershare       


Run docker example 

      cd $HOME/dockershare
      docker run -it --rm -v $PATH/dockershare:/data  -i /data/"FOLDER WITH SAMPLPES" -o /data/"FOLDER WITH SAMPLES"


## General idea

### Quality assesment

Instead of fastqc/multiqc and trimmomatic, the idea is to use fastp to filter low quality reads from pair end data.

Also a CD-HIT-DUP pass can be implemented to futher filter, althought it is very time consuming and not always recommended. 

-  [01_fastp.sh](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Process/01_fastp.sh)

 ##### output :
 
 - Quality proceessed seqs with a "Q_" prefix 

- quality folder with orignal seqs and .json  and .html outputs of fastqc quality metrics

### Assembly

Mestaspades or megagit assembly, followed by metaQuast ond contigs and scaffolds.

Also a cd-hit-est pass can be done, althought it takes a good ammount of time (not recomended).

- [02_assembly.sh](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Process/02_assembly.sh)


#### output:

- Directory named : Q_"SAMPLE NAME"_SPADES_ASSEMBLY or_MEHAGIT_ASSEMBLY 
 
 It contains the assembly results.

- Directory named: contigs_Quast_"Q_SAMPLE_NAME" 

It contains the metrics of MetaQuast for the assembly.

### Binning

Taking the output of the assembly (scaffolds) and uses bowtie2 to generate the index, .sam and .bam files necessary for the binning with metabat.

Also it uses checkm to check the quality of the bins. 

- [03_bining.sh](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Process/03_bining.sh)


#### output:

##### All the results are inside the assembly folder.

- bowtieINDEX folder with bowtie results.

- scaffolds.sort.bam (and sam) and stats.

- bins folder with assembled bins.

### Gene prediction 

Using the contigs.fasta file from the assembly and the program Prodigal.

- [04_prodigal.sh](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Process/04_prodigal.sh)

#### output:

##### All the results are inside the assembly folder.

- prodigal folder with the predicted proteins and genes.

### Functional assingment 

This it where it gets tricky, depending on the program and database used.

Here we are using mmseq2 with eggNOG emapper. It uses the protein_spades.fasta file from the Prodigal prediction

- [05_eggmapper.sh](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Process/05_eggmapper.sh)
