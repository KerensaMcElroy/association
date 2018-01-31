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

export BIG_DATA=/OSM/CBR/AG_FUTUREFOREST/home/${PROJECT}/data
export BIG_ANALYSIS=${FLUSHDIR}/AG_FUTUREFOREST/			#this breaks portability to some extent
export BIG_RESULTS=/OSM/CBR/AG_FUTUREFOREST/home/${PROJECT}/results
export BIG_LOGS=/OSM/CBR/AG_FUTUREFOREST/home/${PROJECT}/logs


#---------------------------set up------------------------------#

#generate directories
mkdir -p ${BIG_DATA}
mkdir -p ${BIG_ANALYSIS}
mkdir -p ${BIG_RESULTS}
mkidr -p ${BIG_LOGS}

#get genome data
~/${PROJECT}/src/download.sh

#functions
call_prog () {
	CMD=~/scripts/${1}.sh
	echo -e "\nRunning command: \n${CMD}" >> ~/${BIG_LOGS}/main_${TODAY}.log
	${CMD}
}

#-------------------------analysis------------------------------#

call_prog fastqc
