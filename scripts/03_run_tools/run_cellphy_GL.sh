#!/bin/bash

CELLPHY_HOME=/path/to/cellphy
CELLPHY="$CELLPHY_HOME/cellphy.sh"
DSDIR=sim6.S100L01000

if [ ! -f $CELLPHY ]; then
  echo "ERROR: CellPhy not found: $CELLPHY"
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

#GL16 model
MODEL=GT16+FO

#GL10 model
#MODEL=GT10+FO

OUTDIR=$DSDIR/rxvcf_trees/$MODEL

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

STREE=pars{1}

for i in $(seq -f "%04g" $REPFIRST $REPLAST); do

  SNVALI=$DSDIR/vcf_dir/vcf.$i

  $CELLPHY RAXML --msa $SNVALI --search --model $MODEL --tree $STREE --prefix $OUTDIR/t$i --threads 1
done
