pdf_file<-"pdf/tablecharts_treemap_2a_inc.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11.69,height=7.5)

par(omi=c(0.65,0.25,1.25,0.75),mai=c(0.3,2,0.35,0),family="Lato Light",las=1)  
library(treemap)
library(RColorBrewer)

# Read data and prepare chart

load("myData/hnp.RData")
daten<-subset(daten,daten$gni>0)
attach(daten)
popgni<-pop*gni
daten$popgni<-popgni
kontinente<-aggregate(cbind(pop,popgni) ~ kontinent,data=daten,sum)
kgni<-kontinente$popgni/kontinente$pop
kontinente$kgni<-kgni
kkgni<-cut(kgni,c(0,5000,10000,100000))
levels(kkgni)<-c("low","middle","high")
kontinente$kkgni<-kkgni
kontinente$nkkgni<-as.numeric(kkgni)

# Create chart and other elements

plot(1:1,type="n",axes=F)
treemap(kontinente,title="",index="kontinent", vSize="pop",vColor="kgni",type="value",palette="YlOrBr",aspRatio=2.5,position.legend="none",inflate.labels=T)
legend(0.35,0.6,levels(kkgni)[1:3],cex=1.65,ncol=6,border=F,bty="n",fill= brewer.pal(5,"YlOrBr")[3:5],text.col="black",xpd=NA)

# Titling

mtext("Population and Gross National Income",3,line=2,adj=0,cex=2.4,outer=T,family="Lato Black")
mtext("Size: population - Colour: GNI per capita. Atlas method (current US $), 2010",3,line=0,adj=0,cex=1.75,outer=T,font=3)
mtext("",1,line=1,adj=1.0,cex=1.25,outer=T,font=3)
dev.off()

