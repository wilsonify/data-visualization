pdf_file<-"pdf/tablecharts_bumpchart.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=12)

par(omi=c(0.5,0.5,0.9,0.5),mai=c(0,0.75,0.25,0.75),xpd=T,family="Lato Light",las=1)
library(plotrix)
library(gdata)


# Import data and prepare chart

z1<-read.xls("myData/bumpdata.xlsx", encoding="latin1")
rownames(z1)<-z1$name
z1$name<-NULL
myColours<-rep("grey",nrow(z1)); myLineWidth<-rep(1,nrow(z1))
myColours[5]<-"skyblue"; myLineWidth[5]<-8
par(cex=1.1)


# Create chart

bumpchart(z1,rank=F,pch=18,top.labels=c("2002","2011"),col=myColours,lwd=myLineWidth,mar=c(2,12,1,12),cex=1.1)

# Titling

mtext("Revenue development of Fortune 500 enterprises",3,line=1.5,adj=0,family="Lato Black",outer=T,cex=2.1)
mtext("Source: money.cnn.com/magazines/fortune/fortune500/",1,line=0,adj=1,cex=0.95,font=3,outer=T)

# Other elements

axis(2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025, at=c(min(z1$r2002), max(z1$r2002)),c(round(min(z1$r2002)/1000,digits=1), round(max(z1$r2002)/1000, digits=1)))
axis(4,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025, at=c(min(z1$r2011), max(z1$r2011)),c(round(min(z1$r2011)/1000,digits=1), round(max(z1$r2011)/1000, digits=1)))

mtext("in billion Euro",3,font=3,adj=0,cex=1.5,line=-0.5,outer=T)

par(family="Lato Black")
axis(2,col=par("bg"),col.ticks="grey81",col.axis="skyblue",lwd.ticks=0.5,tck=-0.025,at=z1[5,1],round(z1[5,1]/1000, digits=1))
axis(4,col=par("bg"),col.ticks="grey81",col.axis="skyblue",lwd.ticks=0.5,tck=-0.025,at=z1[5,2],round(z1[5,2]/1000, digits=1))

dev.off()
