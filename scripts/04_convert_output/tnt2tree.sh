#!/bin/bash

NEXUS=$1
NEWICK=$NEXUS.newick

grep "tree tnt" -A1 $NEXUS | grep -v "tree tnt" > $NEWICK
