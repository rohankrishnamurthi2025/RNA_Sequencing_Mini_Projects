#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="WT_45_align"
# load STAR & samtools , set working directory , and run module load STAR
# WT 45: 

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR459179.fastq.gz,ERR459180.fastq.gz,ERR459181.fastq.gz,ERR459182.fastq.gz,ERR459183.fastq.gz,ERR459184.fastq.gz,ERR459185.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_WT_45_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_WT_45_Aligned.sortedByCoord.out.bam

