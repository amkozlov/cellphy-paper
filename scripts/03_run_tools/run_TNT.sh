#!/bin/bash

TNTHOME=/path/to/tnt
TNT="$TNTHOME/tnt"
DSDIR=sim6.S100L01000

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ ! -f $TNT ]; then
  echo "ERROR: TNT not found: $TNT"
  exit
fi

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

MODEL=tnt_${TRIAL}

OUTDIR=$DSDIR/tnt_trees/$MODEL

if [ ! -d $OUTDIR ]; then
  mkdir -p $OUTDIR
fi

OLDDIR=`pwd`

cd $OUTDIR

TEMPL="$SCRIPTDIR/TNT.proc.templ"

for i in $(seq -f "%04g" $REPFIRST $REPLAST); do

  SNVDIR=$DSDIR/snv_haplotypes_dir
  TNTPROC=$OUTDIR/tnt.$i.proc

  sed -e "s/<REP>/$i/" -e "s/<TRIAL>/$TRIAL/" -e "s#<SNVDIR>#$SNVDIR#" -e  "s#<OUTDIR>#$OUTDIR#" $TEMPL > $TNTPROC

  $TNT procedure $TNTPROC
done

cd $OLDDIR
