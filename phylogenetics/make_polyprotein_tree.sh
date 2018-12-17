#!/bin/bash
# create_polyprotein_tree.sh [input file] [output directory]
# Conda env: fireants

source activate fireants

ROOTDIR=$PWD

org=`basename $1 .fasta`
# Align sequences
mafft --version
time einsi --thread 2  "$1" > "$2"/seq_aligned.fasta

trimal --version
time trimal -in "$2"/seq_aligned.fasta -fasta -out "$2"/seq_trimmed.fasta -automated1


raxmlHPC-PTHREADS-AVX2 -v

cd "$2"
time raxmlHPC-PTHREADS-AVX2 \
-s seq_trimmed.fasta \
-m PROTGAMMALG \
-x 12345 \
-p 1234 \
-# 100 \
-n $org \
-f a \
-T 2
