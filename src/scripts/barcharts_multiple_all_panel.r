pdf_file<-"pdf/barcharts_multiple_all_panel.pdf"
cairo_pdf(bg="grey98", pdf_file, width=13,height=10.5)

par(omi=c(1.25,1.25,1.25,0.25),lheight=1.15,family="Lato Light",las=1)  
library(RColorBrewer)

# Import data and prepare chart

source("scripts/inc_labels_za4753.r")
source("scripts/inc_data_za4753.r")
layout(matrix(data=c(1,2,3,4,5),nrow=1,ncol=5), widths=c(2.5,1,1,1,1),heights=c(1,1))
		
myData1<-cbind(z[,1]+z[,2],z[,3],z[,4],z[,5],z[,6])
tmyData<-myData1
DD_pos<-c(45,45,45,45,35)
myC1<-rgb(0,208,226,maxColorValue=255)
myC2<-rgb(109,221,225,maxColorValue=255)
myC3<-rgb(255,138,238,maxColorValue=255)
myC4<-rgb(255,0,210,maxColorValue=255)
colours<-c("grey",myC1,myC2,myC3,myC4)

# Create chart

for (i in 1:5) {
if (i == 1)
{
par(mai=c(0.25,2.75,0.25,0.15))
bp1<-barplot(tmyData[ ,i],horiz=T,cex.names=1.6,names.arg=mynames,
		xlim=c(0,50),col=colours[i],border=NA,axes=F)
} else
{
par(mai=c(0.25,0.1,0.25,0.15))
bp2<-barplot(tmyData[ ,i],horiz=T,axisnames=F,xlim=c(0,50),col=colours[i],border=NA,axes=F)
}

# Other elements
  
rect(0,0,10,8.5,col=rgb(191,239,255,80,maxColorValue=255),border=NA)
rect(10,0,20,8.5,col=rgb(191,239,255,120,maxColorValue=255),border=NA)
rect(20,0,30,8.5,col=rgb(191,239,255,80,maxColorValue=255),border=NA)
rect(30,0,40,8.5,col=rgb(191,239,255,120,maxColorValue=255),border=NA)
rect(40,0,50,8.5,col=rgb(191,239,255,80,maxColorValue=255),border=NA)

mtext(myresponses[i],3,adj=0,line=0,cex=0.95,font=3)
mtext(c(10,20,30,40,50),at=c(10,20,30,40,50),1,line=1,cex=0.85)
mtext(0,at=0,1,line=1,cex=0.90,family="Lato Bold")
arrows(0,-0.1,0,8.6,lwd=2.5,length=0,xpd=T,col="skyblue3") 
}

# Titling

mtext("It is often said that attitudes towards gender roles are changing",3,line=3.5,adj=1,cex=1.8,family="Lato Black",outer=T)
mtext("N=2,075",1,line=3,adj=0.25,cex=1.1,family="Lato",font=4,outer=T)
mtext("All values in percent",1,line=3,adj=1,cex=1.1,font=3,outer=T)
mtext("Source: European Values Study 2008 Germany, ZA4753. www.gesis.org. Design: Stefan Fichtel, ixtract",1,line=5.5,adj=1.0,cex=0.95,outer=T)
dev.off()
