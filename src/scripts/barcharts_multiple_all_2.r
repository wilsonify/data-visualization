pdf_file<-"pdf/barcharts_multiple_all_2.pdf"
cairo_pdf(bg="grey98", pdf_file, width=13,height=10.5)

par(omi=c(0.25,0.75,1,0.75),mai=c(1.8,3.75,0.25,0),lheight=1.15,family="Lato Light",las=1)  
library(RColorBrewer)

# Import data and prepare chart

source("scripts/inc_labels_za4753.r",encoding="UTF-8")
source("scripts/inc_data_za4753.r",encoding="UTF-8")

myC1<-rgb(0,208,226,maxColorValue=255)
myC2<-rgb(109,221,225,maxColorValue=255)
myC3<-rgb(255,138,238,maxColorValue=255)
myC4<-rgb(255,0,210,maxColorValue=255)
colours<-c("grey",myC1,myC2,myC3,myC4)

myData0<-cbind(z[,1]+z[,2],z[,3],z[,4],z[,5],z[,6])
myData1<-t(myData0)

# Create chart

barplot(-rep(100,7),names.arg=mynames,cex.names=1.1,horiz=T, border=par("bg"),xlim=c(-100,70),col=colours[1],axes=F)
barplot(-(100-myData1[1,]),names.arg=mynames,cex.names=1.1,horiz=T, border=par("bg"),xlim=c(-100,70),col=par("bg"),axes=F,add=T)
barplot(-myData1[3:2,],names.arg=mynames,cex.names=1.1,horiz=T, border=NA,xlim=c(-100,70),col=colours[3:2],axes=F,add=T)
barplot(myData1[4:5,],names.arg=mynames,cex.names=1.1,horiz=T, border=NA,xlim=c(-100,70),col=colours[4:5],axes=F,add=T)

# Other elements

arrows(0,-0.1,0,8.6,lwd=2.5,length=0,xpd=T,col="skyblue3") 
px<-c(-98,-87,-41,15,65); tx<-c(-105,-60,-26,8,60); y<-rep(-1,5)
points(px,y,pch=15,cex=4,col=colours,xpd=T)
text(tx,y,myresponses,adj=1,xpd=T,font=3)
mtext(c(80,60,40,20,0,20,40,60),at=c(-80,-60,-40,-20,0,20,40,60),1,line=0,cex=0.95)
	
# Titling

mtext("It is often said that attitudes towards gender roles are changing",3,line=2.2,adj=0,cex=1.8,outer=T,family="Lato Black")
mtext("All values in percent",3,line=1,adj=1,cex=0.95,font=3)
mtext("Source: European Values Study 2008 Germany, ZA4753. www.gesis.org. Design: Stefan Fichtel, ixtract",1,line=5.2,adj=1,cex=0.95,font=3)
mtext("N=2,075",3,line=1,adj=0,cex=1.15,family="Lato",font=3)
dev.off()
