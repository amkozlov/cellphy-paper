#!/bin/bash

#simroot=/path/to/simulation

if [ -z $simroot ]; then
  echo "Please define simroot variable!"
  exit
fi

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
compdist=$scriptdir/compdist.py

sim=sim3

dsroot=$simroot/$sim

outfile=${sim}.dist.txt

rm $outfile

raxml_models="GTGTR4+FO+E GPGTR4+FO+ERR_P20"
sifit_models="sifit_missing_i200000"
iscite_models="iscite_missing"
tnt_models="tnt_missing"
all_models="$sifit_models $raxml_models $iscite_models $tnt_models"

for sign in S1 S5
do

for ado in 0 0.05 0.15 0.5 
do
  for err in 0 0.01 0.1 0.2 
  do  

   ds=${sim}.${sign}.D${ado}G${err}
   dsdir=$dsroot/$ds
  
   if [ ! -d $dsdir ]; then
     echo "WANRING: dir $dsdir is missing!"
     continue
   fi

   for model in $all_models;  do
    
    dfile=$dsdir/dist_$model.csv
    dfile2=$dsdir/distmin_$model.csv

#    echo `cat $dfile | wc -l`

    if [ -f $dfile ] && [ "`cat $dfile | wc -l`" = "101"  ]; then
      echo "SKIP: $dfile"
    else

      treefile=$dsdir/rxsnv_trees/$model/t0001.raxml.bestTree
      sifittree=$dsdir/sifit_trees/$model/sifit.tree.0001
      iscitetree=$dsdir/iscite_trees/$model/snv_hap.0001_ml0.final-end.newick
      tnttree=$dsdir/tnt_trees/$model/snv_hap.0001.TNT.Tree.newick
      if [ -f $treefile ]; then
        $compdist $ds $model rxsnv
      elif [ -f $sifittree ]; then
        $compdist $ds $model sifit
      elif [ -f $iscitetree ]; then
        $compdist $ds $model iscite min
      elif [ -f $tnttree ]; then
        $compdist $ds $model tnt min
      else
        echo "WARNING: file $dfile missing!"
        continue
      fi
    fi

    sed -e '1d' -e "s/^/$sign\t$model\t$ado\t$err\t/" $dfile >> $outfile

    if [ -f $dfile2 ]; then
      sed -e '1d' -e "s/^/$sign\t${model}_rfmin\t$ado\t$err\t/" $dfile2 >> $outfile
    fi

   done
done
done
done  

