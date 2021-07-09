library(ggplot2)
library(grid)
library(reshape2)
library(plyr)

smartbind <- function(old, new)
{
  if (is.data.frame(old)) {
    rbind(old, new)
  } else {
    new
  }  
}


sim = "all"
args = commandArgs(trailingOnly=TRUE)
if (length(args)>0) {
  sim = args[1]
}

all = NA

if (sim == "sim2" || sim == "all") {
  s2 <- read.csv("../sim2.errx.csv", sep=";")

  s2$sim <- "sim2"

  s2$ds <- "sim2"

  all = smartbind(all, s2)
}

if (sim == "sim3" || sim == "all") {
  s3 <- read.csv("../sim3.errx.csv", sep=";")

  s3$sim <- "sim3"

  all = smartbind(all, s3)
}

if (sim == "sim4" || sim == "all") {
  s4 <- read.csv("../sim4b.errx.csv", sep=";")

  s4$sim <- "sim4"

  s4$ds <- "sim4"

  all <- smartbind(all, s4)
}

if (sim == "sim5" || sim == "all") {
  s5 <- read.csv("../sim5.errx.csv", sep=";")

  s5$sim <- "sim5"

  s5$e <- s5$gterr

  s5$amp <- NULL

  s5$gterr <- NULL

  all <- smartbind(all, s5)
}

if (sim == "sim6" || sim == "all") {
  s6 <- read.csv("../sim6.errx.csv", sep=";")

  s6$sim <- "sim6"

#  s6$e <- s6$e + s6$amp - s6$e * s6$amp

  s6$e <- s6$gterr

  s6$amp <- NULL

  s6$b <- NULL

  s6$gterr <- NULL

  all <- smartbind(all, s6)
}

if (sim == "sim7" || sim == "all") {
  s7 <- read.csv("../sim7.errx.csv", sep=";")

  s7$sim <- "sim7"

  s7$e <- s7$gterr

  s7$amp <- NULL

  s7$b <- NULL

  s7$gterr <- NULL

  s7$t <- NULL

  s7$s <- NULL

  all <- smartbind(all, s7)
}

options(error=traceback)

all$se_err = (all$ex - all$e)^2

all$se_ado = (all$ax - all$a)^2

#all <- all[all$e == 0,]

all$e = all$e*100

#elvl <- c("0","0.01","0.05", "0.0595", "0.0975", "0.1", "0.109", "0.145", "0.2")
#elbl <- c("True: 0 %", "True: 1 %", "True: 5 %", "True: 5.95 %",  "True: 9.75 %", "True: 10 %", "True: 10.9 %", "True: 14.5 %", "True: 20 %")
elvl = seq(0, 50, 1)
elbl = sapply(elvl, function(x) toString(x))
all$ef <- factor(all$e, levels = elvl, labels = elbl)
#all$es = sapply(all$e, function(x) toString(x*100))

#alvl <- c("0.00","0.05","0.10","0.15", "0.25", "0.50")
alvl <- c("0","0.05","0.1","0.15", "0.25", "0.5")
albl <- c("0 %", "5 %", "10 %", "15 %", "25 %", "50 %")
all$a <- factor(all$a, levels = alvl, labels = albl)

mlvl <- c("GTM0+FE+E", "GTHKY4+FE+E", "GTHKY4+FC+E", "GTGTR4+FO+E", "GPGTR4+FO+ERR_P20")
mlbl <- c("JC69+E  ", "K80+E  ", "HKY85+E  ", "GT10+E", "GT16+E")
all$m <- factor(all$m, levels = mlvl, labels = mlbl)

dlvl <- c("sim2", "sim3", "sim4", "sim5_C5", "sim5_C30", "sim5_C100", "sim6_C5", "sim7")
dlbl <- c("SIM1", "SIM2", "SIM3", "SIM4_C5", "SIM4_C30", "SIM4_C100", "SIM5", "SIM6")
all$ds <- factor(all$ds, levels = dlvl, labels = dlbl)

cbFill <- c('#8dd3c7','#ffffb3','#bebada','#fb8072','#80b1d3','#fdb462','#b3de69','#fccde5','#d9d9d9','#bc80bd', 'darkgreen')

p <- ggplot(data = all, aes(x = ef, y = ex * 100)) + geom_boxplot(aes(group=ef), outlier.size=1, outlier.color="lightgrey") 

p <- p + geom_point(aes(y=e), colour = "red", size = 2) 

p <- p + facet_wrap(~ds, ncol=2, scales="free_x")

#p <- p + theme_bw()

p <- p + theme_light(base_size = 14) + theme(axis.text = element_text(size = 8)) 

p <- p + ggtitle("True vs. estimated genotyping error rate")

p <- p + theme(plot.title=element_text(vjust=2, hjust=0.5))

p <- p + labs(x = "\nTrue genotyping error rate (%)", y = "Estimated genotyping error rate (%) \n")

p <- p + scale_y_continuous(sec.axis = sec_axis(~ .))

#p <- p + scale_y_continuous(breaks=c(0, 10, 20, 30, 40, 50, 60, 70))

#p <- p + scale_colour_manual(name  ="Dataset", values = c("black", "red", "blue", "grey90"))

#p <- p + theme(legend.position="none", legend.background = element_rect(fill="grey90"), strip.text.x = element_text(size = 12))

#p <- p + theme(legend.key.size = unit(1.5, "cm"), legend.key.width = unit(2.5, "cm"), legend.margin = unit(0.5, "cm"))

#hline.data <- data.frame(z = c(0, 1, 5, 5.95, 9.75, 10, 10.9, 14.5, 20), e = elbl)

#p <- p + geom_hline(aes(yintercept = z), color='black', linetype = "dashed", hline.data)

#p <- p + scale_colour_manual(name  ="\nModel", values = c("black", "red", "blue", "darkgreen", "orange"))

p <- p + scale_color_manual(name="True error rate", values=cbFill)

p <- p + theme(legend.position="bottom",
               legend.background = element_rect(fill="grey90"),
               strip.background=element_rect(fill="lightgray"),
               strip.text=element_text(color="black"),
#               axis.title.x=element_blank(),
#	       axis.text.x=element_text(angle=90, hjust=1),
#               axis.text.x=element_blank()
               )

p

#ggsave("gt_errx.pdf", width=18, height=23, units = "cm")

ggsave("gt_errx.png", width=20, height=27, units = "cm")

#warnings()

mse = ddply(all, .(ds), summarize, mle_err = mean(se_err), mle_ado = mean(se_ado))

options(digits = 3, scipen = -2)

mse

#as.data.frame(t(mle[,-1]))

