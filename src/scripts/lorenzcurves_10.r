pdf_file<-"pdf/lorenzcurves_10.pdf"
cairo_pdf(bg="grey98", pdf_file,width=6.5,height=7.25)

par(mai=c(0,0,0,0),omi=c(0.75,0.5,0.85,0.2),pin=c(4,4),family="Lato Light",las=1)
	
# Read data and prepare chart

library(gdata)
myData<-read.xls("myData/income_ten_classes.xlsx",head=T,skip=1,dec=".",encoding="latin1")
attach(myData)
U<-rep(10,10)
U_cum<-c(0,cumsum(U/100))
U2_cum<-c(0,cumsum(U2/100))

# Define chart and other elements 

plot(U_cum,U2_cum,type="n",axes=F,xlab="cumulative percentage of population",ylab="cumulative percentage of income",xlim=c(0,1),ylim=c(0,1))
lines(U_cum,U2_cum,lwd=2)
points(U_cum,U2_cum,pch=19)
x<-array(c(0,1,0,1),dim=c(2,2))
lines(x,lwd=2,col="black")
text(0.08,0.585,"Uniform distribution",adj=c(0,0))
text(0.72,0.265,"Inequality",adj=c(0,0))
arrows(0.4,0.28,0.7,0.28,length=0.10,angle=10,code=1,lwd=2,col="black")
arrows(0.49,0.6,0.6,0.60,length=0.10,angle=10,code=2,lwd=2,col="black")
xx<-c(U_cum,rev(U_cum))
yy<-c(U2_cum,rev(U_cum))
polygon(xx,yy,col=rgb(255,97,0,50,maxColorValue=255),border=F)
source("scripts/inc_axes_with_lines_lorenz.r")

# Titling

mtext("Income Distribution in the USA in 2000",side=3,line=1,cex=1.5,family="Lato Black",adj=0,outer=T)
mtext("(10 classes)",side=3,line=-1.5,cex=1.25,font=3,adj=0,outer=T)
mtext("Source: United Nations University, UNU-WIDER World Income Inequality Database",1,line=1,adj=1,cex=0.85,font=3,outer=T)
dev.off()

