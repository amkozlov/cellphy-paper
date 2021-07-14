#!/bin/bash
# VCF to pileup Conversion

if [ "$#" -lt 1 ]; then
  echo "Usage: ./vcf2sciphi.sh <VCF_FILE>"
  exit
fi

InputVCF=$1
InputRC=$InputVCF.RC.FORMAT

VCFTOOLS=`which vcftools`

if [ ! -x $VCFTOOLS ]; then
  echo "ERROR: Please install vcftools!"
  exit
fi

$VCFTOOLS --vcf $InputVCF --extract-FORMAT-info RC --out $InputVCF

grep -v "#" $InputVCF | cut -f 4 > RefAllele
nbcol=$(awk 'BEGIN{FS="\t"}{print NF}' $InputRC | head -n 1)
nbcells=$(($nbcol - 2))

for cell in `seq 1 $nbcells`
do
  col=$((2 + $cell))
  cellID=$(cut -f $col $InputRC | head -n 1)
  echo "processing cell: " $cellID

  cut -f $col $InputRC | sed 1,1d > temp

  while IFS=, read -r a c g t
  do

    if [ ! $a -eq 0 ]; then 
      printf "A%.0s" $(seq $a) 
    fi 
    if [ ! $c -eq 0 ]; then
      printf "C%.0s" $(seq $c)
    fi 
    if [ ! $g -eq 0 ]; then
      printf "G%.0s" $(seq $g)
    fi  
    if [ ! $t -eq 0 ]; then 
      printf "T%.0s" $(seq $t)
    fi  
    if [ $a -eq 0 ] && [ $c -eq 0 ] && [ $g -eq 0 ] && [ $t -eq 0 ]; then 
      printf "0"
    fi
    printf "\n"
  done < temp > temp2

  paste RefAllele temp2 | awk 'BEGIN{FS=OFS="\t"}{if ($1=="A") gsub("A",".",$2); else if($1=="C") gsub("C",".",$2); else if($1=="G") gsub("G",".",$2);  else if($1=="T") gsub("T",".",$2); print}' | cut -f 2  > temp3

  while read line
  do
    RN=${#line}
    echo -e -n "$RN\t$line\t"
    printf "~%.0s" $(seq $RN)
    printf "\n"
  done < temp3 > ${cellID}.pileup
  sed -i 's#1\t0\t~#0\t*\t*#g' ${cellID}.pileup

#  exit
done

rm temp*
rm RefAllele

echo "Merging pileups..."
samps=$(ls *.pileup)
echo $samps | tr ' ' '\n' | sed 's/.pileup//g' > $InputVCF".SampleNames.txt"
awk 'BEGIN{FS="\t"}{if ($1=="healthycell") print $0"\tCN"; else print $0"\tCT"}' $InputVCF".SampleNames.txt" > $InputVCF".CellID.txt"

grep -v "#" $InputVCF | cut -f 1,2,4 > Pos
paste Pos $samps > $InputVCF".mpileup"
rm healthy*.pileup
rm tumcell*.pileup
rm Pos


