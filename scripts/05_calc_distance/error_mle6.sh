#!/bin/bash

sim=6

#simroot=/path/to/simulation

if [ -z $simroot ]; then
  echo "Please define simroot variable!"
  exit
fi

dsroot=$simroot/sims$sim

allout=sim${sim}.errx.csv

echo "ds;t;s;e;a;amp;b;gterr;m;rep;ex;ax" > $allout 

cov=5
a=0.10
e=0.01
amp=0.05
b=0.00

for taxa in 100 500 1000
do
 for snvs in 01000 10000 50000
 do

   simdir=$dsroot/sim${sim}.S${taxa}L${snvs}

   gterr=`grep "Probability of untrue genotype calls" $simdir/log | cut -d'=' -f2 | tr -d ' '`

   for model in GPGTR4+FO+ERR_P20; do
  
    outfile=$simdir/errx_${simdir}_$model.csv

    if [ "$model" == "GTGTR4+FO+E" ]; then
      grep -o -h -e 'E{.*}' $simdir/rxmlgt_trees/$model/t*.raxml.bestModel | grep -n '' | sed 's/[:\/]/;/g' | sed 's/[E{}]//g' > $outfile
    elif [ "$model" == "GPGTR4+FO+ERR_P20" ]; then
      grep -o -h -e 'ERR_P20{.*}' $simdir/rxmlgt_trees/$model/t*.raxml.bestModel | grep -n '' | sed 's/[:\/]/;/g' | sed -e 's/ERR_P20//g' -e 's/[{}]//g' > $outfile
    else
      grep -o -h -e 'ERR_PT19{.*}' $simdir/rxmlgt_trees/$model/t*.raxml.bestModel | grep -n '' | sed 's/[:\/]/;/g' | sed -e 's/ERR_PT19//g' -e 's/[{}]//g' > $outfile
    fi

    sed "s/^/sim${sim};$taxa;$snvs;$e;$a;$amp;$b;$gterr;$model;/" $outfile >> $allout
  done
done
done
