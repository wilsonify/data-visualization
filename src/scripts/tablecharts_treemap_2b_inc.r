pdf_file<-"pdf/tablecharts_treemap_2b_inc.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11.69,height=7.5)

par(omi=c(0.65,0.25,1.25,0.75),mai=c(0.3,2,0.35,0),family="Lato Light",las=1)  
library(treemap)
library(RColorBrewer)

# Daten einlesen und Grafik vorbereiten

load("myData/hnp.RData")
myData<-subset(daten,daten$gni>0)
attach(myData)
kgni<-cut(gni,c(0,40000,80000))
levels(kgni)<-c("low","middle","high")
myData$kgni<-kgni
myData$nkgni<-as.numeric(kgni)

# Grafik definieren und weitere Elemente

plot(1:1,type="n",axes=F)
treemap(myData,title="",index=c("kontinent","iso3"), vSize="pop",vColor="nkgni",type="value",palette="Blues",aspRatio=2.5,fontsize.labels=c(0.1,20),position.legend="none")
legend(0.35,0.6,levels(kgni)[1:3],cex=1.65,ncol=3,border=F,bty="n",fill= brewer.pal(9,"Blues")[7:9],text.col="black",xpd=NA)

# Betitelung

mtext("Within Continent: Country Level",3,line=2,adj=0,cex=2.4,outer=T,family="Lato Black")
mtext("Size: population - Colour: GNI per capita. Atlas method (current US $), 2010",3,line=0,adj=0,cex=1.75,outer=T,font=3)
mtext("Source: data.wordlbank.org",1,line=1,adj=1.0,cex=1.25,outer=T,font=3)
dev.off()