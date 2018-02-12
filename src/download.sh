#!/bin/bash

#genome files

wget -nc -P ${BIG}/data ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.fna.gz 
wget -nc -P ${BIG}/data ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.gff.gz 
wget -nc -P ${BIG}/data ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/260/855/GCA_000260855.1_EUC_r1.0/GCA_000260855.1_EUC_r1.0_genomic.gbff.gz


#copy raw data from Shannon's location

cd $BIG

export IN_DIR=/OSM/CBR/AG_FUTUREFOREST/home/SIEF/E.camaldulensis/Target_enrichment/population_02_Deniliquin/raw_sequences
export IN_EXT=fastq.gz
export OUT_DIR=$BIG/data

CMD=`echo "sbatch -a 0-$(expr $(ls -l ${IN_DIR}/*${IN_EXT} | wc -l) - 1) ${HOME}/scripts/copy.sh"`
echo -e "\nRunning command: \n${CMD}" >> ${BIG}/logs/${TODAY}_main.log
${CMD}
