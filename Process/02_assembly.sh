
#!/bin/bash


#Files



for file in *R1.fastq
do

	echo $file
	echo "input file  :" $file
	NSLOTS=5
	fastq=$file
	#get R2 from R1 (derive)
	fastq2="${fastq/R1/R2}"

	#Assembly

	spades.py --meta -1 $fastq -2 $fastq2 -o $file\_SPADES_ASSEMBLY  -t $NSLOTS -m 250 -k 21,33,55,77,99,111,127 --only-assembler

done
