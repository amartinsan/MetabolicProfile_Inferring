#! /usr/bin/env nextflow


process quality and filter  {

  script:
  """


  fastp -i $fastq -I $fastq2 -o out.$fastq -O out.$fastq2 \
	-V \
		-q 17 \
		-g --poly_g_min_len=10 \
		-x --poly_x_min_len=20 \
		-l 50 \
		-n 15 \
		-p -P 20 \
		-y -Y 30 \
		-w 5 \
		--json=""$file".json" \
		--html=""$file".html"
done


  """

}

