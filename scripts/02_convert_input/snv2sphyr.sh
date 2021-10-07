#!/bin/bash
# SPHYR conversion from oncoNEM input
# Usage:
# ./snv2sphyr.sh <SNV_FILE> <keep | remove | missing>


if [ "$#" -lt 2 ]; then
    echo "Usage: ./snv2sphyr.sh <SNV_FILE> <keep | remove | missing>"
    exit
fi

snv=$1
trial=$2
input=${snv}.$trial.onco
output=${snv}.$trial.sphyr

if [ ! -f $input ]; then
  echo "Input file not found: $input"
  echo "Please run ./snv2oncoNEM.py first!"
  exit
fi

#python2.7 snv2oncoNEM.py input/snv_hap.${replicate} input/true_hap.${replicate} missing

./transpose.sh $input | awk 'BEGIN{FS=" "}NR>1{print $0}' | cut -d " " -f 2- | sed 's/2/-1/g' > $output

cat $input | awk 'BEGIN{FS=" "}NR>1{print $0}' | cut -d " " -f 1 > $output.snv_labels
cat $input | head -n 1 | cut -d " " -f 2- | tr ' ' '\n' | sed '/^$/d' > $output.cell_labels

n_cells=$(cat $output | wc -l)
n_mutations=$(awk '{print NF}' $output | sort -nu | tail -n 1)

head1="$n_cells #cells"
head2="$n_mutations #SNVs"

sed -e "1i $head1" -e "1i $head2" -i $output
