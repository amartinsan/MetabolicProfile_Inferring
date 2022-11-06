
#!/usr/bin/bash

DB=DB
CLU=clu
SEQ=seq
FAS=fasta
GEN=genes

for file in *R1.fastq
do

RUTA=/hd1/msanchez/Programas/mmseqs/bin/

	cd $file\_SPADES_ASSEMBLY/prodigal
	pwd=$(pwd)

	$RUTA/mmseqs createdb protein_spades.fasta $pwd/$file\_$DB
	$RUTA/mmseqs cluster $file\_$DB $file\_$DB\_$CLU  -c 0.95 --min-seq-id 0.95 --cov-mode 1 --cluster-mode 2 tmp --threads 5
	$RUTA/mmseqs createseqfiledb  $file\_$DB $file\_$DB\_$CLU $file\_$DB\_$CLU\_$SEQ
	$RUTA/mmseqs result2flat $file\_$DB $file\_$DB $file\_$DB\_$CLU\_$SEQ $file\_$DB\_$CLU\_$SEQ\.$FAS
	rm -r tmp
	emapper.py --cpu 10 --data_dir /data/databases/eggnog_db -i $file\_$DB\_$CLU\_$SEQ\.$FAS --itype proteins -o $file\_$DB\_$CLU\_$SEQ\.$FAS\_$GEN
	
	#move files for easier search
	
	mkdir emmaperRESULTS
	mv  $file\_$DB\_$CLU\_$SEQ\.$FAS\_$GEN emmaperRESULTS/
	

done
