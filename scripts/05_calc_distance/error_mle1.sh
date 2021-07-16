#!/bin/bash

#simroot=/path/to/simulation

if [ -z $simroot ]; then
  echo "Please define simroot variable!"
  exit
fi

sim=1

dsroot=$simroot/sims$sim

allout=sim${sim}.errx.csv

echo "ds;e;a;m;rep;ex;ax" > $allout 

for s in 250 500 1000;
do
for a in 0.00 0.10 0.25 0.50;
do
  for e in 0.00 0.01 0.05 0.10;
  do

   simdir=$dsroot/sim${sim}.D${a}G${e}j${s}
 
   for model in GPGTR4+FO+ERR_P20; do
  
    outfile=$simdir/errx_${simdir}_$model.csv

#    echo "REP;SEQ_ERR;ADO_RATE" > $outfile

#    grep -o -h -e 'E{.*}' $simdir/rxsnv_trees/pars1_$model/t*.raxml.bestModel | grep -n '' | sed 's/[:\/]/;/g' | sed 's/[E{}]//g' > $outfile

    if [ "$model" == "GTGTR4+FO+E" ]; then
      grep -o -h -e 'E{.*}' $simdir/rxsnv_trees/pars1_$model/t*.raxml.bestModel | grep -n '' | sed 's/[:\/]/;/g' | sed 's/[E{}]//g' > $outfile
    elif [ "$model" == "GPGTR4+FO+ERR_P20" ]; then
      grep -o -h -e 'ERR_P20{.*}' $simdir/rxsnv_trees/pars1_$model/t*.raxml.bestModel | grep -n '' | sed 's/[:\/]/;/g' | sed -e 's/ERR_P20//g' -e 's/[{}]//g' > $outfile
    else
      grep -o -h -e 'ERR_PT19{.*}' $simdir/rxsnv_trees/pars1_$model/t*.raxml.bestModel | grep -n '' | sed 's/[:\/]/;/g' | sed -e 's/ERR_PT19//g' -e 's/[{}]//g' > $outfile
    fi
    sed "s/^/sim${sim}_S${s};$e;$a;$model;/" $outfile >> $allout
  done

  done
done
done
