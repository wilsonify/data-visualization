pdf_file<-"pdf/maps_germany_scatterplot.pdf"
cairo_pdf(bg="grey98", pdf_file,width=8,height=11)

par(mai=c(1.1,0,0,0),omi=c(0.25,0.5,0.75,0.5),family="Lato Light",las=1)

# Import data and prepare chart

source("scripts/inc_datadesign_dbconnect.r")
sql<-"select * from v_women_men"
myDataset<-dbGetQuery(con,sql)
attach(myDataset)

legmaxsize<-max(transbev); legmaxvalue<-max(bevinsg)
legmaxtext<-myDataset[which(myDataset$transbev==legmaxsize),"gemeinde"]
if (length(legmaxtext) > 1) 
{
n<-length(legmaxtext)
for (i in 2:n) legmaxtext<-c(legmaxtext,paste(",",legmaxtext[i,]))
}
legmidsize<-quantile(transbev,0.5); legmidvalue<-quantile(bevinsg,0.5)

# Define chart and other elements

plot(lng,lat,type="n",axes=F,xlab="",ylab="")
low<-subset(myDataset,wm < 0.90)
medium<-subset(myDataset,wm >= 0.90 & wm <= 1.10)
high<-subset(myDataset,wm > 1.10)

c1<-rgb(0,191,255,200,maxColorValue=255)
c2<-rgb(150,150,150,80,maxColorValue=255)
c3<-rgb(128,0,0,200,maxColorValue=255)

attach(low)
points(lng,lat,pch=19,col=c1,cex=transbev)
attach(medium)
points(lng,lat,pch=19,col=c2,cex=transbev)
attach(high)
points(lng,lat,pch=19,col=c3,cex=transbev)

l1<-paste("Max.: ",format(legmaxvalue,digits=2)," Mill. (",legmaxtext,")",sep="")
l2<-paste("Median: ",format(legmidvalue,digits=2)," Mio.",sep="")
legend(6.2,47.1,c(l1,l2),text.col="azure4",title="Point size: Population size",title.adj=0.3,border=F,pch=19,col=rgb(150,150,150,80,maxColorValue=255),bty="n",cex=1.1,pt.cex=c(legmaxsize,legmidsize),xpd=T,ncol=2)
legend(13,50.25,text.col="azure4",c("fewer than 90 women","90 to 110 women","more than 110 women"),title="for 100 men there are",title.adj=0,pt.cex=1,xpd=T,border=F,pch=19,col=c(c1,c2,c3),bty="n",cex=0.8)

# Titling

mtext("Relation of men and women in Germany 2005",line=0,adj=0,cex=1.8,family="Lato Black",outer=T)
mtext("Source: www.destatis.de, opengeodb.giswiki.org, www.lichtblau-it.de",side=1,line=-1,adj=1,cex=0.9,font=3,outer=T)
dev.off()