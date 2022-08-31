#!/usr/bin/env python
##Provide:
#1) file with the equivalence genes in this case salida_equivalne_wp_gene.txt
#2) the file with protein id and count for every sample:
#HOW to use it :python convert_proteinid_gene.py salida_equivalen_wp_gene.txt Frc1.sf
# Author: María del Carmen Sánchez
import getopt
import sys
from tempfile import TemporaryFile
outfile = TemporaryFile()
argv=sys.argv[2:]
try:
    opts, args = getopt.getopt(argv, 'hm:d', ['help', 'my_file='])
except getopt.GetoptError:
    print('Something went wrong!')
    sys.exit(2)
file_base = sys.argv[1]
file_convert=sys.argv[2]
name=file_convert.split('.sf')
name=name[0]
list_base=[]
list_protein_id=[]
with open(file_base) as f1, open(file_convert) as f2:
    for line in f1.readlines():
        line = line.strip()
        line =line.split('\t')
        protein_id=line[2]
        #print (protein_id)
        gene=line[1]
        #print (gene)
        id=line[0]
        list_base.append(protein_id)
        list_base.append(gene)
    for line in f2.readlines():
        line = line.strip()
        line = line.split('\t')
        protein_id = line[0]
        protein_id =protein_id.split('.1')
        protein_id=protein_id[0]+".1"
        #print (protein_id)
        count=line[1]
        #print (count)
        list_protein_id.append(protein_id)
        list_protein_id.append(count)

with open(name+"_convert.sf",'w') as out:
    out.write("Gene\t %s\n" %name)
    for i in range(0,len(list_base)):
        #print (list_base[i])
        for j in range(0,len(list_protein_id)):
            #print (list_protein_id[j])
            if list_base[i] == list_protein_id[j]:
                if list_base[i+1] == 'no_name':
                    out.write("%s\t%s\n" %(list_base[i],list_protein_id[j+1]))
                else:
                    out.write("%s\t%s\n" %(list_base[i+1],list_protein_id[j+1]))
