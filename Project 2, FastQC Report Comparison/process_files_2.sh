#!/bin/bash
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="process_files"


# Load the module for fastq-dump if needed
module load sratoolkit  # Adjust if the module name differs on Quest
cd /projects/e31265/rsk9305/optional_1/

# File containing the list of SRA files
file_list="file_list_2.sh"

# Loop through each file in the list
while IFS= read -r file; do
    echo "Processing $file..."
    fasterq-dump --outdir . --gzip "$file"
done < "$file_list"

