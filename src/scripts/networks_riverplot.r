pdf_file<-"pdf/networks_riverplot.pdf"

cairo_pdf(bg="white", pdf_file, width=12,height=12)
par(omi=c(1,1.95,1,1.95), mai=c(0,0,0,0), family="Lato Light")

library(riverplot)
library(RColorBrewer)

# Import data and prepare chart

xreg_flow<-read.csv("myData/xreg_flow.csv", stringsAsFactors=F)

edges <- rep(xreg_flow, col.names = c("N1", "N2", "Value"))
edges    <- data.frame(edges, stringsAsFactors=F)
edges$ID <- 1:81

regionen<-c("from Latin America and Caribbean","from Northern America","from Africa","from Europe","from Eastern Europe","from Western Asia","from Southern Asia","from Eastern Asia","from Oceania","to Latin America and Caribbean","to Northern America","to Africa","to Europe","to Eastern Europe","to Western Asia","to Southern Asia","to Eastern Asia","to Oceania")

nodes <- data.frame(ID = regionen, stringsAsFactors=F)

nodes$x <- c(1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2)

edges2 <- edges[ edges$N1 %in% nodes$ID & edges$N2 %in% nodes$ID, ]
edges2$ID <- as.character(edges2$ID)
edges2 <- edges2[nrow(edges2):1,]

nodes2 <- nodes[ match(unique(c(edges2$N1, edges2$N2)), nodes$ID), ]
nodes2$col <- rep(brewer.pal(9, "Blues")[2:9], 2)
sel <- gsub("from ", "", edges2$N1) == gsub("to ", "", edges2$N2)
node_styles <- sapply(edges2$ID[ sel ], function(x) list(horizontal=TRUE), simplify=F)
r <- makeRiver( nodes2, edges2, node_labels = "", node_styles=node_styles)

# Create chart

par(lty=0)
myplot <- riverplot(r, col = nodes2$col, srt=0 , plot_area = 1, fix.pdf=T)

colnames(myplot) <- gsub("and", "\\\nand", colnames(myplot))
oldpar <- par(xpd=NA)
sel <- grep("^from", colnames(myplot))
text(myplot["x",sel] - strwidth("X"), myplot["center", sel], colnames(myplot)[sel], pos=2)
sel <- grep("^to", colnames(myplot))
text(myplot["x",sel] + strwidth("X"), myplot["center", sel], colnames(myplot)[sel], pos=4)

# Titling

mtext("Migration 2010-2015", side=3, outer=T, cex=3, line=1, col="grey30", family="Lato Black")
mtext("All figures in millions. Data Source: https://github.com/cran/migest/tree/master/inst/vidwp",1,line=2, font=3, outer=T)

dev.off()
