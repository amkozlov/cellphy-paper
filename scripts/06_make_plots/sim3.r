library(ggplot2)
library(grid)

options(error=traceback)

sig = "S1"
showmin = FALSE
args = commandArgs(trailingOnly=TRUE)
if (length(args)>0) {
  sig = args[1] 
  if (length(args)>1 && args[2] == "min") {
    showmin = TRUE
  }
}

all <- read.table("sim3.dist.txt")

#all <- rbind(all, read.table("sim4b.dist.txt.old"))

all <- all[all$V2 != "sifit_remove_i200000",]
all <- all[all$V2 != "sifit_keep_i200000",]
all <- all[all$V2 != "GTGTR4+FO",]
all <- all[all$V2 != "GTGTR4+FO+ERR_PT19",]

all <- all[all$V2 != "scite_keep",]
all <- all[all$V2 != "scite_remove",]
all <- all[all$V2 != "scite_missing",]

all <- all[all$V2 != "GTGTR4+FO+E",]

all <- all[all$V1 == sig,]

# uncomment to use 20 reps for all methods, to have better comparison with infSCITE
#all <- all[all$V5 <= 20,]

if (showmin == FALSE) {
  all <- all[all$V2 != "iscite_keep_rfmin",]
  all <- all[all$V2 != "iscite_remove_rfmin",]
  all <- all[all$V2 != "iscite_missing_rfmin",]
  all <- all[all$V2 != "tnt_keep_rfmin",]
  all <- all[all$V2 != "tnt_remove_rfmin",]
  all <- all[all$V2 != "tnt_missing_rfmin",]
}

all$acc = 1.0 - all$V7

elvl <- c("0","0.01","0.1","0.2")
elbl <- c("ERR: 0 %", "ERR: 1 %", "ERR: 10 %", "ERR: 20 %")
all$V4 <- factor(all$V4, levels = elvl, labels = elbl)

alvl <- c("0","0.05","0.15","0.5")
albl <- c("ADO: 0 %", "ADO: 5 %", "ADO: 15 %", "ADO: 50 %")
all$V3 <- factor(all$V3, levels = alvl, labels = albl)

#mlvl <- c("GTGTR4+FO", "pars1_GTGTR4+FO+E", "sifit_keep_i200000", "sifit_remove_i200000", "sifit_missing_i200000", "GTGTR4+FO+E")
#mlbl <- c("GTGTR4+FO ", "pars1_GTGTR4+FO+E ", "sifit_keep ", "sifit_remove",  "sifit_missing ", "SciPhy")

#mlvl <- c("sifit_keep_i200000", "sifit_remove_i200000", "sifit_missing_i200000", "GTGTR4+FO+E")
#mlbl <- c("sifit_keep ", "sifit_remove",  "sifit_missing ", "SciPhy")

mlvl <- c("tnt_keep", "tnt_remove", "tnt_missing", "tnt_missing_rfmin",
          "scite_keep", "scite_remove", "scite_missing",
          "iscite_keep", "iscite_remove", "iscite_missing", "iscite_missing_rfmin",
          "sifit_keep_i200000", "sifit_remove_i200000", "sifit_missing_i200000",
          "GTGTR4+FO+E", "GPGTR4+FO+ERR_P20")
mlbl <- c("TNT_keep", "TNT_remove", "TNT", "TNT (min)", 
          "SCITE_keep", "SCITE_remove", "SCITE",
          "infSCITE_keep", "infSCITE_remove", "infSCITE", "infSCITE (min)",
          "SiFit_keep ", "SiFit_remove",  "SiFit ",
          "CellPhy-ML10", "CellPhy-ML16")

all$V2 <- factor(all$V2, levels = mlvl, labels = mlbl)

#cbFill <- c("#A6CEE3", "#1F78B4", "#FDBF6F", "#FF7F00", "#CAB2D6", "#6A3D9A", "#B15928")

if (showmin == FALSE) {
  cbFill <- c('palegreen', 'lightblue', 'khaki', 'indianred', 'red')
} else {
  cbFill <- c('darkseagreen1', 'limegreen', 'lightblue', 'deepskyblue',
              'khaki', 'indianred', 'red')
}

p <- ggplot() + geom_boxplot(data=all, aes(x = V2, y = acc, fill = V2), outlier.size=1, outlier.color="lightgrey") 

#p <- p + facet_wrap(~V3, ncol=2)

#p <- p + facet_wrap(~V2, ncol=4)

#, labeller = label_wrap_gen(multi_line=FALSE))

p <- p + facet_grid(all$V3~all$V4)
#, scales = "free")

#p <- p + theme_bw()

p <- p + theme_light(base_size = 12) + theme(axis.text = element_text(size = 6)) 

p <- p + scale_fill_manual(name="Method", values=cbFill)

#p <- p + scale_fill_brewer(palette="Pastel2")

p <- p + ggtitle(sprintf("Tree reconstruction accuracy in Simulation 3: WGS-sig, COSMIC signature %s", sig))

p <- p + theme(plot.title=element_text(vjust=2, hjust = 0.5, color="black"))

p <- p + labs(subtitle = "Genotype error rate", y = "Phylogenetic accuracy", fill = "Method")

p <- p + guides(fill = guide_legend(nrow = 1))

p <- p + scale_y_continuous(breaks=seq(0,1.0,0.1), sec.axis = dup_axis(name = "ADO rate", breaks=NULL))

#p <- p + scale_x_continuous(position = "top")

#p <- p + scale_colour_manual(name  ="Signature", values = c())

#p <- p + scale_colour_manual(name  ="Error model", values = c("black", "red", "darkorange", "blue"),
#          labels = c("no correction (STD)", "estimated uniform (eUFE)", "true uniform (tUFE)", "true position-specific (tPSE)"))

p <- p + theme(legend.position="bottom", 
               legend.background = element_rect(fill="grey90"),
               strip.background=element_rect(fill="lightgray"),
               strip.text.x=element_text(color="black"),
               strip.text.y=element_text(color="black"),
               axis.title.x=element_blank()
               )


p

#fname <- sprintf("sim4b_%s_rfdist.pdf", sig)

if (showmin == FALSE) {
  fname = sprintf("SIM3_%s_rfdist.png", sig)
  ftitle = sprintf("SIM3 %s RFdist", sig)
} else {
  fname = sprintf("sim3_%s_rfdist_min.png", sig)
  ftitle = sprintf("SIM3 %s RFdist (MIN) ", sig)
}


ggsave(fname, width=24, height=23, units = "cm", title=ftitle)


