
#!/usr/bin/bash
set -u
set -e
set -o pipefail
#################
##María del Carmen Sánchez may_2022
##Provide:
##1) file with names as a list of the predicted_cds in fasta format
##2)path where the files are
#################
DONDE=$2
cd $DONDE
PATH_MMSESQ2=/hd1/msanchez/Programas/mmseqs/bin/
DB=_DB
CLU=_clu
SEQ=_seq
FAS=.fasta
GEN=_genes
files=$(cut -f 1 "$1")
for file in ${files[@]}
do
        name=$(basename -s ".fa.nt" "${file}")
        echo "Analizing sample: "${name}""
        echo "$PATH_MMSESQ2./mmseqs createdb "${file}" "${name}$DB""
        $PATH_MMSESQ2./mmseqs createdb "${file}" "${name}$DB"
        echo "........"
        echo "$PATH_MMSESQ2./mmseqs cluster "${name}$DB" "${name}$DB$CLU" -c 0.95 --min-seq-id 0.95 --cov-mode 1 --cluster-mode 2 tmp"
        $PATH_MMSESQ2./mmseqs cluster "${name}$DB" "${name}$DB$CLU" -c 0.95 --min-seq-id 0.95 --cov-mode 1 --cluster-mode 2 tmp --threads 32
        echo "$PATH_MMSESQ2./mmseqs createseqfiledb "${name}$DB" "${name}$DB$CLU" "${name}$DB$CLU$SEQ""
        $PATH_MMSESQ2./mmseqs createseqfiledb "${name}$DB" "${name}$DB$CLU" "${name}$DB$CLU$SEQ"
        echo "$PATH_MMSESQ2./mmseqs result2flat "${name}$DB" "${name}$DB" "${name}$DB$CLU$SEQ" "${name}$DB$CLU$SEQ$FAS""
        $PATH_MMSESQ2./mmseqs result2flat "${name}$DB" "${name}$DB" "${name}$DB$CLU$SEQ" "${name}$DB$CLU$SEQ$FAS"
        rm -r tmp
        echo "emapper.py --cpu 32 --data_dir /data/databases/eggnog_db -i "${name}$DB$CLU$SEQ$FAS" --itype CDS -o "${name}$DB$CLU$SEQ$FAS$GEN""
        emapper.py --cpu 32 --data_dir /data/databases/eggnog_db -i "${name}$DB$CLU$SEQ$FAS" --itype CDS -o "${name}$DB$CLU$SEQ$FAS$GEN"
        echo "Finishing sample $name"
done

