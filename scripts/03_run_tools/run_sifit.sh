#!/bin/bash

SIFIT="java -jar /path/to/sifit/SiFit.jar"
DSDIR=sim6.S100L01000

if [ ! -d $DSDIR ]; then
  echo "ERROR: Dataset directory not found: $DSDIR"
  exit
fi

CELLS=101
ITERS=200000
RESTARTS=1

if [ -z "$1" ]; then
  REP=0001
else
  REP=$1
fi

TRIAL=missing
#TRIAL=keep
#TRIAL=remove

MODEL=sifit_${TRIAL}_i${ITERS}
if [ "${RESTARTS}" -ne "1" ]; then
  MODEL=${MODEL}_r${RESTARTS}
fi

OUTDIR=$DSDIR/sifit_trees/$MODEL

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

SNV=$DSDIR/snv_haplotypes_dir/snv_hap.$REP

NAMES=$SNV.$TRIAL.names
SFMAT=$SNV.$TRIAL.sf

NSNV=`cat $SFMAT | wc -l`

$SIFIT -m $CELLS -n $NSNV -r $RESTARTS -iter $ITERS -df 1 -ipMat $SFMAT -cellNames $NAMES > $OUTDIR/sifit.log.$REP
