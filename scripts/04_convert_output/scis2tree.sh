#!/bin/bash

#logfile=scis.log.0001
logfile=$1
treefile=`echo $logfile | sed s/log/tree/`

grep "Constructed single cell phylogeny: " $logfile | sed 's/Constructed single cell phylogeny: //' | sed 's/$/;/' > $treefile
