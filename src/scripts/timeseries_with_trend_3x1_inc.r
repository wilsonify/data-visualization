pdf_file<-"pdf/timeseries_with_trend_3x1_inc.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=9.5)

par(mfcol=c(3,1),cex.axis=1.4,mgp=c(5,1,0),family="Lato Light",las=1)
par(omi=c(0.5,0.5,1.1,0.5),mai=c(0,2,0,0.5))

# Prepare chart and import data

myColour1_150<-rgb(68,90,111,150,maxColorValue=255) 
myColour1_50<-rgb(68,90,111,50,maxColorValue=255)   
myColour2_150<-rgb(255,97,0,150,maxColorValue=255)  
myColour2_50<-rgb(255,97,0,50,maxColorValue=255)    

library(gdata)
myData<-read.xls("myData/z8053.xlsx", encoding="latin1")
attach(myData)

# Define graphic and other elements

par(mai=c(0,1.0,0.25,0))
plot(year,marriage,axes=F,type="n",xlab="",ylab="number (per 100 thousand)",cex.lab=1.5,xlim=c(1820,1920),ylim=c(700,1000),xpd=T)
axis(2,at=py<-c(700,800,900,1000),labels=format(py,big.mark=","),col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
lines(year,marriage,type="l",col=myColour1_150,lwd=3,xpd=T)
lines(year,marriagetrend,type="l",col=myColour1_50,lwd=10)
text(1910,880,"marriages with trend",cex=1.5,col=myColour1_150)

par(mai=c(0,1.0,0,0))
plot(year,agricultural,axes=F,type="n",xlab="",ylab="index",cex.lab=1.5,xlim=c(1820,1920),ylim=c(40,130))
axis(4,at=c(40,70,100,130),col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
lines(year,agricultural,type="l",col=myColour2_150,lwd=3)
lines(year,agriculturaltrend,type="l",col=myColour2_50,lwd=10)
text(1910,125,"agricultural prices with trend",cex=1.5,col=myColour2_150,xpd=T,) 
text(1913,60,"1913=100",cex=1.5,col=rgb(100,100,100,maxColorValue=255))

arrows(1913,68,1913,90,length=0.10,angle=10,code=0,lwd=2,col=rgb(100,100,100,maxColorValue=255))
points(1913,100,pch=19,col="white",cex=3.5)
points(1913,100,pch=1,col=rgb(25,25,25,200,maxColorValue=255),cex=3.5)
points(1913,100,pch=19,col=rgb(25,25,25,200,maxColorValue=255),cex=2.5)

par(mai=c(0.5,1.0,0,0))
plot(year,marriagez,axes=F,type="n",xlab="",ylab="deviations",cex.lab=1.5,xlim=c(1820,1920),ylim=c(-70,70))
axis(1,at=pretty(year))
axis(2,at=c(-60,-30,0,30,60),col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
rect(1820,-70,1867,70,border=F,col="grey90")
lines(year,marriagez,type="l",col=myColour1_150,lwd=3)
lines(year,agriculturalz,type="l",col=myColour2_150,lwd=3)
text(1910,-40,"marriages",col=myColour1_150,cex=1.5)
text(1910,40,"agricultural prices ",col=myColour2_150,cex=1.5)

# Titling

mtext("Growth Trends and Economic Cycles",3,adj=0.5,line=3,cex=2.1,outer=T,family="Lato Black")
mtext("Annual Figures",3,adj=0.06,line=0,cex=1.75,outer=T,font=3)
dev.off()
