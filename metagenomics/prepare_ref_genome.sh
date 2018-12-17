#!/bin/bash

#SBATCH --job-name=invicta_mask
#SBATCH --output=repeatmask_%A_%a.out
#SBATCH --error=repeatmask_%A_%a.err
#SBATCH --time=04:00:00
#SBATCH -p short
#SBATCH -N 1
#SBATCH	-n 40

# prepare solonipsis invicta data



#load repeatmasker
module load repeatmasker

# run repeatmasker
RepeatMasker -parallel 36 -q -species "solenopsis invicta" -d masked AEAQ1.all.fa

# make reference
module load bbtools
bbsplit.sh ref=AEAQ1.all.fa.masked
mv ref ../data
