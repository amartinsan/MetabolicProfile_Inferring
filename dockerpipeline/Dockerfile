
FROM ubuntu
#unzip and add the bin directory to your PATH
RUN  apt-get update
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN wget -O mmseq-latest.zip https://github.com/eturro/mmseq/archive/latest.zip && \
unzip mmseq-latest.zip && cd mmseq-latest && \
export PATH=`pwd`/bin:$PATH && \
cd bin && \
for f in `ls *-linux`; do mv $f `basename $f -linux`; done
ENTRYPOINT ["mmseqs"]

FROM continuumio/miniconda

#INSTALL fastp, mehagit, diamond and conda programs

RUN conda install -c "bioconda/label/main" fastp --yes
RUN conda install -c bioconda megahit --yes
RUN conda install -c bioconda spades --yes
RUN conda install -c bioconda cd-hit --yes
RUN conda install -c bioconda quast --yes
RUN conda install -c bioconda bwa --yes
RUN conda install -c bioconda samtools --yes
RUN conda install -c bioconda metabat2 --yes
RUN conda install -c bioconda prodigal --yes
RUN conda install -c bioconda mmseqs2 --yes
RUN conda install -c bioconda eggnog-mapper --yes
RUN conda install -c bioconda checkm-genome --yes
RUN conda update -n base -c defaults conda --yes
