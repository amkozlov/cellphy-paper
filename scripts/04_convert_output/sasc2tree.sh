#!/bin/bash

output=$1

cat $output | grep "\->" | gsed 's/->/ /g' | gsed 's/\t//g' | gsed 's/  */ /g' | gsed 's/\"//g' | gsed 's/;//g' | awk 'BEGIN{FS=" "}{print $0" 1.0"}' > Parent_child.SASC.txt
python3 SASC.conversion.py Parent_child.SASC.txt
Rscript --vanilla  SASC.conversion.R Out 

mv final ${output}.newick
rm Parent_child.SASC.txt
rm Out
