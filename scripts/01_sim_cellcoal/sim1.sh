#!/bin/bash

#Simulation 1 design
#27/03/18

#Sim1: genotype simulation under an infinite-site model, low number of SNVs  (targeted/exome sequencing)
#ADO: 0.00, 0.10, 0.25, 0.5
#genotype error: 0.00, 0.01, 0.05, 0.10
#cells = 40
#rate variation among lineages (alpha=1)
#number of fixed SNVs = 250, 500, 1000
#growthRate = 10-4
#model = ISM diploid + collapsed signature 1
#replicates = 100


./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200011 -osim1.D0.00G0.00j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200013 -osim1.D0.00G0.01j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200015 -osim1.D0.00G0.05j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200017 -osim1.D0.00G0.10j250

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200021 -osim1.D0.10G0.00j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200023 -osim1.D0.10G0.01j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200025 -osim1.D0.10G0.05j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200027 -osim1.D0.10G0.10j250

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200031 -osim1.D0.25G0.00j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200033 -osim1.D0.25G0.01j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200035 -osim1.D0.25G0.05j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200037 -osim1.D0.25G0.10j250

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200041 -osim1.D0.50G0.00j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200043 -osim1.D0.50G0.01j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200045 -osim1.D0.50G0.05j250
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j250 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200047 -osim1.D0.50G0.10j250


./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200051 -osim1.D0.00G0.00j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200053 -osim1.D0.00G0.01j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200055 -osim1.D0.00G0.05j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200057 -osim1.D0.00G0.10j500

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200061 -osim1.D0.10G0.00j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200063 -osim1.D0.10G0.01j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200065 -osim1.D0.10G0.05j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200067 -osim1.D0.10G0.10j500

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200071 -osim1.D0.25G0.00j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200073 -osim1.D0.25G0.01j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200075 -osim1.D0.25G0.05j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200077 -osim1.D0.25G0.10j500

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200081 -osim1.D0.50G0.00j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200083 -osim1.D0.50G0.01j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200085 -osim1.D0.50G0.05j500
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j500 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200087 -osim1.D0.50G0.10j500


./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200091 -osim1.D0.00G0.00j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200093 -osim1.D0.00G0.01j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200095 -osim1.D0.00G0.05j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.00 -1 -2 -3 -4 -6 -9 -v -x -#200097 -osim1.D0.00G0.10j1000

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200111 -osim1.D0.10G0.00j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200113 -osim1.D0.10G0.01j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200115 -osim1.D0.10G0.05j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.10 -1 -2 -3 -4 -6 -9 -v -x -#200117 -osim1.D0.10G0.10j1000

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200121 -osim1.D0.25G0.00j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200123 -osim1.D0.25G0.01j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200125 -osim1.D0.25G0.05j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.25 -1 -2 -3 -4 -6 -9 -v -x -#200127 -osim1.D0.25G0.10j1000

./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.00 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200131 -osim1.D0.50G0.00j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.01 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200133 -osim1.D0.50G0.01j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.05 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200135 -osim1.D0.50G0.05j1000
./cellcoal -n100 -s40 -l5000 -e10000 -g1.0e-04 -k1.0e-02 -i1.0 -b1 -j1000 -p0.0 -f0.3 0.2 0.2 0.3 -r0.00 0.03 0.12 0.04 0.11 0.00 0.02 0.68 0.68 0.02 0.00 0.11 0.04 0.12 0.03 0.00 -G0.10 -D0.50 -1 -2 -3 -4 -6 -9 -v -x -#200137 -osim1.D0.50G0.10j1000
