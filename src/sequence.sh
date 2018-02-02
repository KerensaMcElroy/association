#!/bin/bash

#***************************************************************#
#                           sequence.sh                         #
#                  written by Kerensa McElroy                   #
#                          January 2016				#
#                                                               #
#               processes raw data sequence data                #
#***************************************************************#

export TODAY=$(date +%Y-%m-%d_%H-%M-%S)


#----------------------project variables------------------------#

export PROJECT=2018-01-01_e-camal-assoc



#-------------------environmental variables---------------------#

export BIG=/OSM/CBR/AG_FUTUREFOREST/home/${PROJECT}
export ANALYSIS=${FLUSHDIR}/AG_FUTUREFOREST/			#this breaks portability to some extent


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
	CMD=~/scripts/${1}.sh
	echo -e "\nRunning command: \n${CMD}" >> ~/${BIG_LOGS}/main_${TODAY}.log
	${CMD}
}

#-------------------------analysis------------------------------#

#call_prog
