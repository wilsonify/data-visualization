pdf_file<-"pdf/maps_germany_cities_piecharts_outline.pdf"
cairo_pdf(bg="grey98", pdf_file,width=13,height=11)
myColour_h<-rgb(240,240,240,maxColorValue=255)

par(omi=c(0.5,0.5,0.5,0),mai=c(0,0,0,0),lend=1,family="Lato Light",las=1)  
library(sp)
library(plotrix)
library(gdata)

# Import data and create chart

myData<-"myData/data_maps_germany_cities_piecharts.xlsx"
myCountries<-read.xls(myData,head=T, encoding="latin1")
attach(myCountries)

load("myData/gadm2/DEU_adm1.RData")
plot(gadm,border=rgb(151,151,151,maxColorValue=255),lwd=0.5)

load("myData/gadm2/DEU_adm0.RData")
plot(gadm,border="black",lwd=0.95,add=T)

# Other elements

n<-nrow(myCountries)
for (i in 1:n) 
{
myCircle<-c(agriculture[i],forest[i],cultivation[i])
floating.pie(long[i],lat[i],myCircle,radius=0.5,col=c(rgb(215,215,0,150,maxColorValue=255),rgb(34,139,34,150,maxColorValue=255),rgb(178,34,34,150,maxColorValue=255)),border=F)
text(long[i],lat[i],name[i])
}
floating.pie(16,48.25,c(1,1,1),radius=0.5,col=c(rgb(215,215,0,150,maxColorValue=255),rgb(34,139,34,150,maxColorValue=255),rgb(178,34,34,150,maxColorValue=255)),border=F)
text(16.75,47.75,"Settlement area")
text(14.7,48.25,"Forest area")
text(16.75,48.75,"Agriculture")

# Titling

mtext("Shares of agricultural, forest and settlement area",3,line=-0.25,adj=0,cex=2.25,outer=T,family="Lato Black")
mtext("Source: Statistisches Bundesamt Fachserie 3 Reihe 5.1",1,line=0,adj=0.9,cex=1.25,font=3)
dev.off()
