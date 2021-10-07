#!/bin/bash
# Cellcoal RC to AD conversion using VCF 
# Usage:
# ./vcf2scis.sh <INPUT_VCF>

Input=$1
Input42=${Input}.VCF42
scisAD=${Input}.AD-toScisTree
scisDAT=${Input}.scis

#VCFTOOLS=/path/to/vcftools
VCFTOOLS=`which vcftools`
#SCPROB=/path/to/scprob

if [ ! -x $VCFTOOLS ]; then
  echo "ERROR: Please install vcftools!"
  exit
fi

if [ ! -x $SCPROB ]; then
  echo "ERROR: Please specify path to scprob program from ScisTree!"
  exit
fi

# define simulation ID and generate RC file

sed 's/^##fileformat=VCFv4.3/##fileformat=VCFv4.2/' $Input > $Input42

$VCFTOOLS --vcf ${Input42} --freq --out temp
$VCFTOOLS --vcf ${Input42} --extract-FORMAT-info RC --out temp

# identify most common alleles in pop through genotype frequency
grep -v "CHR" temp.frq > temp.genos

nbsites=$(cat temp.genos | wc -l)

cut -f 1,2 temp.genos | sed 's/ /\t/g' > get.pos
cut -f 5- temp.genos > get.genos

while read file
do

echo $file | tr ' ' '\n' | sed 's/:/\t/g' | sort -k2,2nr | head -n 2 | cut -f 1 | tr '\n' '\t' >> get.common_alleles
echo "" >> get.common_alleles

done < get.genos

paste get.pos get.common_alleles >> ${Input}.commonalleles

rm get.pos get.genos get.common_alleles

# get read counts for common alleles 
nbfields=$(awk 'BEGIN{FS="\t"}{print NF}' temp.RC.FORMAT | head -n 1)
nbcells=$((nbfields - 2))

grep "CHR" temp.RC.FORMAT > final.head
grep -v "CHR" temp.RC.FORMAT > temp.rc.full 
cut -f 1,2 temp.rc.full > AD.final

for j in $( seq 1 $nbcells )
do
col=$((j+2))
cut -f 1,2,$col temp.rc.full > rc.temp
paste ${Input}.commonalleles rc.temp | sed 's/,/\t/g' | awk 'BEGIN{FS="\t"}{if ($1==$6 && $2==$7) print $0}' | 
awk 'BEGIN{FS="\t"}{if ($3=="A" && $4=="C") print $8","$9; 
else if ($3=="A" && $4=="G") print $8","$10;
else if ($3=="A" && $4=="T") print $8","$11;
else if ($3=="C" && $4=="A") print $9","$8; 
else if ($3=="C" && $4=="G") print $9","$10;
else if ($3=="C" && $4=="T") print $9","$11;
else if ($3=="G" && $4=="A") print $10","$8; 
else if ($3=="G" && $4=="C") print $10","$9;
else if ($3=="G" && $4=="T") print $10","$11;
else if ($3=="T" && $4=="A") print $11","$8; 
else if ($3=="T" && $4=="C") print $11","$9;
else if ($3=="T" && $4=="G") print $11","$10;
else print "NA"}' > rc.ind

# join to final
paste AD.final rc.ind >> temp.AD
mv temp.AD AD.final
done 
cat final.head AD.final >> ${Input}.AD

echo -e "HAPLOID "$nbsites" "$nbcells > $scisAD
cut -f 3- ${Input}.AD | sed 's/,/ /g' | sed 's/\t/     /g' | awk 'BEGIN{FS="\t"}NR>1{print $0}'  >> $scisAD

$SCPROB $scisAD > $scisDAT

# replace cN with original cell names 
echo -en "HAPLOID $nbsites $nbcells " > scis.head
cut -f3- final.head | tr "\t" " " >> scis.head
sed -e '1r scis.head' -e '1d' -i $scisDAT

# remove temp files
rm scis.head
rm temp*
rm final.head
rm *commonalleles
rm rc*
rm AD.final
rm ${Input}.AD
rm $Input42
rm $scisAD
