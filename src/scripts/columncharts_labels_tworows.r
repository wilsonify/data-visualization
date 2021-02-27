pdf_file<-"pdf/columncharts_labels_tworows.pdf"
cairo_pdf(bg="grey98", pdf_file,width=7,height=5)

library(plotrix)
library(gdata)

par(mai=c(0.95,0.5,0.0,0.5),omi=c(0,0.5,1.0,0),fg=par("bg"),family="Lato Light",las=1)

# Import data and prepare chart

links<-read.xls("myData/listserv_discussion_traffic.xlsx",sheet=2, encoding="latin1")
attach(links)
sort.links<-links[order(-Number) ,]
myNames<-sort.links$Software
myNumber<-sort.links$Number
py<-c(0,500,1000,1500,2000,2500,3000,3500)
fpy<-format(py,big.mark=",")

# Create chart and other elements

barp(myNumber,cex.axis=0.75,names.arg=myNames,border=NA,col="grey",staxx=T,ylim=c(0,4000),height.at=py,height.lab=fpy)
par(col="black")
staxlab(1,1:length(myNames),myNames,nlines=2,top.line=0.55,font=3,cex=0.75)
abline(h=c(500,1000,1500,2000,2500,3000,3500),col=par("bg"),lwd=3) 

# Titling

mtext("Number of links to homepages of statistical software",3,line=2,adj=0,cex=1.4,family="Lato Black",outer=T)
mtext("Source: r4stats.com/popularity",1,line=3,adj=1.0,cex=0.65,font=3)
dev.off()
