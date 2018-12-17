#!/bin/bash
module load bbtools

for file in ../data/*.clean3.fastq.gz
  do
    bname=`basename $file .clean3.fastq.gz`
    bbmap.sh ref=SINV_genomes.fasta in=$file nodisk usejni=t maxindel=20 unpigz=t scafstats="$bname".scaf.txt threads=3
  done
