#!/bin/bash

#simroot=/path/to/simulation

if [ -z $simroot ]; then
  echo "Please define simroot variable!"
  exit
fi

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
compdist=$scriptdir/compdist.py

sim=sim4

dsroot=$simroot/$sim

outfile=${sim}.dist.txt

#echo -e "tool\tADO\tSEQERR\tRF\tnRF\tRFL\tnRFL\ttreelen_ratio" > $outfile

rm $outfile

raxml_models="GTGTR4+FO+E GPGTR4+FO+ERR_P20"
rxvcf_models="vcf_GTGTR4+FO vcf_GPGTR4+FO"
sifit_models="sifit_missing_i200000"
iscite_models="iscite_missing"
sciphi_models="sciphi_default sciphi_truerate"
tnt_models="tnt_missing"
all_models="$raxml_models $rxvcf_models $sifit_models $iscite_models $tnt_models $sciphi_models"

for cov in 5 30 100
do

for ado in 0.00 0.10 0.25 
do
  for err in 0.00 0.01 0.05 
  do  

  for amp in 0.00 0.05 0.10
  do

   ds=${sim}.C${cov}.D${ado}E${err}A${amp}
   dsdir=$dsroot/$ds
  
   if [ ! -d $dsdir ]; then
     echo "WARNING: dir $dsdir is missing!"
     continue
   fi

   for model in $all_models;  do
    
    dfile=$dsdir/dist_$model.csv
    dfile2=$dsdir/distmin_$model.csv

#    echo `cat $dfile | wc -l`

    if [ -f $dfile ] && [ "`cat $dfile | wc -l`" = "101"  ]; then
      echo "SKIP: $dfile"
    else

      mltreefile=$dsdir/rxmlgt_trees/$model/t0001.raxml.bestTree
      vcftreefile=$dsdir/rxvcf_trees/$model/t0001.raxml.bestTree
      sifittree=$dsdir/sifit_trees/$model/sifit.tree.0001
      iscitetree=$dsdir/iscite_trees/$model/snv_hap.0001_ml0.final-end.newick
      tnttree=$tnt_dir/$model/snv_hap.0001.TNT.Tree.newick
      sciphitree=$sciphi_dir/$model/0001.SCiPhi.Tree.nwk
      if [ -f $mltreefile ]; then
        $compdist $ds $model rxmlgt
     elif [ -f $vcftreefile ]; then
        $compdist $ds $model rxvcf
      elif [ -f $sifittree ]; then
        $compdist $ds $model sifit
      elif [ -f $iscitetree ]; then
        $compdist $ds $model iscite min
      elif [ -f $tnttree ]; then
        $compdist $ds $model tnt min
      elif [ -f $sciphitree ]; then
        $compdist $ds $model sciphi
      else
        echo "WARNING: file $dfile missing!"
        continue
      fi
    fi

    sed -e '1d' -e "s/^/$model\t$cov\t$ado\t$err\t$amp\t/" $dfile >> $outfile
    
    if [ -f $dfile2 ]; then
      sed -e '1d' -e "s/^/${model}_rfmin\t$cov\t$ado\t$err\t$amp\t$dbl\t/" $dfile2 >> $outfile
    fi

   done
done
done
done
done
