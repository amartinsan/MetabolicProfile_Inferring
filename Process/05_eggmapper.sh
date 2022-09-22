
#!/usr/bin/bash


PATH=/hd1/msanchez/Programas/mmseqs/bin/

DB=_DB
CLU=_clu
SEQ=_seq
FAS=.fasta
GEN=_genes

for file in *R1.fastq
do



	cd $file\_SPADES_ASSEMBLY/prodigal

	$PATH/mmseqs createdb protein_spades.fasta $file\_$DB
	$PATH/mmseqs cluster $file\_$DB $file\_$DB$CLU  -c 0.95 --min-seq-id 0.95 --cov-mode 1 --cluster-mode 2 tmp --threads 5
	$PATH/mmseqs createseqfiledb  $file\_$DB $file\_$DB$CLU $file\_$DB$CLU$SEQ
	$PATH/ result2flat $file\_$DB $file\_$DB $file\_$DB$CLU$SEQ $file\_$DB$CLU$SEQ$FAS
	rm -r tmp
	emapper.py --cpu 5 --data_dir /data/databases/eggnog_db -i $file\_$DB$CLU$SEQ$FAS --itype CDS -o $file\_$DB$CLU$SEQ$FAS$GEN


done
