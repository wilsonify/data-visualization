pdf_file<-"pdf/scatterplots_outliers.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11.69,height=9)

par(mar=c(4,4,0.5,2),omi=c(0.5,0.5,1,0),family="Lato Light",las=1)

# Import data and prepare chart

library(gdata)
myStructuralData<-read.csv(file="myData/struktbtwkr2005.csv",head=F,sep=";",dec=".")
myData<-subset(myStructuralData,V2 > 0 & V34 > 10)
attach(myData)

myXDes<-"Unemployed population(%)"
myYDes<-"Net migration (per 1,000 Inhabitants)"

# Define chart and other elements

plot(type="n",xlab=myXDes,ylab=myYDes,V34,V21,xlim=c(10,26),ylim=c(-20,35),axes=F,cex.lab=1.2)
axis(1,lwd.ticks=0.5,cex.axis=1.15,tck=-0.015)
axis(2,lwd.ticks=0.5,cex.axis=1.15,tck=-0.015)

myC1<-rgb(0,208,226,200,maxColorValue=255)
myC2<-rgb(255,0,210,150,maxColorValue=255)

fit<-lm(V21 ~ V34)
myData$fit<-fitted(fit)
points(V34,myData$fit,col=myC2,type="l",lwd=8)

myData$resid<-residuals(fit)
myData.sort<-myData[order(-abs(myData$resid)) ,]
myData.sort_begin<-myData.sort[1:5,]

myP1<-myData.sort[5+1:length(myData$fit),c("V34","V21")]
myP2<-myData.sort_begin[c("V34","V21")]

myR1<-sqrt(myData.sort$V6)/10
myR2<-sqrt(myData.sort_begin$V6)/10

symbols(myP1,circles=myR1,inches=0.3,bg=myC1,fg="white",add=T)
symbols(myP2,circles=myR2,inches=0.3,bg=myC2,fg="white",add=T)

text(myP2,iconv(as.matrix(myData.sort_begin["V3"]),"LATIN1","UTF-8"),cex=0.65,pos=3,offset=1.1)

abline(v=mean(V34,na.rm=T),col="black",lty=3)
abline(h=mean(V21,na.rm=T),col="black",lty=3)


text(20,20, "The five largest deviations are highlighted. \n\npoint size: constituency area", adj=0)
# Titling
mtext("Unemployed population, migration in Germany 2005",3,adj=0,line=2,cex=2.5,outer=T,family="Lato Black")
mtext("County level, unemployment rate above 10 percent",3,adj=0,line=0,cex=1.5,outer=T,font=3)
mtext("Source: www.bundeswahlleiter.de",1,line=4,adj=1,cex=1.15,font=3)
dev.off()
