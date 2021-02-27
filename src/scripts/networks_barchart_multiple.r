pdf_file<-"pdf/networks_barchart_multiple.pdf"
cairo_pdf(bg="grey99", pdf_file,width=10,height=12)

library(igraph)
library(RColorBrewer)

# Import data and prepare chart

df0 <- read.csv("myData/reg_flow.csv", stringsAsFactors=FALSE)
df1 <- read.csv("myData/reg_plot.csv", stringsAsFactors=FALSE)

net <- graph_from_data_frame(d=df0, vertices=df1, directed=T)
netm <- get.adjacency(net, attr="flow", sparse=F)

maxvalue<-max(netm)
n<-nrow(netm)
m<-n
par(mfrow=c(n,m), omi=c(1,4,4,2), mai=c(0,0,0,0), family="Lato Light")

mycolor1<-rgb(255,0,210,maxColorValue=255)
mycolor2<-rgb(0,208,226,maxColorValue=255)

# Create chart

for(i in 1:n)
{
for(j in 1:m)
{
plot(1:1, xlim=c(0,1), ylim=c(0,1), type="n", axes=F)
if(i<j) mycolor<-mycolor1 
if(i==j) mycolor<-"grey80"
if(i>j) mycolor<-mycolor2 

if (i==1) text(0.5,1.2, df1$region[j], cex=2, xpd=NA, adj=0, srt=45, col=mycolor1)
if (j==1) text(-0.1,0.5, df1$region[i], cex=2, xpd=NA, adj=1, col=mycolor2)

rect(0,0,1,1, col="grey95", border=NA)
rect(0,0,1,netm[i,j]/maxvalue, col=mycolor, border=NA)
text(0.5, 0.5, format(round(netm[i,j], 2), nsmall=2), cex=1.5, col="grey40")
}
}

# Titling

mtext("Migration to:", side=3, outer=T, cex=2.5, line=14, col=mycolor1, adj=0)
mtext("Migration from:", side=2, outer=T, cex=2.5, line=25, col=mycolor2, srt=90)
mtext("Migration 2010-2015", side=3, outer=T, cex=3, adj=1, at=0.4, , line=22, col="grey50", family="Lato Black")
mtext("All figures in millions. Data Source: https://github.com/cran/migest/tree/master/inst/vidwp",1,line=2.5, adj=1, at=0.6, font=3, outer=T)

dev.off()
