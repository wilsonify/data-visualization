pdf_file<-"pdf/timeseries_stacked_areas.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=7)

library(plotrix)
library(gdata)
par(mai=c(0.5,1.75,0,0.5),omi=c(0.5,0.5,0.8,0.5),family="Lato Light",las=1)

# Import data and prepare chart

myData<-read.xls("myData/Power_generation_Bavaria.xlsx", encoding="latin1")

myC1<-"brown"
myC2<-"black"
myC3<-"grey"
myC4<-"forestgreen"
myC5<-"blue"
myC6<-"lightgoldenrod"

myYears<-myData$Year
myData$Year<-NULL
Complete<-myData$Complete
myData$Complete<-NULL

fg_org<-par("fg")
par(fg=par("bg"))


# Create chart and other elements

stackpoly(myData,main="",xaxlab=rep("", nrow(myData)),border="white",stack=TRUE,col=c(myC1,myC2,myC3,myC4,myC5,myC6), axis2=F, ylim=c(0,95000))
lines(Complete, lwd=4, col="lightgoldenrod4")
par(fg=fg_org)
mtext(seq(1990,2010,by=5), side=1, at=seq(1,21,by=5), line=0.5)
segments(0.25,0,22.25,0,xpd=T)
ypos<-c(7000,12000,16000,24000,30500,55000)
myDes<-names(myData)
text(rep(0.5,6), ypos, myDes, xpd=T, adj=1)

# Titling

mtext("Gross electricity generation in Bavaria 1990-2011",3,line=1.5,adj=0,family="Lato Black",cex=1.75,outer=T)
mtext("All values in mil. kWh, annual figures",3,line=-0.2,adj=0,font=3,cex=1.25,outer=T)
mtext("Source: www.statistik.bayern.de",1,line=1,adj=1,cex=0.9,font=3,outer=T)
dev.off()
