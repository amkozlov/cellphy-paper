#!/bin/bash

#simroot=/path/to/simulation

if [ -z $simroot ]; then
  echo "Please define simroot variable!"
  exit
fi

compdist=$simroot/compdist.py

sim=sim6

outfile=${sim}.dist.txt

rm $outfile

dsroot=$simroot/$sim

raxml_models="GTGTR4+FO+E GPGTR4+FO+ERR_P20"
rxvcf_models="vcf_GTGTR4+FO vcf_GPGTR4+FO"
sifit_models="sifit_missing_i200000"
scite_models="scite_missing"
sciphi_models="sciphi_default sciphi_truerate"
tnt_models="tnt_missing"
all_models="$raxml_models $rxvcf_models $sifit_models $scite_models $tnt_models $sciphi_models"

for cov in 5 #30 100
do

for ado in 0.10 #0.25 
do
  for err in 0.01 #0.05 
  do  

  for amp in 0.05 #0.10
  do

   for dbl in 0.00 #0.05 0.10 0.20
   do

   for taxa in 100 500 1000
   do

   for snvs in 01000 10000 50000
   do

   ds=${sim}.S${taxa}L${snvs}

   dsdir=$dsroot/$ds
  
   if [ ! -d $dsdir ]; then
     echo "WARNING: dir $dsdir is missing!"
     continue
   fi

   for model in $all_models;  do
    
    dfile=$dsdir/dist_$model.csv

    if [ -f $dfile ] && [ "`cat $dfile | wc -l`" = "101"  ]; then
      echo "SKIP: $dfile"
    else

      mltreefile=$dsdir/rxmlgt_trees/$model/t0001.raxml.bestTree
      vcftreefile=$dsdir/rxvcf_trees/$model/t0001.raxml.bestTree
      sifittree=$dsdir/sifit_trees/$model/sifit.tree.0001
      scitetree=$dsdir/scite_trees/$model/snv_hap.0001_final.end.newick
      sciphitree=$dsdir/sciphi_trees/$model/0001.SCiPhi.Tree.nwk
      tnttree=$dsdir/tnt_trees/$model/$ds.snv_hap.0001.TNT.Tree.newick
      if [ -f $mltreefile ]; then
        $compdist $ds $model rxmlgt
      elif [ -f $vcftreefile ]; then
        $compdist $ds $model rxvcf
      elif [ -f $sifittree ]; then
        $compdist $ds $model sifit
      elif [ -f $scitetree ]; then
        $compdist $ds $model scite
      elif [ -f $tnttree ]; then
        $compdist $ds $model tnt
      elif [ -f $sciphitree ]; then
        $compdist $ds $model sciphi
      else
        echo "WARNING: file $dfile missing!"
        continue
      fi
    fi

    sed -e '1d' -e "s/^/$model\t$cov\t$ado\t$err\t$amp\t$dbl\t$taxa\t$snvs\t/" $dfile >> $outfile

   done
   done
   done
   done
done
done
done
done
