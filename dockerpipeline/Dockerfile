###INSTALL ALL DEPENDENCIES AND NEEDED PROGRAMS IN ONE CONTAINER
FROM continuumio/miniconda

#INSTALL fastp, mehagit, diamond and conda programs
RUN conda install -c bioconda fastp --yes
RUN conda install -c bioconda megahit --yes
RUN conda install -c bioconda diamond -yes 
RUN conda install -c bioconda hmmer --yes 

## For diamond it can be pulled from docker
#docker pull buchfink/diamond

#INSTALL metaspades

RUN wget http://cab.spbu.ru/files/release3.15.5/SPAdes-3.15.5-Linux.tar.gz && \
    tar -xzf SPAdes-3.15.5-Linux.tar.gz && \
    cd SPAdes-3.15.5-Linux/bin/

#INSTALL mmseq
#unzip and add the bin directory to your PATH
RUN wget -O mmseq-latest.zip https://github.com/eturro/mmseq/archive/latest.zip && \
unzip mmseq-latest.zip && cd mmseq-latest && \
export PATH=`pwd`/bin:$PATH && \
cd bin && \
for f in `ls *-linux`; do
  mv $f `basename $f -linux`
done
