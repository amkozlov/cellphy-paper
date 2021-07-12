#!/bin/bash

#CELLPHY_HOME=/path/to/cellphy
CELLPHY="$CELLPHY_HOME/cellphy.sh RAXML"
DSDIR=sim6.S100L01000

if [ ! -d $DSDIR ]; then
  echo "ERROR: Dataset directory not found: $DSDIR"
  exit
fi

if [ -z "$1" ]; then
  REP=0001
else
  REP=$1
fi

#ML16 model
MODEL=GT16+FO+E

#ML10 model
#MODEL=GT10+FO+E

OUTDIR=$DSDIR/rxmlgt_trees/$MODEL

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

STREE=pars{1}

SNVALI=$DSDIR/snv_haplotypes_dir/snv_hap.$REP.phy

$CELLPHY --msa $SNVALI --search --model $MODEL --tree $STREE --prefix $OUTDIR/t$i --threads 1
