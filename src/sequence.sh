#!/bin/bash

#***************************************************************#
#                           sequence.sh                         #
#                  written by Kerensa McElroy                   #
#                          January 2016				#
#                                                               #
#               processes raw data sequence data                #
#***************************************************************#

export TODAY=$(date +%Y-%m-%d_%H-%M)


#----------------------project variables------------------------#

export PROJECT=2018-01-01_e-camal-assoc



#-------------------environmental variables---------------------#

export BIG=/OSM/CBR/AG_FUTUREFOREST/home/${PROJECT}
export ANALYSIS=${FLUSHDIR}/AG_FUTUREFOREST/			#this breaks portability to some extent
export METADATA=~/${PROJECT}/data/${PROJECT}_samples.meta

#---------------------------set up------------------------------#

#generate directories
mkdir -p ${BIG}/data
mkdir -p ${BIG}/analysis
mkdir -p ${BIG}/results
mkdir -p ${BIG}/logs/slurm

#get genome data
~/${PROJECT}/src/download.sh

#functions
call_prog () {
	CMD="sbatch -a 0-$(expr $(cut -f 1 ${METADATA} | wc -l) - 1) ${HOME}/scripts/${1}.sh"
	mkdir -p ${BIG}/logs/slurm/
	echo -e "\nRunning command: \n${CMD}" >> ${BIG}/logs/${TODAY}_main.log
	${CMD}
	wait
	mkdir -p $BIG/logs/${TODAY}_${1}_slurm
	mv ${BIG}/logs/slurm/*${1}* $BIG/logs/${TODAY}_${1}_slurm/
}

#-------------------------analysis------------------------------#

cd $BIG

call_prog fastqc

