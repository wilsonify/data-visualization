pdf_file<-"pdf/timeseries_spans.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=9)

par(omi=c(0.75,0.5,1,0.5),mai=c(0.5,1.25,0.5,0.1),mgp=c(4.5,1,0),family="Lato Light",las=1)    

# Import data and prepare chart

library(gdata)
myData<-read.xls("myData/histat_studies.xlsx", encoding="latin1")
attach(myData)
n<-nrow(myData)
myColour<-rgb(240,24,24,30,maxColorValue=255)

# Define chart and other elements

plot(1:1,type="n",axes=F,xlab="Study start and end",ylab="number",xlim=c(min(from),max(to)),ylim=c(log10(min(number_timeseries)),log10(max(number_timeseries))))
axis(1,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
axis(2,at=c(log10(10),log10(100),log10(1000),log10(10000),log10(50000)),labels=c("10","100","1.000","10.000","50.000"),col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
for (i in 1:n) segments(from[i],log10(number_timeseries)[i],to[i],log10(number_timeseries)[i],col=myColour,lwd=8)

# Titling

mtext("histat time series",3,line=2,adj=0,family="Lato Black",outer=T,cex=2)
mtext("Start, end, and number of time series per study, annual firgures",3,line=0,adj=0,cex=1.35,font=3,outer=T)
mtext("Source: gesis.org/histat",1,line=2,adj=1.0,cex=1.1,font=3,outer=T)
dev.off()
