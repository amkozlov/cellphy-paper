library(ggplot2)
library(grid)
library(dplyr)

options(error=traceback)

all <- read.table("sim1.dist.txt")

args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  j = 250
} else {
  j = as.numeric(args[1])
}

all <- all[all$V1 == j,]
#all <- all[all$V2 != "",]
all <- all[all$V2 != "GTGTR4+FO",]
all <- all[all$V2 != "GTGTR4+FO+E",]
all <- all[all$V2 != "scite_keep",]
all <- all[all$V2 != "scite_remove",]
all <- all[all$V2 != "scite_missing",]
all <- all[all$V2 != "pars1_GTGTR4+FO+ERR_PT19",]

all <- all[all$V2 != "onem_keep",]
all <- all[all$V2 != "onem_remove",]
all <- all[all$V2 != "tnt_keep",]
all <- all[all$V2 != "tnt_remove",]
all <- all[all$V2 != "iscite_keep",]
all <- all[all$V2 != "iscite_remove",]
all <- all[all$V2 != "sifit_keep_i200000",]
all <- all[all$V2 != "sifit_remove_i200000",]

all <- all[all$V2 != "pars1_GTGTR4+FO+E",]
all <- all[all$V2 != "mlgp_GPGTR4+FO+ERR_P20",]

#all <- all[all$V2 != "onem_missing",]

all <- all[all$V5 <= 20,]

all$ds = paste(all$V3, all$V4)

all <- filter(all, ds == "0 0" | ds == "0.1 0.01")

#all <- all[all$V3 != "0.25",]

#head(all)

all$acc = 1.0 - all$V7

elvl <- c("0","0.01","0.05","0.1")
elbl <- c("ERR: 0 %", "ERR: 1 %", "ERR: 5 %", "ERR: 10 %")
all$V4 <- factor(all$V4, levels = elvl, labels = elbl)

alvl <- c("0","0.1","0.25","0.5")
albl <- c("ADO: 0 %", "ADO: 10 %", "ADO: 25 %", "ADO: 50 %")
all$V3 <- factor(all$V3, levels = alvl, labels = albl)

mlvl <- c("tnt_keep", "tnt_remove", "tnt_missing",
          "onem_keep", "onem_remove", "onem_missing",
          "sasc_missing", "sphyr_missing",
           "scite_keep", "scite_remove", "scite_missing",
          "iscite_keep", "iscite_remove", "iscite_missing",
          "sifit_keep_i200000", "sifit_remove_i200000", "sifit_missing_i200000",
          "pars1_GTGTR4+FO+E", "pars1_GTGTR4+FO+ERR_PT19", "pars1_GPGTR4+FO+ERR_P20", "mlgp_GPGTR4+FO+ERR_P20")
mlbl <- c("TNT (keep)", "TNT (remove)", "TNT",
          "oncoNEM (keep)", "oncoNEM (remove)", "oncoNEM",
          "SASC", "SPhyR",
          "SCITE (keep)", "SCITE_remove", "SCITE",
          "infSCITE (keep)", "infSCITE (remove)", "infSCITE",
          "SiFit (keep)", "SiFit (remove)",  "SiFit",
          "CellPhy-ML10", "CellPhy-PT19",  "CellPhy-ML16", "CellPhy-MLph")
all$V2 <- factor(all$V2, levels = mlvl, labels = mlbl)

#cbFill <- c('darkgray','gray','lightgray','seagreen','limegreen','palegreen','dodgerblue','deepskyblue','lightblue',
#            'gold', 'yellow', 'khaki', 'indianred', 'red', 'darkred')

cbFill <- c('palegreen', 'grey', 'yellow1', 'darkolivegreen3', 'lightblue', 'khaki', 'indianred', 'red', 'darkred')


p <- ggplot() + geom_boxplot(data=all, aes(x = V2, y = acc, fill = V2), outlier.size=1, outlier.color="lightgrey")

p <- p + facet_grid(. ~ all$V3+all$V4)

p <- p + theme_light(base_size = 12) + theme(axis.text = element_text(size = 12)) 

p <- p + scale_fill_manual(name="Method", values=cbFill)

#p <- p + ggtitle(sprintf("Tree reconstruction accuracy in Scenario 2: ISM, 40 cells, %d SNVs", j))
p <- p + ggtitle(sprintf("Tree reconstruction accuracy in Simulation 1: target-ISM, %d SNVs, replicates 1-20", j))

p <- p + theme(plot.title=element_text(vjust=2, hjust = 0.5, color="black"))

p <- p + labs(subtitle="Genotype error rate", y = "Phylogenetic accuracy", fill = "Method")

p <- p + scale_y_continuous(sec.axis = dup_axis(name = "ADO rate", breaks=NULL), limits=c(0, 1))

p <- p + guides(fill=guide_legend(nrow=1))

p <- p + theme(legend.position="bottom", 
               legend.background = element_rect(fill="grey90"),
               strip.background=element_rect(fill="lightgray"),
               strip.text.x=element_text(color="black"),
               strip.text.y=element_text(color="black"),
               axis.title.x=element_blank(),
               axis.text.x=element_blank()
               )

p

#fname <- sprintf("sim2j%d_rfdist.pdf", j)
fname <- sprintf("SIM0j%d_rfdist.png", j)

ftitle = sprintf("SIM0 RFdist %d SNVs", j)

ggsave(fname, width=20, height=15, units = "cm", title=ftitle)

