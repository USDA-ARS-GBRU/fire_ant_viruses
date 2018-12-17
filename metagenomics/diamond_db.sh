#!/bin/bash

#SBATCH --job-name=diamond_db
#SBATCH --output=diamonddb_%A_%a.out
#SBATCH --error=diamonddb_%A_%a.err
#SBATCH --time=24:00:00
#SBATCH -p short
#SBATCH -N 1
#SBATCH	-n 40



time diamond makedb --in nr.gz --db nr
