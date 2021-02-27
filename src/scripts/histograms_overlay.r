pdf_file<-"pdf/histograms_overlay.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=7)

source("scripts/inc_datadesign_dbconnect.r")
par(omi=c(0.75,0.2,0.75,0.2),mai=c(0.25,1.25,0.25,0.25),family="Lato Light",las=1)

# Import data and prepare chart

sql<-"select * from v_women_men"
myDataset<-dbGetQuery(con,sql)
attach(myDataset)
myCol1<-rgb(191,239,255,180,maxColorValue=255)
myCol2<-rgb(255,0,210,80,maxColorValue=255)
brandenburg<-subset(myDataset,bundesland == 'Brandenburg')

# Create chart

hist(brandenburg$wm,col=myCol1,xlim=c(0.9,1.2),border=F,main='',xlab="Ratio",ylab="Number of Counties",axes=F)
axis(1,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
axis(2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
rp<-subset(myDataset,bundesland == 'Rheinland-Pfalz')
hist(rp$wm,col=myCol2,xlim=c(0.9,1.2),border=F,add=T,main='')
legend("right",c("Brandenburg","Rhineland-Palatinate"),border=F,pch=15,col=c(myCol1,myCol2),bty="n",cex=1.25,xpd=T,ncol=1)

# Titling

mtext("Distribution of Women-Men-Ratio",3,line=1.8,adj=0,family="Lato Black",cex=1.5,outer=T)
mtext("Brandenburg and Rhineland-Palatinate",3,line=-0.2,adj=0,font=3,cex=1.2,outer=T)
mtext("Source: Bundeswahlleiter",1,line=2,adj=1.0,font=3,cex=1.2,outer=T)
dev.off()
