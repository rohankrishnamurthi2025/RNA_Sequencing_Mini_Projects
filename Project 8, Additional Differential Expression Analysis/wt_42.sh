#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="WT_42_align"
# load STAR & samtools , set working directory , and run module load STAR
# WT 42: ERR459158, ERR459159, ERR459160, ERR459161, ERR459162, ERR459163, ERR459164

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR459158.fastq.gz,ERR459159.fastq.gz,ERR459160.fastq.gz,ERR459161.fastq.gz,ERR459162.fastq.gz,ERR459163.fastq.gz,ERR459164.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_WT_42_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_WT_42_Aligned.sortedByCoord.out.bam
