#!/usr/env/bin python
# usage combine.py dir
import os
import sys
for file in os.listdir(sys.argv[1]):
    with open(os.path.join(sys.argv[1], file), 'r') as f:
        for line in f:
            if not line.startswith("#"):
                ll = line.strip().split('\t')
                lo = [file] + ll
                print("\t".join(lo))
