#!/bin/bash

PREFIX="" #Data prefix
DATA_PATH="" #Data path
DRYRUN=false #Flag for dryrun
MAX_JOB=10 #Maximum concurrently running jobs for the pipeline
JOB_NUM=2 #Number of jobs concurrently running

#Parsing the options
while getopts :dt: option
do
    case "$option" in
    d)
        DRYRUN=true
        ;;
    t)
        JOB_NUM=$OPTARG
        if echo $JOB_NUM| egrep -vq '^[0-9]+$'; then
            echo "Error: An integer less than 10 should be specified with -t option" >&2
            exit 1
        fi
        if [ $JOB_NUM -ge $MAX_JOB ] ; then
            echo "Error: Number of concurrent jobs should be less than $MAX_JOB" >&2
            exit 1
        fi
        ;;
    *)
        echo "Error: Hmm, an invalid option was received." >&2
        echo "usage: runService.sh [-d] [-t JOB_NUM=2] DATA_PATH DATA_PREFIX"
        exit 1
        ;;
    esac
done

shift $((OPTIND-1))
DATA_PATH=$1
PREFIX=$2

#Check if the path and the data exists
[ ! -n "$PREFIX" -o ! -n "$DATA_PATH" ] && echo "Error: DATA_PATH  and DATA_PREFIX  must be specified" >&2 && exit 1
[ ! -d $DATA_PATH ] && echo "Error: Directory $DATA_PATH not exist." >&2 && exit 1
[ ! -e $DATA_PATH/$PREFIX-BL_1.fastq.gz -o ! -e $DATA_PATH/$PREFIX-BL_2.fastq.gz -o ! -e $DATA_PATH/$PREFIX-Br_1.fastq.gz -o ! -e $DATA_PATH/$PREFIX-Br_2.fastq.gz ] && echo "Error: $DATA_PATH/$PREFIX-[BL and Br]_[1 and 2].fastq.gz. are required." >&2 && exit 1


if $DRYRUN ; then
    snakemake -d $DATA_PATH --configfile ./config.json -C "target=$PREFIX" --dag | dot -Tpdf > dag.pdf
else
    snakemake -d $DATA_PATH --configfile ./config.json -C "target=$PREFIX" -j $JOB_NUM --max-jobs-per-second 5 --ri -k --cluster "sbatch -p all -c{threads} -D $PWD -o $PWD/qlog/%x.out"
fi
