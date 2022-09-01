
#!/bin/bash
#$ -N  make_Tables

source PATH=/share/apps/SqueezeMeta/bin/:$PATH


#TABLES REQUIRED TO IMPORT TO SQMTOOLS IN R

sqm2tables.py FOLDER_OUT_NAME/ FOLDER_OUT_NAME/TABLES

