library(ggplot2)
#library(grid)

options(error=traceback)

all <- read.table("sim2.dist.txt")

showmin = FALSE
args = commandArgs(trailingOnly=TRUE)
if (length(args)>0 && args[1] == "min") {
  showmin = TRUE
}

#all <- all[all$V1 != "sifit_remove_i200000",]
all <- all[all$V1 != "GTGTR4+FO",]
all <- all[all$V1 != "GTGTR4+FO+ERR_PT19",]
all <- all[all$V1 != "scite_keep",]
all <- all[all$V1 != "scite_remove",]
all <- all[all$V1 != "scite_missing",]

all <- all[all$V1 != "onem_keep",]
all <- all[all$V1 != "onem_remove",]
all <- all[all$V1 != "tnt_keep",]
all <- all[all$V1 != "tnt_remove",]
all <- all[all$V1 != "iscite_keep",]
all <- all[all$V1 != "iscite_remove",]
all <- all[all$V1 != "sifit_keep_i200000",]
all <- all[all$V1 != "sifit_remove_i200000",]

all <- all[all$V1 != "GTGTR4+FO+E",]

if (showmin == FALSE) {
  all <- all[all$V1 != "iscite_keep_rfmin",]
  all <- all[all$V1 != "iscite_remove_rfmin",]
  all <- all[all$V1 != "iscite_missing_rfmin",]
  all <- all[all$V1 != "tnt_keep_rfmin",]
  all <- all[all$V1 != "tnt_remove_rfmin",]
  all <- all[all$V1 != "tnt_missing_rfmin",]
}

# uncomment to use 20 reps for all methods, to have better comparison with infSCITE
#all <- all[all$V4 <= 20,]

all$acc = 1.0 - all$V6

elvl <- c("0","0.01","0.05","0.1")
elbl <- c("ERR: 0 %", "ERR: 1 %", "ERR: 5 %", "ERR: 10 %")
all$V3 <- factor(all$V3, levels = elvl, labels = elbl)

alvl <- c("0","0.1","0.25","0.5")
albl <- c("ADO: 0 %", "ADO: 10 %", "ADO: 25 %", "ADO: 50 %")
all$V2 <- factor(all$V2, levels = alvl, labels = albl)

mlvl <- c("tnt_keep", "tnt_keep_rfmin", "tnt_remove", "tnt_remove_rfmin", "tnt_missing", "tnt_missing_rfmin", 
	  "iscite_keep", "iscite_keep_rfmin", "iscite_remove", "iscite_remove_rfmin", "iscite_missing", "iscite_missing_rfmin",
	  "sifit_keep_i200000", "sifit_remove_i200000", "sifit_missing_i200000", 
	  "GTGTR4+FO+E", "GPGTR4+FO+ERR_P20")
mlbl <- c("TNT (keep)", "TNT (keep MIN)", "TNT (remove)", "TNT (remove MIN)", "TNT", "TNT (missing MIN)",
	  "infSCITE (keep)", "infSCITE (keep MIN)", "infSCITE (remove)", "infSCITE (remove MIN)", "infSCITE", "infSCITE (missing MIN)",
	  "SiFit (keep) ", "SiFit (remove)",  "SiFit", 
	  "CellPhy-ML10", "CellPhy-ML16")
all$V1 <- factor(all$V1, levels = mlvl, labels = mlbl)

#all <- all[all$V1 %in% mlvl,]

#cbFill <- c('#8dd3c7','#ffffb3','#bebada','#fb8072','#80b1d3','#fdb462','#b3de69','#fccde5','#d9d9d9','#bc80bd', 'white', 'gray')

if (showmin == FALSE) {
#  cbFill <- c('seagreen','limegreen','darkseagreen1','dodgerblue','deepskyblue','lightblue',
#              'gold', 'yellow', 'khaki', 'indianred', 'red')
  cbFill <- c('palegreen','lightblue', 'khaki', 'indianred', 'red', 'darkred')

} else {
  cbFill <- c('seagreen', 'seagreen4', 'limegreen', 'green4', 'darkseagreen1', 'darkseagreen4', 
              'dodgerblue', 'dodgerblue4','deepskyblue', 'deepskyblue4', 'lightblue', 'lightblue4', 
              'gold', 'yellow', 'khaki', 'indianred', 'red')
}

p <- ggplot() 

#p <- p + geom_boxplot(data=all, aes(x = V1, y = V5, fill = V1, weight=3), width = 0.8, position=position_dodge(0.82), outlier.size=1, outlier.color="lightgrey") 

p <- p + geom_boxplot(data=all, aes(x = V1, y = acc, fill = V1), outlier.size=1, outlier.color="lightgrey")

#p <- p + facet_wrap(~V3, ncol=2)

#p <- p + facet_wrap(~V2, ncol=4)

#, labeller = label_wrap_gen(multi_line=FALSE))

p <- p + facet_grid(all$V2~all$V3, scales = "free")

#p <- p + theme_bw()

p <- p + theme_light(base_size = 12) + theme(axis.text = element_text(size = 6)) 

p <- p + scale_fill_manual(name="Method", values=cbFill)

#p <- p + scale_fill_brewer(palette="Pastel2")

#p <- p + ggtitle("Tree reconstruction accuracy in Scenario 3: GTnR, 100 cells, ~2000 SNVs")

p <- p + ggtitle("Tree reconstruction accuracy in Simulation 2: WGS-FSM")

p <- p + theme(plot.title=element_text(vjust=2, hjust = 0.5, color="black"))

p <- p + labs(subtitle = "Genotype error rate", y = "Phylogenetic accuracy", fill = "Method")

#p <- p + guides(fill = guide_legend(nrow = 1))

p <- p + scale_y_continuous(sec.axis = dup_axis(name = "ADO rate", breaks=NULL))

#p <- p + scale_x_continuous(position = "top")

#p <- p + scale_colour_manual(name  ="Method", values = c())

#p <- p + scale_colour_manual(name  ="Error model", values = c("black", "red", "darkorange", "blue"),
#          labels = c("no correction (STD)", "estimated uniform (eUFE)", "true uniform (tUFE)", "true position-specific (tPSE)"))

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

#ggsave("gt_rfdist.pdf", width=23, height=14, units = "cm")

#ggsave("gt_rfdist_err.pdf", width=18, height=24, units = "cm")

#gsave("sim3_rfdist.pdf", width=28, height=23, units = "cm", title="SIM3 RFdist")

if (showmin == FALSE) {
  fname = "SIM2_rfdist.png"
} else {
  fname  = "SIM2_rfdist_min.png"
}

ggsave(fname, width=28, height=23, units = "cm")

