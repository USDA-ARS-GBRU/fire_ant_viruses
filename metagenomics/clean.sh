#!/bin/bash

#SBATCH --job-name=invicta_clean
#SBATCH --output=clean_%A_%a.out
#SBATCH --error=clean_%A_%a.err
#SBATCH --array=1-8
#SBATCH --time=01:00:00
#SBATCH -p debug
#SBATCH -N 1
#SBATCH	-n 40


module load bbtools
module load pigz

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

in="$SLURM_ARRAY_TASK_ID"_S"$SLURM_ARRAY_TASK_ID"_L001_R1_001.fastq.gz
in2="$SLURM_ARRAY_TASK_ID"_S"$SLURM_ARRAY_TASK_ID"_L001_R2_001.fastq.gz
out="$SLURM_ARRAY_TASK_ID"_S"$SLURM_ARRAY_TASK_ID"_L001.clean1.fastq.gz
out2="$SLURM_ARRAY_TASK_ID"_S"$SLURM_ARRAY_TASK_ID"_L001.clean2.fastq.gz
stats="$SLURM_ARRAY_TASK_ID"_scaffoldstats1.txt
stats2="$SLURM_ARRAY_TASK_ID"_scaffoldstats2.txt
refbase=/software/apps/bbtools/gcc/64/37.02/resources

# remove contaminants

bbduk.sh in=$in \
    in2=$in2 \
    out=$out \
    stats=$stats \
    bhist="$SLURM_ARRAY_TASK_ID"bhist.txt \
    qhist="$SLURM_ARRAY_TASK_ID"qhist.txt \
    qchist="$SLURM_ARRAY_TASK_ID"qchist.txt \
    aqhist="$SLURM_ARRAY_TASK_ID"aqhist.txt \
    bqhist="$SLURM_ARRAY_TASK_ID"bqhist.txt \
    gchist="$SLURM_ARRAY_TASK_ID"gchist.txt \
    minlen=25 \
    minlenfraction=0.333 \
    hdist=1 \
    pigz=true \
    unpigz=true \
    cf=true \
    barcodefilter=false \
    ow=true \
    rqc=hashmap \
    loglog=True \
    ref=$refbase/sequencing_artifacts.fa.gz,$refbase/phix174_ill.ref.fa.gz

# remove adaptors
bbduk.sh in=$out \
	out=$out2 \
	k=20 \
	hdist=1 \
	pigz=true \
	unpigz=true \
	loglog=true \
	ref=$refbase/adapters.fa \
	stats=$stats2