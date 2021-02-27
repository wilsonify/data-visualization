pdf_file<-"pdf/timeseries_monthly_monthly_labels_2x1_layout.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=11)

layout(matrix(c(1,2),ncol=1),heights=c(80,20))
par(cex=0.75,bg=rgb(240,240,240,maxColorValue=255),omi=c(0.75,0.25,0.5,0.25),mai=c(0.25,0.75,0.25,0),mgp=c(2,1,0),family="Lato Light",las=1)

#  Read data and prepare chart

library(gdata)
myData<-read.xls("mydata/BBK01.WU3140.xlsx")
attach(myData)

myColour1<-rgb(255,0,0,150,maxColorValue=255)
myColour2<-rgb(0,0,0,150,maxColorValue=255)

monthbegin<-seq(as.Date("1988-01-01"),as.Date("2014-01-01"),by="1 months")
yearbegin<-seq(as.Date("1988-01-01"),as.Date("2014-01-01"),by="1 years")

# Create chart and other elements

plot(type="n",axes=F,xlab="",ylab="Index",as.Date(paste(Monat,"01",sep="-")),Wert)
abline(v=yearbegin,col="lightgrey")
points(as.Date(paste(Monat,"01",sep="-")),Wert,col=myColour1,lwd=5,type="l")
axis(1,col=rgb(60,60,60,maxColorValue=255),at=monthbegin,labels=format(monthbegin,"%b\n%Y"),cex.axis=0.95,lwd.ticks=0.1,tck=-0.005)
axis(2,col=rgb(240,240,240,maxColorValue=255),col.ticks=rgb(60,60,60,maxColorValue=255),lwd.ticks=0.5,cex.axis=0.95,tck=-0.01,pos=as.Date("1988-01-01"))
myRate<-rep(0,nrow(myData))
for (i in 2:nrow(myData)) myRate[i]<-(Wert[i]-Wert[i-1])/Wert[i-1]
plot(type="h",axes=F,xlab="",ylab="Growth rate\nprev. month",as.Date(paste(Monat,"01",sep="-")),myRate,col=myColour2,lwd=3)
axis(1,col=rgb(60,60,60,maxColorValue=255),at=monthbegin,labels=format(monthbegin,"%b\n%Y"),cex.axis=0.95,lwd.ticks=0.1,tck=-0.02)
axis(2,col=rgb(240,240,240,maxColorValue=255),col.ticks=rgb(60,60,60,maxColorValue=255),lwd.ticks=0.5,cex.axis=0.95,tck=-0.025,pos=as.Date("1988-01-01"))

# Titling

mtext("DAX Index 1988-2013",3,line=1,adj=0,cex=1.5,family="Lato Black",outer=T)
mtext("Base: Ultimo 1987=1000, End of month",3,line=-1,adj=0,cex=1.25,font=3,outer=T)
mtext("Source: www.bundesbank.de, BBK01.WU3140",1,line=2,adj=1.0,cex=1.05,font=3,outer=T)
dev.off()