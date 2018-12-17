#!/bin/bash

#SBATCH --job-name=remove_invicta
#SBATCH --output=remove_%A_%a.out
#SBATCH --error=remove_%A_%a.err
#SBATCH --array=1-8
#SBATCH --time=01:00:00
#SBATCH -p short
#SBATCH -N 1
#SBATCH	-n 40


module load bbtools
module load pigz

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

out2="$SLURM_ARRAY_TASK_ID"_S"$SLURM_ARRAY_TASK_ID"_L001.clean2.fastq.gz
out3="$SLURM_ARRAY_TASK_ID"_S"$SLURM_ARRAY_TASK_ID"_L001.clean3.fastq.gz

# ref is read from ref file generated in prepare_ref_genomes.sh script. 
# This prevents multiple array tasks from overwriting ref
bbsplit.sh in=$out2 outu=$out3