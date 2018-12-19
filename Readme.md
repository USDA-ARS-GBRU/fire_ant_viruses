# Software code to reproduce the analyses in

> Valles, S. M., Rivers, A. R. 2019. Nine new RNA viruses associated with the fire ant
> _Solenopsis invicta_ from its native range. Submitted manuscript.

Four main types of  analysis run in this paper.

1. Processing the raw metagenomic data into contigs.
2. Primer walking, 5' and 3' RACE to close the genomes. (not in this repository)
3. Mapping reads to the completed genomes and plotting the distributions.
4. The construction of Maximum likelihood phylogenetic trees.

## Methods

### Metagenomics

The metagenomics workflow followed these steps.

1. Remove sequencing contaminants with BBduk
2. Trim adapters with BBduk
3. Mask repetitive sequences in the _S. invicta_ genome with RepeatMasker
4. Index the _S. invicta_ genome using BBmap
5. Remove _S. invicta_ reads from the samples using BBsplit
6. Combine all samples and assemble a combined metagenome with Spades
7. Identify contigs with Diamond vs NR.
8. Identify viral contigs with Megan using the Diamond output
   (not included in repo)

> Note: many steps in  the work flow were run using the SLURM scheduler. The
> runall.sh files omits the `sbatch` command for job submission to make the workflow
> portable, however without a large memory machine some steps may not run.

### Virus_abundance

1. Map all 8 trimmed libraries to the manually closed genomes with BBmap
2. Combine the summary data from BBmap with a python Scripts
3. Create Figure 1. using an R script

### Phylogenetics

1. Align the polyproteins with Mafft
2. Select Phylogenetically informative regions with TrimAL
3. Create a maximum likelihood tree using RAxML
4. Format and annotate the data using ETE Toolkit


## Conda environment

To facilitate reproducible research We have created a
[conda environment](https://conda.io/docs/user-guide/install/index.html)
containing the software necessary to reproduce the analyses.

```
conda env create --name valles_rivers_2018 --file create_fire_ant_conda_env.yml
source activate valles_rivers_2018
```
