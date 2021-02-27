pdf_file<-"pdf/barcharts_multiple_all.pdf"
cairo_pdf(bg="grey98", pdf_file, width=13,height=10.5)

par(omi=c(0.0,0.75,1.25,0.75),mai=c(1.6,3.75,0.5,0),lheight=1.15,
family="Lato Light",las=1)  

# Import data and prepare chart

source("scripts/inc_labels_za4753.r",encoding="UTF-8")
source("scripts/inc_data_za4753.r",encoding="UTF-8")

myC1<-rgb(0,208,226,maxColorValue=255)
myC2<-rgb(109,221,225,maxColorValue=255)
myC3<-rgb(255,138,238,maxColorValue=255)
myC4<-rgb(255,0,210,maxColorValue=255)
mycolours<-c("grey",myC1,myC2,myC3,myC4)

myData0<-cbind(z[,1]+z[,2],z[,3],z[,4],z[,5],z[,6])
myData1<-t(myData0)

# Create chart

x<-barplot(myData1,names.arg=mynames,cex.names=1.1,horiz=T, border=NA,xlim=c(0,100),col=mycolours,axes=F)

# Other elements

px<-c(2,8,35,68,98); py<-rep(9,5); tx<-c(-2,23,43,65,95); ty<-rep(9,5)
points(px,py,pch=15,cex=4,col=mycolours,xpd=T)
text(tx,ty,myresponses,adj=1,xpd=T,family="Lato Light",font=3)
mtext(c(0,20,40,60,80,100),at=c(0,20,40,60,80,100),1,line=0,cex=0.90)

# Titling 

mtext("It is often said that attitudes towards gender roles are changing",3,line=2.2,adj=0,cex=1.8,outer=T,family="Lato Black")
mtext("All values in percent",1,line=2,adj=1,cex=0.95,font=3)
mtext("Source: European Values Study 2008 Germany, ZA4753. www.gesis.org. Design: Stefan Fichtel, ixtract",1,line=4.5,adj=1,cex=0.95,font=3)
mtext("N=2,075",1,line=2,adj=0,cex=1.15,family="Lato",font=3)
dev.off()
