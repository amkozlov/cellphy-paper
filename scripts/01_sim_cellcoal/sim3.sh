#!/bin/bash

#Simulation 3 design
#14/06/18

#Sim3: genotype simulation under trinucleotide genetic signatures (ISM), large number of SNVs (whole-genome sequencing)
#ADO = 0.00, 0.10, 0.25, 0.50
#genotype error = 0.00, 0.01, 0.05, 0.10
#cells = 100  --@dposada: maybe we want to try smaller trees to get better RF
#transforming branch length=0.01  --@dposada:keep an eye on this, it might be too big in some ocasions?
#rate variation among lineages (alpha=1)
#sites = 10000
#growthRate = 10-4
#mutation rate = 10-6
#model = signature 1, signature 5
#replicates = 100  

./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.00 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#400011 -osim3.S1.D0G0
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.01 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#400013 -osim3.S1.D0G0.01
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.10 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#400015 -osim3.S1.D0G0.1
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.20 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#400017 -osim3.S1.D0G0.2

./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.00 -D0.05 -1 -2 -3 -4 -6 -9 -v -x -#400021 -osim3.S1.D0.05G0
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.01 -D0.05 -1 -2 -3 -4 -6 -9 -v -x -#400023 -osim3.S1.D0.05G0.01
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.10 -D0.05 -1 -2 -3 -4 -6 -9 -v -x -#400025 -osim3.S1.D0.05G0.1
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.20 -D0.05 -1 -2 -3 -4 -6 -9 -v -x -#400027 -osim3.S1.D0.05G0.2

./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.00 -D0.15 -1 -2 -3 -4 -6 -9 -v -x -#400031 -osim3.S1.D0.15G0
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.01 -D0.15 -1 -2 -3 -4 -6 -9 -v -x -#400033 -osim3.S1.D0.15G0.01
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.10 -D0.15 -1 -2 -3 -4 -6 -9 -v -x -#400035 -osim3.S1.D0.15G0.1
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.20 -D0.15 -1 -2 -3 -4 -6 -9 -v -x -#400037 -osim3.S1.D0.15G0.2

./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.00 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#400041 -osim3.S1.D0.5G0
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.01 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#400043 -osim3.S1.D0.5G0.01
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.10 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#400045 -osim3.S1.D0.5G0.1
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 1 1.00 -G0.20 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#400047 -osim3.S1.D0.5G0.2

./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.00 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#400051 -osim3.S5.D0G0
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.01 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#400053 -osim3.S5.D0G0.01
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.10 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#400055 -osim3.S5.D0G0.1
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.20 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#400057 -osim3.S5.D0G0.2

./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.00 -D0.05 -1 -2 -3 -4 -6 -9 -v -x -#400061 -osim3.S5.D0.05G0
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.01 -D0.05 -1 -2 -3 -4 -6 -9 -v -x -#400063 -osim3.S5.D0.05G0.01
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.10 -D0.05 -1 -2 -3 -4 -6 -9 -v -x -#400065 -osim3.S5.D0.05G0.1
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.20 -D0.05 -1 -2 -3 -4 -6 -9 -v -x -#400067 -osim3.S5.D0.05G0.2

./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.00 -D0.15 -1 -2 -3 -4 -6 -9 -v -x -#400071 -osim3.S5.D0.15G0
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.01 -D0.15 -1 -2 -3 -4 -6 -9 -v -x -#400073 -osim3.S5.D0.15G0.01
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.10 -D0.15 -1 -2 -3 -4 -6 -9 -v -x -#400075 -osim3.S5.D0.15G0.1
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.20 -D0.15 -1 -2 -3 -4 -6 -9 -v -x -#400077 -osim3.S5.D0.15G0.2

./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.00 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#400081 -osim3.S5.D0.5G0
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.01 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#400083 -osim3.S5.D0.5G0.01
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.10 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#400085 -osim3.S5.D0.5G0.1
./cellcoal -n100 -s60 -l10000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -u1e-6 -m0 -p0 -S1 5 1.00 -G0.20 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#400087 -osim3.S5.D0.5G0.2
