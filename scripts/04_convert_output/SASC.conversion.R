#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
library(ape)
t = read.tree(args[1])
keep=c("tumcell0001","tumcell0002","tumcell0003","tumcell0004","tumcell0005","tumcell0006","tumcell0007","tumcell0008","tumcell0009","tumcell0010","tumcell0011","tumcell0012","tumcell0013","tumcell0014","tumcell0015","tumcell0016","tumcell0017","tumcell0018","tumcell0019","tumcell0020","tumcell0021","tumcell0022","tumcell0023","tumcell0024","tumcell0025","tumcell0026","tumcell0027","tumcell0028","tumcell0029","tumcell0030","tumcell0031","tumcell0032","tumcell0033","tumcell0034","tumcell0035","tumcell0036","tumcell0037","tumcell0038","tumcell0039","tumcell0040","healthycell")

remove=t$tip.label[! t$tip.label %in% keep]
t2=drop.tip(t, remove, trim.internal=T, collapse.singles=F)
write.tree(t2, "final")
