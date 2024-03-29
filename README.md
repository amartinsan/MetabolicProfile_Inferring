
## A pipeline to process metagenome samples 

## Workflow diagram

![Plot](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Untitled%20Diagram.drawio.png)

# List of programs needed


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

For gene predicition, functional annotation or pipeline manager

-	prodigal https://github.com/hyattpd/Prodigal
-	orfm https://github.com/wwood/OrfM
-	trinnotate https://github.com/Trinotate/Trinotate.github.io/wiki
-	Docker https://www.docker.com/ (already in container)
-	Nextflow  https://www.nextflow.io/ (Managing data flow)

## Docker for reproducibility

The Dockerfile for making a container:

- [Dockerfile](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/dockerpipeline/Dockerfile)

#### example

      docker build -t my_dockerpipeline my_FOLDER/
      
for using the docker you have to use a docker share folder 

     mkdir $PATH/dockershare
     cd $PATH/dockershare       


Run docker example 

      cd $HOME/dockershare
      docker run -it --rm -v $PATH/dockershare:/data  -i /data/"FOLDER WITH SAMPLPES" -o /data/"FOLDER WITH SAMPLES"
      #Check for installed image
      docker images


### Also the container is already ready for download from dockerhub

https://hub.docker.com/r/amartinsan/metagenompipeline


      #You can pull de image from dockerhub, REMEMBER to specifty version or tag (1.0 in this case)
      
       docker pull amartinsan/metagenompipeline:1.0

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


## Other functional assingment strategies

As always, getting the databes is the issue
 
 
#### Blastp against Swiisprot (uniprot) 


 Download : https://www.uniprot.org/help/downloads
 
A regular blastp of the obtained protein_spades.fasta of the assembly.

 
       blastp -query protein_spades.fasta  -db uniprot_sprot.pep  -num_threads $THREADS   -out swissblast.fasta
       
       
 ### Diamond alingment with KEGG db

For diamond the chosen database has to be in a reference format

        /diamond makedb --in reference.fastaCHOSEN-DATABASE -d referenceDB
        
        # running a search in blastp mode
        
        ./diamond blastp -d referenceDB -q protein_spades.fasta -o matches.tsv

### Hmmer of the obtained fasta

Firs the db has to be ini a profile form (recommended uniprot or interpro)

        hmmaling --amino hmmer_profileDATABASE proteins_spades.fasta 


- [Extra_FuncAssingment.sh](https://github.com/amartinsan/MetabolicProfile_Inferring/blob/main/Process/Extra_FuncAssingment.sh)


###############################################################


## Support and Finance

 ### This project has been funded by CONACyT in its Basic Science and/or Frontier Science convening. 
 
 ### Modality: Paradigms and Controversies of Science 2022 
 
 ### Project 319234 awarded to [Dr. Rosa María Gutierrez Ríos](https://www.ibt.unam.mx/perfil/2126/dra-rosa-maria-gutierrez-rios)


#################################################################

 ### Este proyecto ha sido financiado por CONACyT en su Convocatoria de Ciencia Básica y/o Ciencia de Frontera. 
 
 ### Modalidad: Paradigmas y Controversias de la Ciencia 2022 
 
 ### Proyecto 319234 otorgado a la [Dra. Rosa María Gutierrez Ríos](https://www.ibt.unam.mx/perfil/2126/dra-rosa-maria-gutierrez-rios)
 
     

