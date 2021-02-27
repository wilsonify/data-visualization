pdf_file<-"pdf/networks_directed_network.pdf"
cairo_pdf(bg="grey98", pdf_file,width=6,height=6)

par(mai=c(0.25,0.25,0.25,0.5),omi=c(0.25,0.25,0.25,0.25),
	family="Lato Light",las=1)
library(igraph)
library(RColorBrewer)

# Import data and prepare chart

nodes <- read.csv("myData/reg_plot.csv", header=T, as.is=T)
links <- read.csv("myData/reg_flow.csv", header=T, as.is=T)

links <- links[order(links$orig_reg, links$dest_reg),]
colnames(links)[3] <- "weight"
rownames(links) <- NULL

binnen<-links[links$orig_reg==links$dest_reg, ]
nodes$inside<-binnen$weight[match(nodes$region, binnen$orig_reg)]

net <- graph_from_data_frame(d=links, vertices=nodes, directed=T)
net <- simplify(net, remove.multiple = F, remove.loops = T) 

E(net)$width <- E(net)$weight*5
V(net)$size <- sqrt(V(net)$inside*100)

colrs <- brewer.pal(9, "Paired")
V(net)$color <- colrs[V(net)$order1]

edge.start <- ends(net, es=E(net), names=F)[,1] 
edge.col <- V(net)$color[edge.start]

# Create chart

plot(net, edge.arrow.size=0, edge.color=edge.col,layout=layout_in_circle(net),
     vertex.color=colrs, vertex.frame.color="#ffffff", edge.curved=.1,
     vertex.label=V(net)$media, vertex.label.color="black", vertex.label.family="Lato Light") 
 
legend(x=0.8, y=1.25, c("", "   2 M","", "   1 M"), pch=19,xpd=T,title="Internal Migration:",
       col="#777777", pt.cex=c(0, sqrt(4),0,sqrt(2)), cex=.8, bty="n", ncol=1)

legend(x=-1.25, y=-1.15, c(" 3 M"," 2 M", " 1 M"), pch=15,xpd=T,horiz=T,
       col="#777777", pt.cex=c(sqrt(3),sqrt(2),sqrt(1)), cex=.8, bty="n", ncol=1)

# Titling

mtext("Migration 2010-2015", line=-1.5, adj=0, cex=2, family="Lato Black", col="grey40", outer=T)
mtext("Data Source: https://github.com/cran/migest/tree/master/inst/vidwp", side=1, line=-1, adj=1, cex=0.9, font=3, outer=T)
dev.off()
