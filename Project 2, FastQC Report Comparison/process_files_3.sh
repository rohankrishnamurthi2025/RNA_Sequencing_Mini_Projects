#!/bin/bash
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="process_files"


# Load the module for fastq-dump if needed
# Adjust if the module name differs on Quest
cd /projects/e31265/rsk9305/optional_1/

module load sratoolkit 
fastq-dump --gzip ERR458593
fastq-dump --gzip ERR458591
fastq-dump --gzip ERR458595
fastq-dump --gzip ERR458597
fastq-dump --gzip ERR458592
fastq-dump --gzip ERR458594
fastq-dump --gzip ERR458596
fastq-dump --gzip ERR458599
fastq-dump --gzip ERR458601
fastq-dump --gzip ERR458598
fastq-dump --gzip ERR458600
fastq-dump --gzip ERR458602
fastq-dump --gzip ERR458604
fastq-dump --gzip ERR458603
fastq-dump --gzip ERR458714
fastq-dump --gzip ERR458710
fastq-dump --gzip ERR458711
fastq-dump --gzip ERR458712
fastq-dump --gzip ERR458716
fastq-dump --gzip ERR458713
fastq-dump --gzip ERR458715
fastq-dump --gzip ERR458725
fastq-dump --gzip ERR458728
fastq-dump --gzip ERR458729
fastq-dump --gzip ERR458724
fastq-dump --gzip ERR458726
fastq-dump --gzip ERR458727
fastq-dump --gzip ERR458730
fastq-dump --gzip ERR458790
fastq-dump --gzip ERR458793
fastq-dump --gzip ERR458788
fastq-dump --gzip ERR458789
fastq-dump --gzip ERR458792
fastq-dump --gzip ERR458787
fastq-dump --gzip ERR458791
fastq-dump --gzip ERR458801
fastq-dump --gzip ERR458802
fastq-dump --gzip ERR458805
fastq-dump --gzip ERR458804
fastq-dump --gzip ERR458806
fastq-dump --gzip ERR458803
fastq-dump --gzip ERR458807
fastq-dump --gzip ERR458993
fastq-dump --gzip ERR458994
fastq-dump --gzip ERR458995
fastq-dump --gzip ERR458990
fastq-dump --gzip ERR458991
fastq-dump --gzip ERR458992
fastq-dump --gzip ERR458996
fastq-dump --gzip ERR458880
fastq-dump --gzip ERR458881
fastq-dump --gzip ERR458882
fastq-dump --gzip ERR458884
fastq-dump --gzip ERR458878
fastq-dump --gzip ERR458879
fastq-dump --gzip ERR458883
fastq-dump --gzip ERR459005
fastq-dump --gzip ERR459007
fastq-dump --gzip ERR459008
fastq-dump --gzip ERR459009
fastq-dump --gzip ERR459004
fastq-dump --gzip ERR459010
fastq-dump --gzip ERR459006
fastq-dump --gzip ERR459139
fastq-dump --gzip ERR459143
fastq-dump --gzip ERR459137
fastq-dump --gzip ERR459138
fastq-dump --gzip ERR459140
fastq-dump --gzip ERR459141
fastq-dump --gzip ERR459142
fastq-dump --gzip ERR459158
fastq-dump --gzip ERR459159
fastq-dump --gzip ERR459160
fastq-dump --gzip ERR459162
fastq-dump --gzip ERR459163
fastq-dump --gzip ERR459164
fastq-dump --gzip ERR459161
fastq-dump --gzip ERR459182
fastq-dump --gzip ERR459181
fastq-dump --gzip ERR459183
fastq-dump --gzip ERR459179
fastq-dump --gzip ERR459180
fastq-dump --gzip ERR459184
fastq-dump --gzip ERR459185



