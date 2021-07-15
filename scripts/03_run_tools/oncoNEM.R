#Load Libraries:
library(oncoNEM)
library(igraph)

args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  message("Usage: Rscript oncoNEM.R <matrix> [output_prefix]")
  quit()
} else {
  fmatrix = args[1]
}

fmatrix

if (length(args)==2) {
  oprefix = args[2]
} else {
  oprefix = fmatrix
}

fedges = paste(oprefix, "Edges", sep=".")
ftips = paste(oprefix, "Tips", sep=".")
fcells = paste(oprefix, "CellPops.txt", sep=".")

fcells

#Load datasets:
onco <- as.matrix(read.table(fmatrix, head=T, row.names=1, check.names=F))

#Estimate FPR and FNR from data:
Fpr <- seq(from = 0.15, to = 0.3, length.out = 6)
Fnr <- seq(from = 0.05, to = 0.2, length.out = 6)
llh.onco <- matrix(0,nrow = length(Fpr),ncol = length(Fnr))

for (i.fpr in 1:length(Fpr)) {
	for (i.fnr in 1:length(Fnr)) {
	oNEM.onco <- oncoNEM$new(Data=onco, FPR=Fpr[i.fpr], FNR = Fnr[i.fnr]) 
	oNEM.onco$search(delta = 200)
	llh.onco[i.fpr,i.fnr] <- oNEM.onco$best$llh
	}
}

indx.onco <- which(llh.onco==max(llh.onco), arr.ind=TRUE)
Fpr.est.onco <- Fpr[indx.onco[1]]
Fnr.est.onco <- Fnr[indx.onco[2]]

oNEM.onco  <- oncoNEM$new(Data = onco,
	FPR = Fpr.est.onco,
	FNR = Fnr.est.onco)
oNEM.onco$search(delta = 200)

oNEM.onco.expanded <- expandOncoNEM(oNEM.onco,epsilon = 10,delta = 200,
	checkMax = 10000,app = TRUE)

#Cluster cells into subpopulations:
oncoTree.onco <- clusterOncoNEM(oNEM = oNEM.onco.expanded,
	epsilon = 10)

#After oncoNEM finishes, relabel cells to make sets comparable:
oncoTree.onco$clones <- relabelCells(clones=oncoTree.onco$clones, labels=colnames(onco))

# Get edges from the tree and vertices
edges <- as_edgelist(oncoTree.onco$g)
vs <- V(oncoTree.onco$g)

# Create table to see parents and childs
CP <- matrix(nrow=length(vs), ncol=3)
colnames(CP) <- c("V_ID", "TimesParent", "TimesChild")

for (i in 1:length(vs)) {
CP[i,1] <- vs[i]
CP[i,2] <- length(which(edges[,1]==i))
CP[i,3] <- length(which(edges[,2]==i))
}

# Print Tip and Node IDs, and Edge List to file:
tips <- subset(CP[,1], CP[,2]==0)
nodes <- subset(CP[,1], CP[,2]!=0)

write.table(edges, file=fedges, quote=F, col.names=F, row.names=F, sep=",")
write.table(tips, file=ftips, quote=F, col.names=F, row.names=F, sep=",")

# Get cells for each clonal population to file:
for (i in 1:length(oncoTree.onco$clones)) {
        listofCells <- rbind(oncoTree.onco$clones[[i]])
                if (length(oncoTree.onco$clones[[i]])>1) {
                        cat("(", append=T, file=fcells)
                        cat(listofCells,sep=",", append=T, file=fcells)
                        cat(")","\n", append=T, file=fcells)
                        }
                else    {
                        cat(listofCells,"\n", append=T, file=fcells)
                        }
        }


