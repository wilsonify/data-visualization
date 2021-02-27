pdf_file<-"pdf/networks_heatmap.pdf"
cairo_pdf(bg="grey98", pdf_file,width=7,height=6)

par(mai=c(0.25,0.25,0.25,1.75),omi=c(0.25,0.25,0.75,0.85),
	family="Lato Light",las=1)

library(pheatmap)
library(RColorBrewer)
library(igraph)

# Import data and prepare chart

df0 <- read.csv("myData/reg_flow.csv", stringsAsFactors=FALSE)
df1 <- read.csv("myData/reg_plot.csv", stringsAsFactors=FALSE)

net <- graph_from_data_frame(d=df0, vertices=df1, directed=T)
netm <- get.adjacency(net, attr="flow", sparse=F)

# Create chart

plot.new()
pheatmap(netm, col=brewer.pal(6,"RdPu"),
	cluster_rows=F,cluster_cols=F,cellwidth=35,cellheight=24,
	border_color="white",fontfamily="Lato Light", display_numbers=T, number_color=matrix(ifelse(netm > 1.5, "white", "red"), nrow(netm)))

# Titling

mtext("Migration 2010-2015",3,line=1.5,adj=0,cex=1.75,family="Lato Black",outer=T)
mtext("All figures in millions. Data Source: https://github.com/cran/migest/tree/master/inst/vidwp",1,line=-1,adj=0,cex=0.85,font=3,outer=T)

par(family="Lato Black")
mtext("↙",1,line=-7,adj=0.9,cex=7,col="grey80",outer=T)

dev.off()
