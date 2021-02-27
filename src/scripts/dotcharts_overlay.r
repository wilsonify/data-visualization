pdf_file<-"pdf/dotcharts_overlay.pdf"
cairo_pdf(bg="grey98", pdf_file,width=7,height=10)

library(Hmisc) # because of dotchart2, only there add=T can be used
par(omi=c(0.15,0.75,0.95,0.75),mai=c(0.9,1.75,0.25,0),family="Lato Light",las=1)  

# Import data and prepare chart

myData<-read.xls("myData/Bechert_Graph.xlsx",sheet=1, encoding="latin1")
row.names(myData)<- myData$Countries
myData$Countries<-NULL

total<- myData["Mean . . . . . . . . . . ",]
myData<- myData[rownames(myData)!="Mean . . . . . . . . . . ",] 

myDatasort <- myData [order(-myData$Happiness),]
myDatasort <-rbind(myDatasort,total)
attach(myDatasort)

myC1<-rgb(255,165,0,190,maxColorValue=255)
myC2<-rgb(0,0,139,190,maxColorValue=255)
myC3<-rgb(100,0,0,190,maxColorValue=255)

myC1g<-rgb(255,165,0,60,maxColorValue=255)
myC2g<-rgb(0,0,139,60,maxColorValue=255)
myC3g<-rgb(100,0,0,60,maxColorValue=255)

# Create chart and other elements

dotchart2(Religiosity.,labels=row.names(myDatasort),pch=17,dotsize=4,cex=0.6,cex.labels=0.75,xlab="",col=myC1,xaxis=F,xlim=c(1,100))
dotchart2(Involvement,labels=row.names(myDatasort),pch=15,dotsize=4,cex=0.6,xlab="",col=myC2,xaxis=F,add=T)
dotchart2(Happiness,labels=row.names(myDatasort),pch=19,dotsize=4,cex=0.6,xlab="",col=myC3,xaxis=F,add=T)

axis(1)
axis(3)	

abline(v=total,col=c(myC1g,myC2g,myC3g),lwd=12)
legend(-5,-2.6,c("Religious Involvement"),ncol=1,pch=15,col=myC2,bty="n",cex=1.5,pt.cex=1.5,xpd=T)
legend(35,-2.6,c("Self-assessed Religiosity"),ncol=1,pch=17,col=myC1,bty="n",cex=1.5,pt.cex=1.5,xpd=T)

legend(80,-2.6,c("Happiness"),ncol=1,pch=19,col=myC3,bty="n",cex=1.5,pt.cex=1.5,xpd=T)


# Titling

mtext("Religious Involvement, Self-assessed Religiosity, and Happiness ",3,line=3.75,adj=0,cex=1.05,family="Lato Black",outer=T)
mtext("(Mean values scaled from 0 to 100, Data from 2008)",3,line=1.25,adj=0,cex=0.90,font=3,outer=T)
mtext("Source: ISSP Data Report Religious Attitudes and Religious Change",1,line=-1,adj=1,cex=0.90,font=3,outer=T)

dev.off()

