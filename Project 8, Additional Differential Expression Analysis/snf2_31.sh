#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_31_align"
# load STAR & samtools , set working directory , and run module load STAR
# SNF2_31: ERR458710, ERR458711, ERR458712, ERR458713, ERR458714, ERR458715, ERR458716

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR458710.fastq.gz,ERR458711.fastq.gz,ERR458712.fastq.gz,ERR458713.fastq.gz,ERR458714.fastq.gz,ERR458715.fastq.gz,ERR458716.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SNF2_31_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_SNF2_31_Aligned.sortedByCoord.out.bam