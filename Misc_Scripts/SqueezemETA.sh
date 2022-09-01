#!/bin/bash
#$ -N  squeeze_metaEFASTA


source PATH=/share/apps/SqueezeMeta/bin/:$PATH

#Define threads

SqueezeMeta.pl \
-m coassembly \
-c 1000 \
-p FOLDER_OUT_NAME \
-s sample.file \
-f /fastafile/PATH/ \
-t $NSLOTS \
--D

