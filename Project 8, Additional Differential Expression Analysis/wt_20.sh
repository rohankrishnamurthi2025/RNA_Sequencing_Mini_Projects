#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_06_align"
# load STAR & samtools , set working directory , and run module load STAR
# WT 20: ERR459004, ERR459005, ERR459006, ERR459007, ERR459008, ERR459009, ERR459010

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR459004.fastq.gz,ERR459005.fastq.gz,ERR459006.fastq.gz,ERR459007.fastq.gz,ERR459008.fastq.gz,ERR459009.fastq.gz,ERR459010.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_WT_20_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_WT_20_Aligned.sortedByCoord.out.bam


