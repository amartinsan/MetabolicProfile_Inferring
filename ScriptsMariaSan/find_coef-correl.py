#!/usr/bin/env python
##Provide:
###1)file with the names of the files to compare ec_enzymes and find the intersection
##Author: María del Carmen Sánchez

import sys
import getopt
from itertools import izip
from tempfile import TemporaryFile
from scipy import stats
import numpy as np
outfile = TemporaryFile()
argv=sys.argv[1:]
try:
    opts, args = getopt.getopt(argv, 'hm:d', ['help', 'my_file='])
    #print(args)
except getopt.GetoptError:
    # Print a message or do something useful
    print('Something went wrong!')
    sys.exit(2)
file=argv
file_name=file[0] ##get the name of the file because arg is a list.
list_file=[]
lista_ec_f1=[]
lista_order_f1=[]
lista_ec_f2=[]
lista_order_f2=[]
intersection_list=[]

with open (file_name,"r") as INPUTFILE:
    for line in INPUTFILE.readlines():
        line=line.strip()
        list_file.append(line)
def grouped(iterable, n):
    return izip(*[iter(iterable)]*n)
for x, y in grouped(list_file, 2):
    name= x.split("_")
    name=name[0]
    print (name)
    name1 = x.split("_genes_")
    name2 = y.split("_genes_")
    name1=name1[0]
    name2=name2[0]
    print (name1)
    print (name2)
    with open(x) as f1,open(y) as f2:
        print (x,y)
        for line in f1.readlines():
            line=line.strip()
            line=line.split("\t")
            order=line[3]
            EC=line[1]
            lista_ec_f1.append(EC)
            lista_order_f1.append(EC)
            lista_order_f1.append(order)
        for line in f2.readlines():
            line = line.strip()
            line = line.split("\t")
            order = line[3]
            EC = line[1]
            lista_ec_f2.append(EC)
            lista_order_f2.append(EC)
            lista_order_f2.append(order)


    def intersection(lst1, lst2):
        return list(set(lst1) & set(lst2))
    intersection_out= intersection(lista_ec_f1,lista_ec_f2)
    print (len(intersection_out))
    salida_f1=[]
    salida_f2=[]

    for i in range(0,len(lista_order_f1)):
        for j in range(0,len(intersection_out)):
            if intersection_out[j]==lista_order_f1[i]:
                inter= lista_order_f1[i+1]
                salida_f1.append(inter)
    for i in range(0,len(lista_order_f2)):
        for j in range(0,len(intersection_out)):
            if intersection_out[j]==lista_order_f2[i]:
                inter2 = lista_order_f2[i+1]
                salida_f2.append(inter2)


    x=np.array(salida_f1).astype(np.float)
    y=np.array(salida_f2).astype(np.float)
    
    
    ##Calculating the regression of equation
    slope, intercept, r_value, p_value, std_err = stats.linregress(x,y)
    r_sqrt=r_value**2
    print (slope)
    print (r_sqrt)

with open(name+'regression_analysis.txt', 'w') as f:
    f.write(name1+"\t")
    f.write(name2+"\t")
    f.write(str(slope)+"\t")
    f.write(str(r_sqrt)+"\t")
    f.write(str(intercept)+"\n")



