#!/bin/bash

SCIS=/path/to/scistree
DSDIR=sim6.S100L01000

if [ ! -f $SCIS ]; then
  echo "ERROR: ScisTree not found: $SCIS"
  exit
fi

if [ ! -d $DSDIR ]; then
  echo "ERROR: Dataset directory not found: $DSDIR"
  exit
fi

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

MODEL=scis_default
OUTDIR=$DSDIR/scis_trees/$MODEL

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

for i in $(seq -f "%04g" $REPFIRST $REPLAST); do

  MAT=$DSDIR/vcf_dir/vcf.$i.scis
  if [ ! -f $MAT ]; then
    continue;
  fi
 
  if [ -f $OUTDIR/scis.tree.$i ]; then
    continue;
  fi

  $SCIS $MAT > $OUTDIR/scis.log.$i
done

