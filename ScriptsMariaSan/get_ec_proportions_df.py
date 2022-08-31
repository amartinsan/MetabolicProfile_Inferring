#!/usr/bin/env python
## Author: María del Carmen Sánchez
## Script that take the output from EggNOG annotations and creates a dataframe with the enzimes and its relative frequency.
##Provide:
## 1)list file with all the name of enzymes (E.C) in all the files to analyze.
## 2)file from eggnogg_with the E.C and the proportions (or relative abundance) of each E.C
## example usage: python get_ec_dictio.py all_enzymes.txt Sample1_enzymes_proportions.txt

import sys
import pandas as pd
import getopt
from tempfile import TemporaryFile
from collections import defaultdict

outfile = TemporaryFile()
argv=sys.argv[2:]
try:
    opts, args = getopt.getopt(argv, 'hm:d', ['help', 'my_file='])
except getopt.GetoptError:
    print('Something went wrong!')
    sys.exit(2)
file_essen = sys.argv[1]
file_test = sys.argv[2]
name=file_test
name=name.split('_')
name=name[0]
print (name)
list_cogs=[]
list_count=[]
Dict_ec = defaultdict(list)

outfile = open("enzymes_proportions.txt",'a')
with open(file_essen) as f1,open(file_test) as f2:
    for line in f1.readlines():
        line = line.strip()
        ec=line
        Dict_ec.setdefault(ec, [])
    for line in f2.readlines():
        line=line.strip()
        line=line.split('\t')
        cogs=line[0]
        count=line[1]
        count = str(count)
        list_cogs.append(cog)
        list_cogs.append(count)
for key in Dict_ec.keys():
    for i in range(0, len(list_cogs)):
        if key == list_cogs[i]:
            count = list_cogs[i + 1]
            Dict_ec[key].append(count)
for k,v in Dict_ec.items():
    if len(v) == 0:
        Dict_ec[k].append('NaN')
    else:
        pass
dict_ec_df = pd.DataFrame({key: pd.Series(value) for key, value in Dict_ec.items()})
first_row = Dict_ec.values()
first_row=list(first_row)
first_row=str(first_row)
outfile = open("data_frame_all_ec.txt",'a')
outfile.write(str(name)+","+str(first_row))
outfile.write("\n")
outfile.close()

#print (dict_ec_df.to_csv('dataframe_final.txt', sep=',', index=True, header=True)) # use it the first time.
