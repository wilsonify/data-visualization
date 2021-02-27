pdf_file<-"pdf/barcharts_multiple.pdf"
cairo_pdf(bg="grey98", pdf_file, width=13,height=10.5)

par(omi=c(0.65,0.75,1.25,0.75),mai=c(0.9,3.85,0.55,0),lheight=1.15,family="Lato Light",las=1)  
source("scripts/inc_labels_za4753.r")
library(memisc)

# Read data and prepare chart

ZA4753<-spss.system.file("myData/ZA4753_v1-1-0.sav")
myData<-subset(ZA4753,select=c(v159,v160,v161,v162,v163,v164,v165))
attach(myData)
z<-NULL
y<-table(as.matrix(v165))
z<-c(z,100*(y["1"]+y["2"])/sum(y))
y<-table(as.matrix(v164))
z<-c(z,100*(y["1"]+y["2"])/sum(y))
y<-table(as.matrix(v163))
z<-c(z,100*(y["1"]+y["2"])/sum(y))
y<-table(as.matrix(v162))
z<-c(z,100*(y["1"]+y["2"])/sum(y))
y<-table(as.matrix(v161))
z<-c(z,100*(y["1"]+y["2"])/sum(y))
y<-table(as.matrix(v160))
z<-c(z,100*(y["1"]+y["2"])/sum(y))
y<-c(0,table(as.matrix(v159)))
z<-c(z,100*(y["1"]+y["2"])/sum(y))

# Create chart

bp<-barplot(z,names.arg=F,horiz=T,border=NA,xlim=c(0,100),
	col="grey",axes=F,family="Lato")
myColour<-rgb(255,0,210,maxColorValue=255)
rect(0,-0.1,20,8.6,col=rgb(191,239,255,80,maxColorValue=255),border=NA)
rect(20,-0.1,40,8.6,col=rgb(191,239,255,120,maxColorValue=255),border=NA)
rect(40,-0.1,60,8.6,col=rgb(191,239,255,80,maxColorValue=255),border=NA)
rect(60,-0.1,80,8.6,col=rgb(191,239,255,120,maxColorValue=255),border=NA)
rect(80,-0.1,100,8.6,col=rgb(191,239,255,80,maxColorValue=255),border=NA)
z2<-c(0,0,84.81928,0,0,0,0)
bp<-barplot(z2,names.arg=F,horiz=T,border=NA,xlim=c(0,100),
	col=myColour,axes=F,add=T)

# Other elements 

for (i in 1:length(mynames))
{
if (i == 3) {myFont<-"Lato Bold"} else {myFont<-"Lato Light"}
text(-3,bp[i],mynames[i],xpd=T,adj=1,family=myFont,cex=1)
text(10,bp[i],format(round(z[i],1),nsmall=1),family=myFont,cex=1.25,
	col=ifelse(i==3,"white","black"))
}
arrows(50,-0.1,50,8.8,lwd=1.5,length=0,xpd=T,col="skyblue3") 
arrows(50,-0.25,50,-0.1,lwd=5,length=0,xpd=T)
arrows(50,8.8,50,8.95,lwd=5,length=0,xpd=T)
text(48,8.9,"Majority",adj=1,xpd=T,cex=0.9,font=3)
text(52,8.9,"50%",adj=0,xpd=T,cex=0.9,family="Lato Bold",font=3)
text(100,8.9,"all values in percent",adj=1,xpd=T,cex=0.9,font=3)
mtext(c(0,20,40,60,80,100),at=c(0,20,40,60,80,100),1,line=0.75)

# Titling

mtext("It is often said that attitudes towards gender roles are changing",3,line=2.2,adj=0,cex=1.8,family="Lato Black",outer=T)
mtext("Agree strongly / agree ",3,line=0,adj=0,cex=1.5,outer=T)
mtext("Source: European Values Study 2008 Germany, ZA4753. www.gesis.org. Design: Stefan Fichtel, ixtract",1,line=0,adj=1,cex=0.95,outer=T,font=3)
dev.off()
