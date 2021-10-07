#!/bin/bash
# SASC conversion from oncoNEM input
# Usage:
# ./snv2sasc.sh <SNV_FILE> <keep | remove | missing>

if [ "$#" -lt 2 ]; then
    echo "Usage: ./snv2sasc.sh <SNV_FILE> <keep | remove | missing>"
    exit
fi

snv=$1
trial=$2
input=${snv}.$trial.onco
output=${snv}.$trial.sasc

if [ ! -f $input ]; then
  echo "Input file not found: $input"
  echo "Please run ./snv2oncoNEM.py first!"
  exit
fi

#python2 snv2oncoNEM.py input/snv_hap.${replicate} input/true_hap.${replicate} missing

./transpose.sh $input | awk 'BEGIN{FS=" " }NR>1{print $0}' | cut -d " " -f 2- > $output 

head -n 1 $input | tr ' ' '\n' | grep -v "snv" | sed -r '/^\s*$/d' > $output.CellID
