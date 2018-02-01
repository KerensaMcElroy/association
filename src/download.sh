#!/bin/bash

#genome files
wget -nc -P $BIG_DATA ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.fna.gz 
wget -nc -P $BIG_DATA ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.gff.gz 
wget -nc -P $BIG_DATA ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.gbff.gz

#copy raw data from Shannon's location


IN_FILE_LIST=(/OSM/CBR/AG_FUTUREFOREST/home/SIEF/E.camaldulensis/Target_enrichment/population_02_Deniliquin/raw_sequences/*)
sbatch -a 0-$(expr ${#IN_FILE_LIST[@]} - 1) ~/scripts/copy.sh #-i $IN_FILE_LIST -o $BIG_DATA"
