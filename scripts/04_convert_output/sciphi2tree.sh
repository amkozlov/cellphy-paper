#!/bin/sh
# SCIPHI GV conversion 
# Usage:
# ./SCIPhI.GVConversion.sh <INPUT GV> <OUTPUT_PREFIX>

Input=$1
Output=$2

cat $Input | grep "\->" | sed 's/->/ /g' | cut -d " " -f 1,2 | awk 'BEGIN{FS="\t"}{print $0" 9150"}' > Parent_child.txt
grep "shape=box" $Input | sed 's#\[shape=box,style=filled, fillcolor=white,label=##g' | cut -d "\\" -f 1 | sed 's/"/\t/g' > Sample_Connection

python3 sciphi_ete.py Parent_child.txt 
perl taxnameconvert.pl Sample_Connection Out > $Output".SCiPhi.Tree.nwk"
sed -i 's/:9150/:1/g' $Output".SCiPhi.Tree.nwk"

rm Out
rm Parent_child.txt 
rm Sample_Connection
