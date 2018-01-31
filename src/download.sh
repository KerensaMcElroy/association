#!/bin/bash

#genome files
wget -nc -P $BIG_DATA ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.fna.gz 
wget -nc -P $BIG_DATA ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.gff.gz 
wget -nc -P $BIG_DATA ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.gbff.gz
