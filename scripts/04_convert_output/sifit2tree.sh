#!/bin/bash

#logfile=sifit.log.0001
logfile=$1
treefile=`echo $logfile | sed s/log/tree/`

grep 'best tree = ' $logfile | sed 's/best tree = //' > $treefile
