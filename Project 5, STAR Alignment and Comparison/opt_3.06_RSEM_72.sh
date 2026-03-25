#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 4:00:00
#SBATCH --mem=20gb
#SBATCH --job-name="yeast_paired_rsem_72"

cd /projects/e31265/rsk9305/optional_3/
module purge all
module load STAR/2.7.5
module load rsem

rsem-calculate-expression -p 12 --star-gzipped-read-file --paired-end --strandedness reverse --star SRR6357072_1.fastq.gz SRR6357072_2.fastq.gz /projects/e31265/yeast/yeast yeast_SRA6357072_rsem --no-bam-output
