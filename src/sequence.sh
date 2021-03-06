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
export REF=GCA_000260855.1_EUC_r1.0_genomic.fna.gz
export PHRED=
export EXT=fastq.gz
export READ_ONE=_R1
export UNIT_RX=3-4

#-------------------environmental variables---------------------#

export BIG=/OSM/CBR/AG_FUTUREFOREST/home/${PROJECT}
export ANALYSIS=${FLUSHDIR}/AG_FUTUREFOREST/			#this breaks portability to some extent
export METADATA=~/${PROJECT}/data/${PROJECT}_samples.meta

#---------------------trimmomatic variables----------------------#

export SEEDMISMATCH=2  # seed mismatches in read
export PALINCLIP=30    # accuracy between paired reads
export SIMPLECLIP=10   # accuracy with any adapter
export BASEQUAL=15     # base quality threshold
export WINDOWSIZE=4    # bases in window
export MINLENGTH=36    # min length of reads kept
export KEEPREADS=true  # keep both reads 
export MINADAPTLEN=1   # min adapter length for palindrome  
export PHRED=33        # quality score encoding
export ADAPT_TYPE=dual    # identifies which set of adapters to use
export ADAPT_LEFT=Other_  # name to the L of adapter ident
export ADAPT_RIGHT=_R_    # name to the R of adapter ident

#------------------------bwa variables--------------------------#

export ALGORITHM=
#---------------------------set up------------------------------#

#generate directories
mkdir -p ${BIG}/data
mkdir -p ${BIG}/analysis
mkdir -p ${BIG}/results
mkdir -p ${BIG}/logs/slurm

#get genome data
#~/${PROJECT}/src/download.sh



#functions

call_prog () {
	CMD="sbatch --dependency=${2} ${HOME}/scripts/${1}.sh"
	echo -e "\nRunning command: \n${CMD}" >> ${BIG}/logs/${TODAY}_main.log
        mkdir -p ${BIG}/logs/slurm/
        mkdir -p $BIG/logs/${TODAY}_${1}_slurm
	local __jobvar=${1}
	JOB_ID=`echo $(${CMD}) | tr ' ' '\n' | tail -n1` 
	eval $__jobvar="'$JOB_ID'"
}

multi_prog () {
#	CMD="sbatch --dependency=${3} -a 0-${2} ${HOME}/scripts/${1}.sh"
	CMD="sbatch --dependency=afterok:15714651 -a 0-384 /home/mce03b/scripts/bwa.sh"
	mkdir -p ${BIG}/logs/slurm
	mkdir -p $BIG/logs/${TODAY}_${1}_slurm
	echo -e "\nRunning command: \n${CMD}" >> ${BIG}/logs/${TODAY}_main.log
        local __jobvar=${1}
        JOB_ID=`echo $(${CMD}) | tr ' ' '\n' | tail -n1`
        eval $__jobvar="'$JOB_ID'"
}

#-------------------------analysis------------------------------#

cd $BIG

#multi_prog fastqc "$(expr $(cut -f 1 ${METADATA} | wc -l) - 1)"
#multi_prog trim "$(expr $(cut -f 1 ${METADATA} | sed "s/_R[12].*//" | sort -u | wc -l) - 1)"
#call_prog bwa_index singleton
multi_prog bwa "$(expr $(cut -f 1 ${METADATA} | sed "s/_R[12].*//" | sort -u | wc -l) - 1)" "afterok:${bwa_index}"

