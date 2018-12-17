#!/bin/bash

#SBATCH --job-name=diamond
#SBATCH --output=diamond_%A_%a.out
#SBATCH --error=diamond_%A_%a.err
#SBATCH --time=03:00:00
#SBATCH -p short
#SBATCH -N 1
#SBATCH	-n 40

echo "My TMPDIR IS: " $TMPDIR

DB=nr
input=spades_out_all/scaffolds.fasta
out=diamond_all.daa


time diamond blastx --db $DB  --outfmt 100 --threads 38 --out $out --query $input
