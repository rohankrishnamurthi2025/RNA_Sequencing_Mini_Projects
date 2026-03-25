#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="STAR_index"
# load STAR , set working directory , and run STAR
module load STAR
cd /projects/e31265/rsk9305/optional_2/ensembl/
STAR --runMode genomeGenerate --runThreadN 12 --genomeDir ./ --genomeFastaFiles sacCer.R64.fasta --sjdbGTFfile sacCer.R64.gtf --sjdbOverhang 50 --genomeSAindexNbases 10
