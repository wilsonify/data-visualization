pdf_file<-"pdf/timeseries_forecast_interval_1x5_index.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=7)

par(mfcol=c(1,5),omi=c(1.0,0.25,1.45,0.25),mai=c(0,0.75,0.25,0),family="Lato Light",las=1)

# Import data and prepare chart

UNPop<-read.csv("myData/UNPop.csv")

mySelection<-c("World","Northern America","China","Africa","Germany")
ymin<-rep(0, 5)
ymax<-rep(500, 5)
myTitle<-c("World","Northern America","China","Africa","Germany")

for (i in 1:length(mySelection)) {
source("scripts/inc_forecast_interval_05_index.r")
mtext(myTitle[i],side=3,adj=0,line=1,cex=1.1,font=3)

if (i==1)
{
legend(1900,-70,c("Upper prognosis ","Medium prognosis","Lower prognosis"),fill=c("grey","grey","grey"),border=F,pch=15,xpd=NA,col=c("black","white","orange"),bty="n",cex=1.6,ncol=3)
}
}

# Titling

mtext("UN Population Forecasts",3,line=7,adj=0,cex=2.25,family="Lato Black",outer=T)
mtext("2010=100, 5 year values",3,line=3.5,adj=0,cex=1.75,font=3,outer=T)
mtext("Source: UN World Population Prospects: The 2010 Revision",1,line=5,adj=1.0,cex=0.95,font=3,outer=T)
dev.off()
