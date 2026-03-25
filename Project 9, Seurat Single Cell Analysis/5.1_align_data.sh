#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -t 4:00:00
#SBATCH --mem=40gb
#SBATCH --job-name="star_solo_1"

cd /projects/e31265/rsk9305/hw_5/

module load STAR/2.7.9a

STAR --runThreadN 20 --soloType CB_UMI_Simple --soloCBwhitelist /projects/e31265/PRJNA446005/737K-august-2016.txt --soloCellFilter EmptyDrops_CR --soloFeatures Gene --genomeDir /projects/e31265/mouse_sc_ref/ --outFilterType BySJout --alignIntronMax 100000 --quantMode GeneCounts --outSAMtype None --readFilesPrefix /projects/e31265/PRJNA446005/ --readFilesCommand "gzip -cd" --readFilesIn SRR6908385_R2.fastq.gz SRR6908385_R1.fastq.gz
