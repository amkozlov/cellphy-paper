#!/bin/bash

SIFITHOME=/path/to/sifit
SIFIT="$SIFITHOME/SiFit.jar"
SIFITCMD="java -jar $SIFIT"
DSDIR=sim6.S100L01000

if [ ! -f $SIFIT ]; then
  echo "ERROR: Sifit not found: $SIFIT"
  exit
fi

if [ ! -d $DSDIR ]; then
  echo "ERROR: Dataset directory not found: $DSDIR"
  exit
fi

ITERS=200000
RESTARTS=1

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

MODEL=sifit_${TRIAL}_i${ITERS}
if [ "${RESTARTS}" -ne "1" ]; then
  MODEL=${MODEL}_r${RESTARTS}
fi

OUTDIR=$DSDIR/sifit_trees/$MODEL

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

for i in $(seq -f "%04g" $REPFIRST $REPLAST); do

  SNV=$DSDIR/snv_haplotypes_dir/snv_hap.$i

  NAMES=$SNV.$TRIAL.names
  SFMAT=$SNV.$TRIAL.sf

  NSNV=`cat $SFMAT | wc -l`
  NCELLS=`head -1 $SFMAT | wc -w`
  NCELLS=$(($NCELLS-1))

  $SIFITCMD -m $NCELLS -n $NSNV -r $RESTARTS -iter $ITERS -df 1 -ipMat $SFMAT -cellNames $NAMES > $OUTDIR/sifit.log.$i
done
