pdf_file<-"pdf/timeseries_forecast_interval_1x5.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=7)

par(mfcol=c(1,5),omi=c(1.0,0.25,1.45,0.25),mai=c(0,0.75,0.25,0),family="Lato Light",las=1)

# Import data and prepare chart
	
UNPop<-read.csv("myData/UNPop.csv")
mySelection<-c("World","Northern America","China","Africa","Germany")
ymin<-c(1000,170,500,200,40)
ymax<-c(17000,800,1700,5200,110)
myTitle<-c("World","Northern America","China","Africa","Germany")

# Create charts and other elements 

for (i in 1:length(mySelection)) {
source("scripts/inc_forecast_interval_05.r")
mtext(myTitle[[i]],side=3,adj=0,line=1,cex=1.1,font=3)

if (myTitle[[i]] == "World")
{
legend(1900,-1750,c("Upper prognosis ","Medium prognosis","Lower prognosis"),fill=c("grey","grey","grey"),border=F,xpd=NA,pch=15,col=c("black","white","orange"),bty="n",cex=1.6,ncol=3)
}
}

# Titling

mtext("UN Population Forecasts",3,line=7,adj=0,cex=2.25,family="Lato Black",outer=T)
mtext("values in millions, 5 year values",3,line=3.5,adj=0,cex=1.75,font=3,outer=T)
mtext("Source: UN World Population Prospects: The 2010 Revision",1,line=5,adj=1.0,cex=0.95,font=3,outer=T)
dev.off()
