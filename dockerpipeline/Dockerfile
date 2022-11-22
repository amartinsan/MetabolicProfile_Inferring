########################

#The objective is to get the all of the desired programs in one docker container for an easy set up in another system

#For practical issues almost all of the programs will be installed by conda

FROM ubuntu
#unzip and add the bin directory to your PATH
RUN  apt-get update
RUN apt-get install -y wget
RUN apt-get install -y unzip

#MMSEQ needs to be installed by wget and conda so it does not crash

RUN wget -O mmseq-latest.zip https://github.com/eturro/mmseq/archive/latest.zip && \
unzip mmseq-latest.zip && cd mmseq-latest && \
export PATH=`pwd`/bin:$PATH && \
cd bin && \
for f in `ls *-linux`; do mv $f `basename $f -linux`; done
ENTRYPOINT ["mmseqs"]


#Conda for easy install
FROM continuumio/miniconda

#All of the programs for the whole pipeline
#fastp main because of "versions"

RUN conda install -c "bioconda/label/main" fastp --yes
RUN conda install -c bioconda megahit --yes
RUN conda install -c bioconda spades --yes
RUN conda install -c bioconda cd-hit --yes
RUN conda install -c bioconda quast --yes
RUN conda install -c bioconda bowtie2 --yes
RUN conda install -c bioconda samtools --yes
RUN conda install -c bioconda metabat2 --yes
RUN conda install -c bioconda prodigal --yes
RUN conda install -c bioconda mmseqs2 --yes
RUN conda install -c bioconda eggnog-mapper --yes
RUN conda install -c bioconda checkm-genome --yes
RUN conda update -n base -c defaults conda --yes

#Extra programs, for comparing annotation with other programs

RUN conda install -c bioconda blast --yes
RUN conda install -c bioconda diamond --yes
RUN conda install -c bioconda hmmer --yyes
#EXTRAS for testing not necessarily used in the original pipeline

#RUN conda install -c bioconda trinotate --yes
#RUN conda install -c bioconda prokka --yes
#RUN conda install -c bioconda kraken2 --yes
#RUN conda install -c bioconda metaphlan --yes
#RUN conda install -c bioconda graphlan --yes
