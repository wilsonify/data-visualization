pdf_file<-"pdf/timeseries_columns_progress.pdf"
cairo_pdf(bg="grey98", pdf_file,width=6,height=9)

par(las=1,cex=0.9,omi=c(0.75,0.25,1.25,0.25),mai=c(0.5,0.25,0.5,0.75),family="Lato Light",las=1)

#  Read data and prepare chart

myData<-c(25296,28365,32187,36835,39788,44282,51122,60420,58437,62484)/1000
myLabels<-c(2002:2011)
myColours<-c(rep("olivedrab",length(myData)-1),"darkred")

# Create chart and other elements

barplot(myData,border=NA,col=myColours,names.arg=substr(myLabels,3,4),axes=F,cex.names=0.8)
abline(h=c(10,20,30,40,50,60,70,80),col=par("bg"),lwd=1.5) 
axis(4,at=c(0,20,40,60))
text(11.5,myData[10]+0.025*myData[10],format(round(myData[10]),nsmall=1),adj=0.5,xpd=T,col="darkgrey")

# Titling

mtext("Sales Development Microsoft",3,line=4,adj=0,family="Lato Black",outer=T,cex=2)
mtext("2002–2011, figures in Bill. US-Dollars",3,line=1,adj=0,cex=1.35,font=3,outer=T)
mtext("Source: money.cnn.com",1,line=2,adj=1.0,cex=1.1,font=3,outer=T)
dev.off()
