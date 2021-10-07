#!/bin/bash

output=$1

cat $output  | grep "\->" | gsed 's/->/ /g' | gsed 's/\t//g' | gsed 's/  */ /g' | cut -d " " -f 1,2 | awk 'BEGIN{FS="\t"}{print $0" 9150"}' > Parent_child.SPHYR.txt
grep "cell" $output | gsed 's/\t//g' | gsed 's/\[label=\"//g' | gsed 's/\"\]//g' | gsed 's/\\n/ /g' | cut -d " " -f 1 > node
grep "cell" $output | gsed 's/\t//g' | gsed 's/\[label=\"//g' | gsed 's/\"\]//g' | gsed 's/\\n/ /g' | cut -d " " -f 2- | gsed 's/ /,/g' > cell
paste node cell > Sample_Connection_SPHYR

python3 sciphi_ete.py Parent_child.SPHYR.txt
perl taxnameconvert.pl Sample_Connection_SPHYR Out > ${output}.SPhyR.Tree.nwk
gsed -i 's/:9150/:1/g' ${output}.SPhyR.Tree.nwk
rm Out
rm node cell
rm Sample_Connection_SPHYR
rm Parent_child.SPHYR.txt
