#!/bin/bash
#SBATCH -A e31265
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -t 01:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="process_files"


# Load the module for fastq-dump if needed
cd /projects/e31265/rsk9305/optional_1/

# Adjust if the module name differs on Quest
module load sratoolkit  
fasterq-dump --outdir . ERR458593
gzip ERR458593.fastq

fasterq-dump --outdir . ERR458591
gzip ERR458591.fastq

fasterq-dump --outdir . ERR458595
gzip ERR458595.fastq

fasterq-dump --outdir . ERR458597
gzip ERR458597.fastq

fasterq-dump --outdir . ERR458592
gzip ERR458592.fastq

fasterq-dump --outdir . ERR458594
gzip ERR458594.fastq

fasterq-dump --outdir . ERR458596
gzip ERR458596.fastq

fasterq-dump --outdir . ERR458599
gzip ERR458599.fastq

fasterq-dump --outdir . ERR458601
gzip ERR458601.fastq

fasterq-dump --outdir . ERR458598
gzip ERR458598.fastq

fasterq-dump --outdir . ERR458600
gzip ERR458600.fastq

fasterq-dump --outdir . ERR458602
gzip ERR458602.fastq

fasterq-dump --outdir . ERR458604
gzip ERR458604.fastq

fasterq-dump --outdir . ERR458603
gzip ERR458603.fastq

fasterq-dump --outdir . ERR458714
gzip ERR458714.fastq

fasterq-dump --outdir . ERR458710
gzip ERR458710.fastq

fasterq-dump --outdir . ERR458711
gzip ERR458711.fastq

fasterq-dump --outdir . ERR458712
gzip ERR458712.fastq

fasterq-dump --outdir . ERR458716
gzip ERR458716.fastq

# redo above

fasterq-dump --outdir . ERR458713
gzip ERR458713.fastq

fasterq-dump --outdir . ERR458715
gzip ERR458715.fastq

fasterq-dump --outdir . ERR458725
gzip ERR458725.fastq

fasterq-dump --outdir . ERR458728
gzip ERR458728.fastq

fasterq-dump --outdir . ERR458729
gzip ERR458729.fastq

fasterq-dump --outdir . ERR458724
gzip ERR458724.fastq

fasterq-dump --outdir . ERR458726
gzip ERR458726.fastq

fasterq-dump --outdir . ERR458727
gzip ERR458727.fastq

fasterq-dump --outdir . ERR458730
gzip ERR458730.fastq

fasterq-dump --outdir . ERR458790
gzip ERR458790.fastq

fasterq-dump --outdir . ERR458793
gzip ERR458793.fastq

fasterq-dump --outdir . ERR458788
gzip ERR458788.fastq

fasterq-dump --outdir . ERR458789
gzip ERR458789.fastq

fasterq-dump --outdir . ERR458792
gzip ERR458792.fastq

fasterq-dump --outdir . ERR458787
gzip ERR458787.fastq

fasterq-dump --outdir . ERR458791
gzip ERR458791.fastq

fasterq-dump --outdir . ERR458801
gzip ERR458801.fastq

fasterq-dump --outdir . ERR458802
gzip ERR458802.fastq

fasterq-dump --outdir . ERR458805
gzip ERR458805.fastq

fasterq-dump --outdir . ERR458804
gzip ERR458804.fastq

fasterq-dump --outdir . ERR458806
gzip ERR458806.fastq

fasterq-dump --outdir . ERR458803
gzip ERR458803.fastq

fasterq-dump --outdir . ERR458807
gzip ERR458807.fastq

fasterq-dump --outdir . ERR458993
gzip ERR458993.fastq

fasterq-dump --outdir . ERR458994
gzip ERR458994.fastq

fasterq-dump --outdir . ERR458995
gzip ERR458995.fastq

fasterq-dump --outdir . ERR458990
gzip ERR458990.fastq

fasterq-dump --outdir . ERR458991
gzip ERR458991.fastq

fasterq-dump --outdir . ERR458992
gzip ERR458992.fastq

fasterq-dump --outdir . ERR458996
gzip ERR458996.fastq

fasterq-dump --outdir . ERR458880
gzip ERR458880.fastq

fasterq-dump --outdir . ERR458881
gzip ERR458881.fastq

fasterq-dump --outdir . ERR458882
gzip ERR458882.fastq

fasterq-dump --outdir . ERR458884
gzip ERR458884.fastq

fasterq-dump --outdir . ERR458878
gzip ERR458878.fastq

fasterq-dump --outdir . ERR458879
gzip ERR458879.fastq

fasterq-dump --outdir . ERR458883
gzip ERR458883.fastq

fasterq-dump --outdir . ERR459005
gzip ERR459005.fastq

fasterq-dump --outdir . ERR459007
gzip ERR459007.fastq

fasterq-dump --outdir . ERR459008
gzip ERR459008.fastq

fasterq-dump --outdir . ERR459009
gzip ERR459009.fastq

fasterq-dump --outdir . ERR459004
gzip ERR459004.fastq

fasterq-dump --outdir . ERR459010
gzip ERR459010.fastq

fasterq-dump --outdir . ERR459006
gzip ERR459006.fastq

fasterq-dump --outdir . ERR459139
gzip ERR459139.fastq

fasterq-dump --outdir . ERR459143
gzip ERR459143.fastq

fasterq-dump --outdir . ERR459137
gzip ERR459137.fastq

fasterq-dump --outdir . ERR459138
gzip ERR459138.fastq

fasterq-dump --outdir . ERR459140
gzip ERR459140.fastq

fasterq-dump --outdir . ERR459141
gzip ERR459141.fastq

fasterq-dump --outdir . ERR459142
gzip ERR459142.fastq

fasterq-dump --outdir . ERR459158
gzip ERR459158.fastq

fasterq-dump --outdir . ERR459159
gzip ERR459159.fastq

fasterq-dump --outdir . ERR459160
gzip ERR459160.fastq

fasterq-dump --outdir . ERR459162
gzip ERR459162.fastq

fasterq-dump --outdir . ERR459163
gzip ERR459163.fastq

fasterq-dump --outdir . ERR459164
gzip ERR459164.fastq

fasterq-dump --outdir . ERR459161
gzip ERR459161.fastq

fasterq-dump --outdir . ERR459182
gzip ERR459182.fastq

fasterq-dump --outdir . ERR459181
gzip ERR459181.fastq

fasterq-dump --outdir . ERR459183
gzip ERR459183.fastq

fasterq-dump --outdir . ERR459179
gzip ERR459179.fastq

fasterq-dump --outdir . ERR459180
gzip ERR459180.fastq

fasterq-dump --outdir . ERR459184
gzip ERR459184.fastq

fasterq-dump --outdir . ERR459185
gzip ERR459185.fastq



