#!/bin/bash

ISCITEHOME=/path/to/infscite
ISCITE="$ISCITEHOME/infSCITE"
DSDIR=sim6.S100L01000

if [ ! -x $ISCITE ]; then
  echo "ERROR: infSCITE not found: $ISCITE"
  exit
fi

if [ ! -d $DSDIR ]; then
  echo "ERROR: Dataset directory not found: $DSDIR"
  exit
fi

ITERS=5000000
RESTARTS=1

#true error rate used in simulation
#ERATE=0.00001

if [ -z "$ERATE" ]; then
  echo "Please specify true error rate via ERATE variable!"
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

#MODEL=iscite_${TRIAL}_i${ITERS}
MODEL=iscite_${TRIAL}
if [ "${RESTARTS}" -ne "1" ]; then
  MODEL=${MODEL}_r${RESTARTS}
fi

OUTDIR=$DSDIR/iscite_trees/$MODEL

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

for i in $(seq -f "%04g" $REPFIRST $REPLAST); do

  SNV=$DSDIR/snv_haplotypes_dir/snv_hap.$i

  ISMAT=$SNV.$TRIAL.inf

  if [ ! -f $ISMAT ]; then
    echo "ERROR: Input matrix not found: $ISMAT"
    continue
  fi

  NSNV=`cat $ISMAT | wc -l`
  NCELLS=`head -1 $ISMAT | wc -w`
  NCELLS=$(($NCELLS-1))

  $ISCITE -m $NCELLS -n $NSNV -r $RESTARTS -l $ITERS -fd $ERATE -ad 1.46e-1 -transpose -e 0.2 -i $ISMAT -o $OUTDIR/snv_hap.$i
done
