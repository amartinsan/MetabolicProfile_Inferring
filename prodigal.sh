
#!/usr/bin/bash
set -e
set -u
set -o pipefail
#################
##María del Carmen Sánchez may-2022
##Provide:
##1) file with name of the assmblies to analyze:
##2)path where the files are
#################

files=$(cut -f 1 "$1")
for name in ${files[@]}
do
echo "Analizando muestra...."${name}""
#echo "gunzip "${file}""
#gunzip "${file}"
#name=$(basename -s ".gz" "${file}")
echo "prodigal -i "${name}" -o "${name}".genes -a "${name}".proteins -d "${name}".nt -f "${name}".gbk  -p meta"
prodigal -i "${name}" -o "${name}".genes -a "${name}".proteins -d "${name}".nt -p meta
gzip "${name}"
done
