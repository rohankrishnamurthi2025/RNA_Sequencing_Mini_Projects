#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="WT_18_align"
# load STAR & samtools , set working directory , and run module load STAR
# WT 18: ERR458990, ERR458991, ERR458992, ERR458993, ERR458994, ERR458995, ERR458996

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR458990.fastq.gz,ERR458991.fastq.gz,ERR458992.fastq.gz,ERR458993.fastq.gz,ERR458994.fastq.gz,ERR458995.fastq.gz,ERR458996.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_WT_18_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_WT_18_Aligned.sortedByCoord.out.bam


