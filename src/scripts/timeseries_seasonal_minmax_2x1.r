pdf_file<-"pdf/timeseries_seasonal_minmax_2x1.pdf"
cairo_pdf(bg="grey98", pdf_file,width=14,height=7)

par(omi=c(0.25,0.25,0.5,0.25),mai=c(0.45,0.35,0.5,0),mfcol=c(1,2),family="Lato Light",las=1)  
library(gplots)
library(gdata)

# Import data and prepare chart

myData<-read.xls("myData/Climate.xlsx", encoding="latin1")
attach(myData)
myLines<-c(-5,0,5,10,15,20,25,30)

# Create chart and other elements

myT1<-barplot2(t(cbind(NY_min,NY_max-NY_min)),col=c(NA,"coral3"),border=NA,names.arg=Month,ylim=c(-5,35),panel.first=abline(h=myLines,col="grey",lwd=1,lty="dotted"),axes=F)
for (i in 1:length(myLines)) {text(-0.8,myLines[i]+1.1,myLines[i],xpd=T)}
text(-0.25,33,"Degrees Celsius",xpd=T,cex=0.8)
mtext(side=3,"New York",cex=1.5,col=rgb(64,64,64,maxColorValue=255))
myT2<-barplot2(t(cbind(MAJ_min,MAJ_max-MAJ_min)),col=c(NA,"cornflowerblue"),border=NA,names.arg=Month,ylim=c(-5,35),panel.first=abline(h=myLines,col="grey",lwd=1,lty="dotted"),axes=F)

# Titling

mtext(side=3,"Majorca",cex=1.5,col=rgb(64,64,64,maxColorValue=255))
mtext(side=3,"Monthly average temperatures",cex=1.5,family="Lato Black",outer=T)
mtext(side=1,"Source: Wikipedia",cex=0.75,adj=1,font=3,outer=T)
dev.off()