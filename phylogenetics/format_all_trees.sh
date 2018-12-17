#!/bin/bash
for file in analysis/*/RAxML_bipartitions.*
  do
      filename=`basename $file`
      bname=`echo "$filename" | sed 's/RAxML_bipartitions.//'`
      python format-tree.py -t $file  -m data/metadata/csv/All_viruses.csv  -o analysis/$bname/$bname
  done
