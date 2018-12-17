#!/bin/bash

#SBATCH --job-name=assemble_all
#SBATCH --output=assemble_%A_%a.out
#SBATCH --error=assemble_%A_%a.err
#SBATCH --time=72:00:00
#SBATCH -p mem
#SBATCH -N 1
#SBATCH	-n 40


echo $TMPDIR

out3=all.clean3.fastq.gz
out4=spades_out_all
tmpin=$TMPDIR/data.fastq.gz
tmpout=$TMPDIR/spades_out_all


cp $out3 $tmpin

time spades.py --meta --12 $tmpin -t 38 -m 1500 -o $tmpout

cp -r $tmpout $out4
rm -r $TMPDIR
