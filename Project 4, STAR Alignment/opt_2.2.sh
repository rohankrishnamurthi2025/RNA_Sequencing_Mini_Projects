#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_06_align"
# load STAR & samtools , set working directory , and run module load STAR
module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_2/


STAR --genomeDir /projects/e31265/rsk9305/optional_2/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/optional_2/ --readFilesIn SRR6357081_1.fastq.gz SRR6357081_2.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SRR6357081_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate --limitBAMsortRAM 1652540124

samtools index yeast_SRR6357081_Aligned.sortedByCoord.out.bam