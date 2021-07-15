Scripts to run tree inference with different tools.

!!! Please modify scripts and set correct locations for tool executables and (simulated) datasets !!!

By default, first replicate will be used as input. This can be changed as follows:

 $ ./run_cellphy_ML.sh 5            -> replicate #5

 $ ./run_cellphy_ML.sh 1 100        -> all replicates #1 to #100



- CellPhy-ML (genotype matrix input)

  $ ./run_cellphy_ML.sh



- CellPhy-GL (VCF input)

  $ ./run_cellphy_GL.sh


- SIFIT

  By default, "missing" strategy is used; please modify script to use "keep" or "remove".

  $ ./run_sifit.sh


- TNT

  $ ./run_TNT.sh


- oncoNEM

  $ ./run_oncoNEM.sh


- infSCITE

  $ ./run_infSCITE.sh

