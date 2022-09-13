#!/bin/bash


#contigs
metaquast.py SPADES_ASSEMBLY/contigs.fasta -o METAQUAST -t 5
#Scaffolds
metaquast.py SPADES_ASSEMBLY/scaffolds.fasta -o METAQUAST2 -t 5
