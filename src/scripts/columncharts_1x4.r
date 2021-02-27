pdf_file<-"pdf/columncharts_1x4.pdf"
cairo_pdf(bg="grey98", pdf_file,width=12,height=6)

library(RColorBrewer)
par(mfrow=c(2,4),omi=c(0.5,0.5,0.75,0.5),mai=c(0.5,0.5,0.5,0.5),cex=1.1,family="Lato Light",las=1)
	
# Import data

source("scripts/inc_datadesign_dbconnect.r")
sql<-"select * from v_za4972_laender"
myDataset<-dbGetQuery(con,sql)
attach(myDataset)

# Create chart

myCuts<-c(0,1.5,2,2.5,3)
barplot(table(cut(v84,myCuts)),col=brewer.pal(4,"Reds"), ylim=c(0,20), names.arg=table(cut(v84,myCuts)),axes=F,main="Life Satisfaction")
myCuts<-c(0,1.5,2,2.5,3)
barplot(table(cut(v85,myCuts)),col=brewer.pal(4,"Greens"), ylim=c(0,20),names.arg=table(cut(v85,myCuts)),axes=F,main="Situation:\nArea you live in")
myCuts<-c(-0.1,0,0.1,0.2,0.3)
barplot(table(cut(v100,myCuts)),col=brewer.pal(4,"Blues"), ylim=c(0,20),names.arg=table(cut(v100,myCuts)),axes=F,main="Expectations:\nArea you live in")
myCuts<-c(-0.6,-0.4,0,0.2,0.4)
barplot(table(cut(v114,myCuts)),col=brewer.pal(4,"Purples"), ylim=c(0,20),names.arg=table(cut(v114,myCuts)),axes=F,main="Change 5 years:\nLife in general")
par(family="Lato", cex=0.7)
plot.new()
bez<-c("0.0 to 1.5","1.5 to 2.0","2.0 to 2.5","2.5 to 3.0")
legend("center",bez,cex=2.05,border=F,bty="n",fill= brewer.pal(4,"Reds"),y.intersp=1.3)
plot.new()
bez<-c("0.0 to 1.5","1.5 to 2.0","2.0 to 2.5","2.5 to 3.0")
legend("center",bez,cex=2.05,border=F,bty="n",fill= brewer.pal(4,"Greens"),y.intersp=1.3)
plot.new()
bez<-c("−0.1 to ±0.0","±0.0 to +0.1","+0.1 to +0.2","+0.2 to +0.3")
legend("center",bez,cex=2.05,border=F,bty="n",fill= brewer.pal(4,"Blues"),y.intersp=1.3)
plot.new()
bez<-c("−0.6 to −0.4","−0.4 to ±0.0","±0.0 to +0.2","+0.2 to +0.4")
legend("center",bez,cex=2.05,border=F,bty="n",fill= brewer.pal(4,"Purples"),y.intersp=1.3)

# Titling

mtext("Eurobarometer 71.2: Number of countries",3,line=1,adj=0,cex=2.15,family="Lato Black",outer=T)
mtext("mean values of responsive categories",1,line=1,adj=0,cex=1.25,font=3,outer=T)
mtext("Source: Eurobarometer 71.2",1,line=1,adj=1.0,cex=1.25,font=3,outer=T)
dev.off()