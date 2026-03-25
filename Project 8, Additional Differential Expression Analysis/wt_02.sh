#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="WT_02_align"
# load STAR & samtools , set working directory , and run module load STAR
# WT 02: ERR458878,ERR458879,ERR458880,ERR458881,ERR458882,ERR458883,ERR458884

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR458878.fastq.gz,ERR458879.fastq.gz,ERR458880.fastq.gz,ERR458881.fastq.gz,ERR458882.fastq.gz,ERR458883.fastq.gz,ERR458884.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_WT_02_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_WT_02_Aligned.sortedByCoord.out.bam


