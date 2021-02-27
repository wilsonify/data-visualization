pdf_file<-"pdf/timeseries_daily_monthly_labels.pdf"
cairo_pdf(bg="grey98", pdf_file,width=14,height=8)

par(omi=c(0.65,0.75,0.95,0.75),mai=c(0.9,0.75,0.25,0),family="Lato Light",las=1)
	
# Import data and prepare chart
  
euro<-read.csv("myData/eurofxref-hist.csv")
euro<-euro[as.Date(euro$Date)>as.Date("2010-08-01"),]
myBeginOfMonth<-seq(as.Date("2010-08-01"),as.Date("2012-08-01"),by="1 months")
myDays<-rev(as.Date(euro$Date))
myValues<-rev(euro$USD)

# Define chart and other elements

plot(myDays,myValues,axes=F,type="n",xlab="",ylab="")
lines(myDays,myValues,col="grey")
myLColour<-rgb(255,97,0,100,maxColorValue=255)
lines(lowess(myDays,myValues,f=1/25),col=myLColour,lwd=5)
par(mgp=c(3,1.5,0))
axis(1,at=myBeginOfMonth,labels=format(myBeginOfMonth,"%b\n%Y"),cex.axis=0.75)
axis(2)
legend("bottomleft","Lowess-filter f=1/25",pch=15,col=myLColour,bty="n",cex=2)

# Titling

mtext("Exchange rate US Dollar/Euro 2010-2012",3,line=0,adj=0,cex=2.5,family="Lato Black",outer=T)
mtext("Daily values",3,line=-2,adj=0,cex=1.75,font=3,outer=T)
mtext("Source: www.ecb.stats/exchange/eurofxref/html/index/html",1,line=4,adj=1.0,cex=1.25,font=3)
dev.off()
