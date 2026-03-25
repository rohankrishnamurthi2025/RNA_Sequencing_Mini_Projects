#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_42_align"
# load STAR & samtools , set working directory , and run module load STAR
# SNF2_42: 

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR458787.fastq.gz,ERR458788.fastq.gz,ERR458789.fastq.gz,ERR458790.fastq.gz,ERR458791.fastq.gz,ERR458792.fastq.gz,ERR458793.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SNF2_42_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_SNF2_42_Aligned.sortedByCoord.out.bam

