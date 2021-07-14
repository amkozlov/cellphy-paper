Scripts in this directory can be used to convert data simulated by CellCoal
to the input format required by different tree inference tools.
We assume that <DATADIR> is the root directory of the specific simulation scenario.

- CELLPHY

 $ ./snv2cellphy.sh <DATADIR>/snv_haplotypes_dir/snv_hap.0001

- SIFIT

 $ ./snv2sifit.py <DATADIR>/snv_haplotypes_dir/snv_hap.0001 <DATADIR>/true_haplotypes_dir/true_hap.0001 keep

 $ ./snv2sifit.py <DATADIR>/snv_haplotypes_dir/snv_hap.0001 <DATADIR>/true_haplotypes_dir/true_hap.0001 remove

 $ ./snv2sifit.py <DATADIR>/snv_haplotypes_dir/snv_hap.0001 <DATADIR>/true_haplotypes_dir/true_hap.0001 missing


- infSCITE

 same as above:

 $ ./snv2infSCITE.py <DATADIR>/snv_haplotypes_dir/snv_hap.0001 <DATADIR>/true_haplotypes_dir/true_hap.0001 < keep | remove | missing >

- oncoNEM

 $ ./snv2oncoNEM.py <DATADIR>/snv_haplotypes_dir/snv_hap.0001 <DATADIR>/true_haplotypes_dir/true_hap.0001 < keep | remove | missing >

- TNT

 !!! uses oncoNEM matrix as input -> please run ./snv2oncoNEM.py first !!!

 $ ./snv2TNT.sh <DATADIR>/snv_haplotypes_dir/snv_hap.0001 < keep | remove | missing >

- SCIPhi

 !!! vcftools required !!!

 $ ./vcf2sciphi.sh <DATADIR>/vcf_dir/vcf.0001

