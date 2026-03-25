#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_33_align"
# load STAR & samtools , set working directory , and run module load STAR
# SNF2_33: ERR458724, ERR458725, ERR458726, ERR458727, ERR458728, ERR458729, ERR458730

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_4/

STAR --genomeDir /projects/e31265/rsk9305/optional_4/ensembl/ --readFilesPrefix /projects/e31265/rsk9305/sample_files/ --readFilesIn ERR458724.fastq.gz,ERR458725.fastq.gz,ERR458726.fastq.gz,ERR458727.fastq.gz,ERR458728.fastq.gz,ERR458729.fastq.gz,ERR458730.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SNF2_33_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate

samtools index yeast_SNF2_33_Aligned.sortedByCoord.out.bam