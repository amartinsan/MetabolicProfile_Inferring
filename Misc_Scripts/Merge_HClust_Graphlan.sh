#!/bin/bash
#$ -cwd
#$ -N Merge_HClust_Graphlan

export PATH=/home/install/miniconda3/envs/metaphlan2/bin/:$PATH

merge_metaphlan_tables.py *_profile.txt > merged_abundance_table.txt

#Preprocessing to hclust

grep -E "(s__)|(^ID)" merged_abundance_table.txt | grep -v "t__" | sed 's/^.*s__//g' > merged_abundance_table_species.txt
#head mergeded_abundance_table_species.txt


####HCLUST######
hclust2.py -i merged_abundance_table_species.txt -o
abundance_heatmap_species.png \
--ftop 30 --f_dist_f braycurtis \
--s_dist_f braycurtis \
--cell_aspect_ratio 0.5 \
-l --flabel_size 6 \
--slabel_size 6 \
--max_flabel_len 100 \
--max_slabel_len 100 \
--minv 0.1 --dpi 300


#Export to graphlan for graphics

export2graphlan.py --skip_rows 1,2 -i merged_abundance_table.txt \
--tree merged_abundance.tree.txt --annotation merged_abundance.annot.txt \
--most_abundant 100 --abundance_threshold 1 --least_biomarkers 10 \
--annotations 5,6 --external_annotations 7 --min_clade_size 1

#GRAPH the cladogram

graphlan_annotate.py --annot merged_abundance.annot.txt merged_abundance.tree.txt merged_abundance.xml
graphlan.py --dpi 300 merged_abundance.xml merged_abundance.png --external_legends
