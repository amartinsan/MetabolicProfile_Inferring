
#/usr/bin/bash
set -e
set -u
set -o pipefail
## Provides:
###1)PATH WHERE THE ASSEMBLIES AND BOWTIE FILES(SORTED) ARE.
###2)FILE WITH THE NAME OF THE BOWTIE FILES OF THE SAMPLES
## Author: María del Carmen Sánchez
## Script to do the binning with metabat
## example usage: bash metabat_binning.sh /path/assemblies/ bowtie_sorted.txt


Spa_cd="_2_QF_Dp_SPa_CDhit.fasta"
Spa="_2_QF_Dp_SPa.fasta"
Mgahit_scaffold="_2_QF_Dp_Mghit_op_scaffold.fasta"
Mghit="_2_Dp_Mghit_op_scaffold.fasta"
Mghit_cd="_metaspades.scaffold.fasta"

cd $1
sample_names=($(cut -f 1 "$2"))

for sample in ${sample_names[@]}
do

name=$(basename -s "Mghit_sorted.bam" ${sample})
echo "ASSIGNNING DEPTH TO SAMPLE: ${name}"
echo "....."
echo "jgi_summarize_bam_contig_depths --outputDepth "${name}_depth" "${name}Mghit_sorted.bam""
jgi_summarize_bam_contig_depths --outputDepth "${name}_depth" "${name}Mghit_sorted.bam"

echo "BINNING"
echo "....."
echo "metabat -i  "${name}$Mgahit_scaffold" -a "${name}_depth" -o "${name}/bins""
metabat -i  "${name}$Mghit_cd" -a "${name}_depth" -o "${name}/bins"

echo "LINEAGE and contamination analysis....."
echo "checkm lineage_wf "${name}/bins" -x .fa "Checkm_${name}""
checkm lineage_wf "${name}" -x .fa "Checkm_${name}"
done
