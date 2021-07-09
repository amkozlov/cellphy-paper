#!/bin/bash

#ALI=<dataset>/snv_haplotypes_dir/snv_hap.0001
ALI=$1

PHYLIP=$ALI.phy
sed '2d' $ALI > $PHYLIP

