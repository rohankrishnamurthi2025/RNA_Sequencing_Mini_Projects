#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="STAR_70"
# load STAR & samtools , set working directory , and run 

module load STAR
module load samtools
cd /projects/e31265/rsk9305/optional_3/


# STAR command -- should be all on ONE LINE with commas and no spaces between fastq.gz files STAR 
STAR --genomeDir /projects/e31265/rsk9305/optional_3/yeast/ --readFilesPrefix /projects/e31265/PRJNA421472/ --readFilesIn SRR6357070_1.fastq.gz SRR6357070_2.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SRR6357070_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout
