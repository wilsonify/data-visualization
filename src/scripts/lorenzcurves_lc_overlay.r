pdf_file<-"pdf/lorenzcurves_lc_overlay.pdf"
cairo_pdf(bg="grey98", pdf_file,width=6.5,height=6.5)

par(mai=c(0.25,0,0,0),omi=c(0.4,0.2,0.5,0.2),pin=c(4,4),family="Lato Light",las=1)
library(Hmisc) 
library(ineq)

# Read data and prepare chart

myData<-spss.get("myData/AEQU+.por",use.value.labels=T)
x2008<-subset(myData$EQINCOM1,myData$EQINCOM1 > 0 & myData$V2 == "STUDIEN-NR. 4600")
Lc.Eplus2008<-Lc(x2008)
x1988<-subset(myData$EQINCOM1,myData$EQINCOM1 > 0 & myData$V2 == "STUDIEN-NR. 1670")
x1988<-x1988[1:length(x2008)]
Lc.Eplus1988<-Lc(x1988)
x1<-Lc.Eplus1988$p
y1<-Lc.Eplus1988$L
x2<-Lc.Eplus2008$p
y2<-Lc.Eplus2008$L

# Define chart and other elements 

plot(x1,y1,type="n",axes=F,xlab="cumulative percentage of population",ylab="cumulative percentage of income")
lines(x1,y1)
lines(x2,y2)
xx<-c(x1,rev(x1))
yy1<-c(y1,rev(y2))
yy2<-c(y1,rev(x1))
polygon(xx,yy1,col=rgb(191,239,255,80,maxColorValue=255),border=F)
polygon(xx,yy2,col=rgb(191,239,255,120,maxColorValue=255),border=F)
x<-array(c(0,1,0,1),dim=c(2,2))
lines(x,lwd=2,col="black")
text(0.08,0.585,"Uniform Distribution",adj=c(0,0))
text(0.82,0.29,"1988",adj=c(0,0))
text(0.92,0.435,"2008",adj=c(0,0))
arrows(0.4,0.3,0.8,0.3,length=0.10,angle=10,code=1,lwd=2,col="black")
arrows(0.65,0.45,0.9,0.45,length=0.10,angle=10,code=1,lwd=2,col="black")
arrows(0.49,0.6,0.6,0.6,length=0.10,angle=10,code=2,lwd=2,col="black")
source("scripts/inc_axes_with_lines_lorenz.r")

# Titling

mtext("Lorenz Curve of Income Distribution in 1988 and 2008",side=3,line=0.25,cex=1.45,family="Lato Black",outer=T,adj=0)
mtext("German General Social Survey",3,line=-2,adj=0,outer=T,cex=1.05,font=3)
mtext("Source: GESIS ZA 4600, ZA 1670",1,line=0.6,adj=1,outer=T,cex=0.85,font=3)
dev.off()
