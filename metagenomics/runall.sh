#!/usr/bin

# Scripts to run the metagenomics analysis

# Download the sample data from NCBI SRA using sra-tools:
fasterq-dump SRR5852934 -e 4
fasterq-dump SRR5852935 -e 4
fasterq-dump SRR5852936 -e 4
fasterq-dump SRR5852937 -e 4
# Fore more libraries will be available after they become bublic on NCBI.
# They will be listed under the the SRA project accession SRP113235

# Remove contaminants and adaptors
bash clean.sh

# Download the S invicta genome and run repeat masker on it and create a reference with bbsplit
# download references
wget ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/AE/AQ/AEAQ01/AEAQ01.1.fsa_nt.gz
wget ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/AE/AQ/AEAQ01/AEAQ01.2.fsa_nt.gz
wget ftp://ftp.ncbi.nlm.nih.gov/sra/wgs_aux/AE/AQ/AEAQ01/AEAQ01.3.fsa_nt.gz

# concatenate
zcat *fsa_nt.gz > AEAQ1.all.fa

bash prepare_ref_genome

# Remove host RNA
bash remove_invicta.sh

#Concatenate the zipped files
cat *clean3.fastq.gz gzip > all.clean3.fastq
mv all.clean3.fastq all.clean3.fastq.gz

#Assemble the genomes using Spades
bash assemble_all.sh

#download nr
wget ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nr.gz -O nr.gz
#create diamond db
bash diamond_db.sh

#Create
bash diamond_sub.sh
