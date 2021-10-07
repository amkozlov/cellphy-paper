library(ggplot2)
library(grid)

options(error=traceback)

cov = 5
showmin=FALSE
args = commandArgs(trailingOnly=TRUE)
if (length(args)>0) {
  cov = as.numeric(args[1])
  if (length(args)>1 && args[2] == "min") {
    showmin = TRUE
  }
}

all <- read.table("sim4.dist.txt")

#all <- rbind(all, read.table("sim4b.dist.txt.old"))

#all <- all[all$V1 != "sifit_remove_i200000",]
all <- all[all$V1 != "sifit_missing_i20000_r10",]
all <- all[all$V1 != "GTGTR4+FO",]
all <- all[all$V1 != "GTGTR4+FO+ERR_PT19",]
all <- all[all$V1 != "scite_missing",]
all <- all[all$V1 != "sciphi_default",]
all <- all[all$V1 != "mlgp_GPGTR4+FO+ERR_P20",]
all <- all[all$V1 != "GTGTR4+FO+E",]
all <- all[all$V1 != "vcf_GTGTR4+FO",]

all <- all[all$V2 == cov,]

# uncomment to use 20 reps for all methods, to have better comparison with infSCITE
#all <- all[all$V6 <= 20,]

if (showmin == FALSE) {
  all <- all[all$V1 != "iscite_keep_rfmin",]
  all <- all[all$V1 != "iscite_remove_rfmin",]
  all <- all[all$V1 != "iscite_missing_rfmin",]
  all <- all[all$V1 != "tnt_keep_rfmin",]
  all <- all[all$V1 != "tnt_remove_rfmin",]
  all <- all[all$V1 != "tnt_missing_rfmin",]
}

all$acc = 1.0-all$V8

elvl <- c("0","0.01","0.05","0.1")
elbl <- c("SEQ: 0 %", "SEQ: 1 %", "SEQ: 5 %", "SEQ: 10 %")
all$V4 <- factor(all$V4, levels = elvl, labels = elbl)

alvl <- c("0","0.1","0.25","0.5")
albl <- c("ADO: 0 %", "ADO: 10 %", "ADO: 25 %", "ADO: 50 %")
all$V3 <- factor(all$V3, levels = alvl, labels = albl)

elvl <- c("0","0.05","0.1")
elbl <- c("AMP: 0 %", "AMP: 5 %", "AMP: 10 %")
all$V5 <- factor(all$V5, levels = elvl, labels = elbl)

#mlvl <- c("GTGTR4+FO", "pars1_GTGTR4+FO+E", "sifit_keep_i200000", "sifit_remove_i200000", "sifit_missing_i200000", "GTGTR4+FO+E")
#mlbl <- c("GTGTR4+FO ", "pars1_GTGTR4+FO+E ", "sifit_keep ", "sifit_remove",  "sifit_missing ", "SciPhy")

#mlvl <- c("sifit_keep_i200000", "sifit_remove_i200000", "sifit_missing_i200000", "GTGTR4+FO+E")
#mlbl <- c("sifit_keep ", "sifit_remove",  "sifit_missing ", "SciPhy")

mlvl <- c("tnt_missing", "tnt_missing_rfmin",
          "scite_missing",
          "iscite_missing", "iscite_missing_rfmin",
          "sifit_missing_i200000", "sifit_missing_i20000_r10", "sciphi_default", "sciphi_truerate", "scis_default",
          "GTGTR4+FO", "GTGTR4+FO+E", "GTGTR4+FO+ERR_PT19", "GPGTR4+FO+ERR_P20", "mlgp_GPGTR4+FO+ERR_P20", "vcf_GTGTR4+FO", "vcf_GPGTR4+FO")
mlbl <- c("TNT", "TNT (min)", "SCITE", "infSCITE", "infSCITE (min)", "SiFit", "SiFit_r10", "SCIPhI-DEF", "SCIPhI", "ScisTree",
          "CellPhy-NOERR", "CellPhy-ML10", "CellPhy+PT19", "CellPhy-ML16", "CellPhy-MLph", "CellPhy-GL10", "CellPhy-GL16")

all$V1 <- factor(all$V1, levels = mlvl, labels = mlbl)

cbFill <- c("#A6CEE3", "#1F78B4", "#FDBF6F", "#FF7F00", "#CAB2D6", "#6A3D9A", "#B15928")

if (showmin == FALSE) {
  cbFill <- c('palegreen', 'lightblue', 'khaki', 'orange', 'moccasin', 'indianred', 'red', 'chocolate', 'brown')
#  cbFill <- c('darkseagreen1', 'lightblue', 'khaki', 'orange', 'indianred', 'red', 'yellow', 'chocolate', 'brown')
} else {
  cbFill <- c('darkseagreen1', 'limegreen', 'lightblue', 'deepskyblue',
              'khaki', 'indianred', 'chocolate')
}

p <- ggplot() + geom_boxplot(data=all, aes(x = V1, y = acc, fill = V1), outlier.size=1, outlier.color="lightgrey") 

#p <- p + facet_wrap(~V3, ncol=2)

#p <- p + facet_wrap(~V2, ncol=4)

#, labeller = label_wrap_gen(multi_line=FALSE))

p <- p + facet_grid(all$V3~all$V5+all$V4)
#, scales = "free")

#p <- p + theme_bw()

p <- p + theme_light(base_size = 12) + theme(axis.text = element_text(size = 10)) 

p <- p + scale_fill_manual(name="Method", values=cbFill)

#p <- p + scale_fill_brewer(palette="Pastel2")

#p <- p + ggtitle(sprintf("Tree reconstruction accuracy in Scenario 5: signature S1, 40 cells, NGS with %dx coverage", cov))
p <- p + ggtitle(sprintf("Tree reconstruction accuracy in Simulation 4: NGS-like, %dx coverage", cov))

p <- p + theme(plot.title=element_text(vjust=2, hjust = 0.5, color="black"))

p <- p + labs(subtitle = "Genotype error", y = "Phylogenetic accuracy", fill = "Method")

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
               axis.title.x=element_blank(),
               axis.text.x=element_blank()
               )


p

if (showmin == FALSE) {
  fname <- sprintf("SIM4_C%d_rfdist.png", cov)
  ftitle = sprintf("SIM4 C%d RFdist", cov)
} else {
  fname <- sprintf("SIM4_C%d_rfdist_min.png", cov)
  ftitle = sprintf("SIM4 C%d RFdist (MIN)", cov)
}

ggsave(fname, width=24, height=23, units = "cm", title=ftitle)

