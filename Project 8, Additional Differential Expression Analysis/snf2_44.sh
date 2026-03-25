#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_44_align"
# load STAR & samtools , set working directory , and run module load STAR
# SNF2_44: ERR458801, ERR458807


module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR458801.fastq.gz,ERR458802.fastq.gz,ERR458803.fastq.gz,ERR458804.fastq.gz,ERR458805.fastq.gz,ERR458806.fastq.gz,ERR458807.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SNF2_44_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_SNF2_44_Aligned.sortedByCoord.out.bam
