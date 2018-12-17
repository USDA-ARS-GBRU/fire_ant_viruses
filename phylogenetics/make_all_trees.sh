#!/bin/bash
for file in data/proteins/*
  do
      bname=`basename $file .fasta`
      bash make_polyprotein_tree.sh $file analysis/$bname
  done
