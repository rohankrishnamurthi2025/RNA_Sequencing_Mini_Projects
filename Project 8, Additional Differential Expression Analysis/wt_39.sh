#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="WT_39_align"
# load STAR & samtools , set working directory , and run module load STAR
# WT 39: ERR459137, ERR459138, ERR459139, ERR459140, ERR459141, ERR459142, ERR459143

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR459137.fastq.gz,ERR459138.fastq.gz,ERR459139.fastq.gz,ERR459140.fastq.gz,ERR459141.fastq.gz,ERR459142.fastq.gz,ERR459143.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_WT_39_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_WT_39_Aligned.sortedByCoord.out.bam
