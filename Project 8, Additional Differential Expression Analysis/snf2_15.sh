#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_15_align"
# load STAR & samtools , set working directory , and run module load STAR
# SNF2_15: ERR458598, ERR458599, ERR458600, ERR458601, ERR458602, ERR458603, ERR458604

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR458598.fastq.gz,ERR458599.fastq.gz,ERR458600.fastq.gz,ERR458601.fastq.gz,ERR458602.fastq.gz,ERR458603.fastq.gz,ERR458604.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SNF2_15_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_SNF2_15_Aligned.sortedByCoord.out.bam