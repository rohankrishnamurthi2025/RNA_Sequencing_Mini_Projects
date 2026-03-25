#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_06_align"

# load STAR & samtools , set working directory , and run STAR, then samtools
module load STAR
module load samtools
#cd $SLURM_SUBMIT_DIR

# STAR command -- should be all on ONE LINE with commas and no spaces between fastq.gz files 
STAR --genomeDir /home/rsk9305/ensembl/ --readFilesPrefix /home/rsk9305/ --readFilesIn ERR458878.fastq.gz,ERR458879.fastq.gz,ERR458880.fastq.gz,ERR458881.fastq.gz,ERR458882.fastq.gz,ERR458883.fastq.gz,ERR458884.fastq.gz --readFilesCommand "gzip -cd" --outFileNamePrefix yeast_SNF2_06_01_ --runThreadN 12 --quantMode GeneCounts --outFilterType BySJout --outSAMtype BAM SortedByCoordinate  --outFilterMultimapNmax 1

samtools index yeast_SNF2_06_01_Aligned.sortedByCoord.out.bam