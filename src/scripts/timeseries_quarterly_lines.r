pdf_file<-"pdf/timeseries_quarterly_lines.pdf"
cairo_pdf(bg="grey98", pdf_file,width=14,height=7)

par(omi=c(0.65,0.75,0.95,0.75),mai=c(0.9,0,0.25,0.02),fg=rgb(64,64,64,maxColorValue=255),bg="azure2",family="Lato Light",las=1) 
	
# Read data and prepare chart

gdp<-read.xls("myData/GDP_germany_quarter.xlsx",sheet=1)
gdp<-subset(gdp,gdp$year > 2007)
x<-ts(rev(gdp$jeworiginal),start=2008,frequency=4)

# Create chart and other elements

plot(x,type="n",axes=F,xlim=c(2008,2012),ylim=c(560,670),xlab="",ylab="")
abline(v=c(2008:2012),col="white",lty=1,lwd=1)
lines(x,lwd=8,type="b",col=rgb(0,0,139,80,maxColorValue=255))
points(x,pch=19,cex=3,col=rgb(139,0,0,maxColorValue=255))
faktor<-rep(0.985,length(x))
for (i in 1:length(x)) 
{
if (i>1 & i<length(x)) { if (x[i]>x[i-1] & x[i]>x[i+1]) { faktor[i]<-1.015 } }
text((2008+i*0.25)-0.25,faktor[i]*x[i],x[i],col=rgb(64,64,64,maxColorValue=255),cex=1.1)
}
axis(1,at=c(2008:2012),tck=0)
axis(2,col=NA,col.ticks=rgb(24,24,24,maxColorValue=255),lwd.ticks=0.5,cex.axis=1.0,tck=-0.025)

# Titling

mtext("Gross Domestic Product in Germany 2000 - 2011",3,line=2.3,adj=0,cex=2,family="Lato Black",outer=T)
mtext("Original values in current prices, Bill. EUR, quarterly values",3,line=0,adj=0,cex=1.75,font=3,outer=T)
mtext("Source: destatis.de",1,line=1,adj=1,cex=1.25,font=3,outer=T)
dev.off()