#!/bin/bash
# TNT conversion from oncoNEM input
# Usage:
# ./snv2TNT.sh <SNV_FILE> <keep | remove | missing>

if [ "$#" -lt 2 ]; then
    echo "Usage: ./snv2TNT.sh <SNV_FILE> <keep | remove | missing>"
    exit
fi

snv=$1
trial=$2
input=${snv}.$trial.onco
output=${snv}.$trial.tnt

if [ ! -f $input ]; then
  echo "Input file not found: $input"
  echo "Please run ./snv2oncoNEM.py first!"
  exit
fi

ncells=$(cut -d " " -f 2- $input | awk 'BEGIN{FS=" "}{print NF}' | head -n 1)
nsites=$(cat $input | wc -l | awk '{print $0-1}')

echo -e "xread\n"$nsites" "$ncells > $output
for i in $(seq 1 $ncells)
do
j=$((i+1))
id=$(cut -d " " -f $j $input | head -n 1)
seq=$(cut -d " " -f $j $input | tail -n $nsites | tr '\n' ' ' | sed 's/ //g')
echo -e $id" "$seq >> $output
done
echo ";" >> $output

echo "TNT mutation matrix: $output"
