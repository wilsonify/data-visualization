pdf_file<-"pdf/timeseries_seasonal_minmax_overlay.pdf"
cairo_pdf(bg="grey98", pdf_file,width=14,height=7)

par(omi=c(0.25,0,0.75,0.25),mai=c(0.5,2,0.5,2),family="Lato Light",las=1)  

# Import data and prepare chart

library(gdata)
myData<-read.xls("myData/Climate2.xlsx", encoding="latin1")
myLines<-c(-5,0,5,10,15,20,25,30)
attach(myData)

# Create chart and other elements

myT1<-barplot(t(cbind(NY_min,NY_max-NY_min)),col=c("white","coral3"),border=NA,ylim=c(-5,35),axes=F,axisnames=F)
myT2<-barplot(t(cbind(MAJ_min,MAJ_max-MAJ_min)),col=c("white","cornflowerblue"),border=NA,add=T,axes=F,names.arg=Month)
axis(2,at=myLines,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
abline(h=myLines,col="white",lwd=2)
abline(v=seq(2.5,28.8,by=2.4),col="grey")
text(-0.95,34,"Degrees Celsius",xpd=T,cex=0.8)
legend(34,25,c("New York","Majorca"),col=c("coral3","cornflowerblue"),pch=15,bty="n",xjust=1,cex=1.5,pt.cex=1.5,xpd=T)

# Titling

mtext(side=3,"Monthly average temperatures",cex=2.25,adj=0.1,family="Lato Black",outer=T)
mtext(side=1,line=-1,"Source: Wikipedia",cex=1.25,adj=1,font=3,outer=T)
dev.off()
