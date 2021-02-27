pdf_file<-"pdf/maps_nrw_symbols.pdf"
cairo_pdf(bg="grey98", pdf_file,width=8,height=6.5)

par(mai=c(0.5,0.0,0.0,0.5),omi=c(0,0.5,0.75,0),family="Lato Light") 
library(sp); library(plotrix); library(gdata)

# Import data and prepare chart

akwnrw<-read.xls("myData/akwnrw.xlsx",head=T, encoding="latin1")
myX<-akwnrw$long; myY<-akwnrw$lat
dm<-rep(0.2,length(myX))
myNpp<-function(myX,myY,dm,... ){
floating.pie(myX,myY,c(1,1,1,1,1,1),radius=dm,startpos=45,border=F,col=c("yellow","black","yellow","black","yellow","black"))
points(myX,myY,pch=19,cex=2,col="yellow")
points(myX,myY,pch=19,cex=1,col="black")
}
load("myData/gadm2/DEU_adm1.RData")
myNrw<-gadm[gadm$NAME_1=="Nordrhein-Westfalen",]

# Create chart

plot(myNrw,border="black",axes=F,lwd=0.5)
n<-length(myX)
for (i in 1:n) myNpp(myX[i],myY[i],dm[i])
text(akwnrw$namlong,akwnrw$namlat-0.2,akwnrw$name,xpd=T)

# Titling

mtext("Nuclear Country North Rhine-Westphalia",3,line=1,adj=0,cex=2,family="Lato Black",outer=T)
mtext("important companies of the nuclear industry are located in NRW",3,line=-0.5,adj=0,cex=1.25,font=3,outer=T)
mtext("Source: www.bund-nrw.de",1,line=-1,adj=1.0,cex=0.95,font=3)
dev.off()