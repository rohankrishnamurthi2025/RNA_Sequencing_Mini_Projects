#!/bin/sh
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="SNF2_06_align"

# Replace "yourfile.bam" with the name of your BAM file
bamfile="yeast_SNF2_06_Aligned.sortedByCoord.out.bam"

# Extract read scores (AS field), sort them, and count occurrences
samtools view "$bamfile" | awk '{for(i=1;i<=NF;i++) if($i ~ /^AS:i:/) print substr($i,6)}' | sort -n | uniq -c > "${bamfile%.bam}_score_table.txt"

# Display the lowest and highest scores
lowest_score=$(awk '{print $2}' "${bamfile%.bam}_score_table.txt" | head -n 1)
highest_score=$(awk '{print $2}' "${bamfile%.bam}_score_table.txt" | tail -n 1)

echo "Lowest score in $bamfile: $lowest_score"
echo "Highest score in $bamfile: $highest_score"