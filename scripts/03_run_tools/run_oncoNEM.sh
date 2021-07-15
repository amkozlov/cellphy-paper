#!/bin/bash

ONEM="Rscript oncoNEM.R"
DSDIR=sim6.S100L01000

if [ ! -d $DSDIR ]; then
  echo "ERROR: Dataset directory not found: $DSDIR"
  exit
fi

TRIAL=missing
#TRIAL=keep
#TRIAL=remove

if [ -z "$1" ]; then
  REPFIRST=1
else
  REPFIRST=$1
fi

if [ -z "$2" ]; then
  REPLAST=$REPFIRST
else
  REPLAST=$2
fi

MODEL=onem_${TRIAL}

OUTDIR=$DSDIR/onem_trees/$MODEL

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

for i in $(seq -f "%04g" $REPFIRST $REPLAST); do

  SNV=$DSDIR/snv_haplotypes_dir/snv_hap.$i

  ONMAT=$SNV.$TRIAL.onco

  if [ ! -f $ONMAT ]; then
    echo "ERROR: Input matrix not found: $ONMAT"
    continue
  fi

  $ONEM $ONMAT $OUTDIR/snv_hap.$i
done
