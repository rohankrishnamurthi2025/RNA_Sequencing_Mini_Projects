#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_14_align"
# load STAR & samtools , set working directory , and run module load STAR
# SNF2_14: ERR458591,ERR458592,ERR458593,ERR458594,ERR458595,ERR458596,ERR458597

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR458591.fastq.gz,ERR458592.fastq.gz,ERR458593.fastq.gz,ERR458594.fastq.gz,ERR458595.fastq.gz,ERR458596.fastq.gz,ERR458597.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SNF2_14_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_SNF2_14_Aligned.sortedByCoord.out.bam


