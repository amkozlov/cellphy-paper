#Load Libraries:
library(igraph)


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

write.table(edges, file=paste("snv_hap.0100.Edges",sep=""), quote=F, col.names=F, row.names=F, sep=",")
write.table(tips, file=paste("snv_hap.0100.Tips",sep=""), quote=F, col.names=F, row.names=F, sep=",")

# Get cells for each clonal population to file:
for (i in 1:length(oncoTree.onco$clones)) {
	listofCells <- rbind(oncoTree.onco$clones[[i]])
		if (length(oncoTree.onco$clones[[i]])>1) {
			cat("(", append=T, file=paste("snv_hap.0100.CellPops.txt",sep=""))
			cat(listofCells,sep=",", append=T, file=paste("snv_hap.0100.CellPops.txt",sep=""))
			cat(")","\n", append=T, file=paste("snv_hap.0100.CellPops.txt",sep=""))
			}
		else	{
			cat(listofCells,"\n", append=T, file=paste("snv_hap.0100.CellPops.txt",sep=""))
			}
	}
