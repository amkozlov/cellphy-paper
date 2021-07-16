#!/bin/bash

#simroot=/path/to/simulation

if [ -z $simroot ]; then
  echo "Please define simroot variable!"
  exit
fi

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
compdist=$scriptdir/compdist.py

sim=sim2

dsroot=$simroot/$sim

skipfull=yes

outfile=${sim}.dist.txt

#echo -e "tool\tADO\tSEQERR\tRF\tnRF\tRFL\tnRFL\ttreelen_ratio" > $outfile
echo "" > $outfile

raxml_models="GTGTR4+FO+E GPGTR4+FO+ERR_P20"
sifit_models="sifit_keep_i200000 sifit_remove_i200000 sifit_missing_i200000"
iscite_models="iscite_keep iscite_remove iscite_missing"
tnt_models="tnt_keep tnt_remove tnt_missing"
all_models="$sifit_models $raxml_models $iscite_models $tnt_models"

for ado in 0.00 0.10 0.25 0.50 
do
  for err in 0.00 0.01 0.05 0.10 
  do  

   ds=${sim}.D${ado}G${err}
   dsdir=$dsroot/$ds

   if [ ! -d $dsdir ]; then
     echo "WANRING: dir $dsdir is missing!"
     continue
   fi

   for model in $all_models;  do
    
    dfile=$dsdir/dist_$model.csv
    dfile2=$dsdir/distmin_$model.csv

#    echo `cat $dfile | wc -l`

    if [ -f $dfile ] && [ "`cat $dfile | wc -l`" = "101"  ] && [ "$skipfull" = "yes" ]; then
      echo "SKIP: $dfile"
#      continue
    else

      treefile=$dsdir/rxsnv_trees/$model/t0001.raxml.bestTree
      sifittree=$dsdir/sifit_trees/$model/sifit.tree.0001
      iscitetree=$dsdir/iscite_trees/$model/snv_hap.0001_ml0.final-end.newick
      tnttree=$dsdir/tnt_trees/$model/snv_hap.0003.TNT.Tree.newick
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

    sed -e '1d' -e "s/^/$model\t$ado\t$err\t/" $dfile >> $outfile

    if [ -f $dfile2 ]; then
      sed -e '1d' -e "s/^/${model}_rfmin\t$ado\t$err\t/" $dfile2 >> $outfile
    fi

   done
done
done
