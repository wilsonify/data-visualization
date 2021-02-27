pdf_file<-"pdf/scatterplots_quadrants.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11.69,height=9)

par(mar=c(4,4,0.5,2),omi=c(0.5,0.5,1,0),family="Lato Light",las=1)
library(RColorBrewer)

# Import data and prepare chart

mydata<-read.csv(file="myData/BetterLifeIndex_Data_2011V6.csv",head=F,
	sep=";",dec=",",skip=6)
mydata<-mydata[2:36,]
attach(mydata)

myX<-as.numeric(V16)
myY<-as.numeric(V15)
myX_des<-"Self-reported Health (Scale from 0 to 100)"
myY_des<-"Life Expectancy"

# Define chart and other elements

plot(type="n",xlab=myX_des,ylab=myY_des,myX, myY,xlim=c(30,90),ylim=c(72,83),axes=F)
axis(1,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
axis(2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)

myC1<-brewer.pal(5,"PiYG")[5]
myC2<-brewer.pal(5,"PiYG")[4]
myC3<-brewer.pal(5,"PiYG")[1]
myC4<-brewer.pal(5,"PiYG")[2]

myP1<-subset(mydata[c("V2","V16","V15")],myX > mean(myX) & myY > mean(myY))
myP2<-subset(mydata[c("V2","V16","V15")],myX < mean(myX) & myY > mean(myY))
myP3<-subset(mydata[c("V2","V16","V15")],myX < mean(myX) & myY < mean(myY))
myP4<-subset(mydata[c("V2","V16","V15")],myX > mean(myX) & myY < mean(myY))

myN1<-nrow(myP1)
myN2<-nrow(myP2)
myN3<-nrow(myP3)
myN4<-nrow(myP4)

symbols(myP1[,2:3],bg=myC1,circles=rep(1,myN1),inches=0.3,add=T,xpd=T,fg="white")
symbols(myP2[,2:3],bg=myC2,circles=rep(1,myN2),inches=0.3,add=T,xpd=T,fg="white")
symbols(myP3[,2:3],bg=myC3,circles=rep(1,myN3),inches=0.3,add=T,xpd=T,fg="white")
symbols(myP4[,2:3],bg=myC4,circles=rep(1,myN4),inches=0.3,add=T,xpd=T,fg="white")

text(myP2[,2:3],as.matrix(myP2$V2),cex=0.9,pos=1,offset=1.75)
text(myP4[,2:3],as.matrix(myP4$V2),cex=0.9,pos=1,offset=1.75)

abline(v=mean(myX,na.rm=T),col="black",lty=3)
abline(h=mean(myY,na.rm=T),col="black",lty=3)

text(min(V16),mean(V15)+0.005*mean(V15),"high",family="Lato Black",adj=0)
text(min(V16),mean(V15)-0.005*mean(V15),"low",family="Lato Black",adj=0)
text(mean(V16)-0.001*mean(V16),72,"high",family="Lato Black",pos=4)
text(mean(V16)+0.001*mean(V16),72,"low",family="Lato Black",pos=2)

# Titling

mtext("Life Expectancy and Self-reported Health (OECD)",3,adj=0,line=2.5,cex=2.0,family="Lato Black")
mtext("Self-reported Health (scale from 0-100)",3,adj=0,line=0,cex=1.0,font=3)
mtext("Source: oecdbetterlifeindex.org",1,line=4,adj=1,cex=0.95,font=3)
dev.off()
