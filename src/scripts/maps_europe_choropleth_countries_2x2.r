pdf_file<-"pdf/maps_europe_choropleth_countries_2x2.pdf"
cairo_pdf(bg="grey98", pdf_file,width=13,height=11)

par(omi=c(0.5,0,0.5,0),mai=c(0,0,0,0))  
par(mfcol=c(2,2),family="Lato Light")
library(maptools)
library(RColorBrewer)
library(sp)
library(rgdal)
library(gdata)

# Import data, prepare and create graphic 

myplotFile<-"scripts/inc_plot_maps_europe_choropleth_countries.r"

mySelection<-"v84"
myClasses<-c(0,1.5,2,2.5,3)
myClass_des<-c("0 to 1.5","1.5 to 2","2 to 2.5","2.5 to 3")
myColourPalette<-brewer.pal(4,"Reds")
source(myplotFile)
mtext("V84: QA1",at=-1300000,adj=0,line=-3)
mtext("LIFE SATISFACTION",at=-1300000,adj=0,line=-4.5)

mySelection<-"v85"
myClasses<-c(0,1.5,2,2.5,3)
myClass_des<-c("0 to 1.5","1.5 to 2","2 to 2.5","2.5 to 3")
myColourPalette<-brewer.pal(4,"Greens")
source(myplotFile)
mtext("V85: QA2 SITUATION:",at=-1300000,adj=0,line=-3)
mtext("AREA YOU LIVE IN",at=-1300000,adj=0,line=-4.5)

mySelection<-"v100"
myClasses<-c(-0.1,0,0.1,0.2,0.3)
myClass_des<-c("-0.1 to 0","0 to 0.1","0.1 to 0.2","0.2 to 0.3")
myColourPalette<-brewer.pal(4,"Blues")
source(myplotFile)
mtext("V100: QA3 EXPECTATIONS:",at=-1300000,adj=0,line=-3)
mtext("AREA YOU LIVE IN",at=-1300000,adj=0,line=-4.5)

mySelection<-"v114"
myClasses<-c(-0.6,-0.4,0,0.2,0.4)
myClass_des<-c("-0.6 to -0.4","-0.4 to 0","0 to 0.2","0.2 to 0.4")
myColourPalette<-brewer.pal(4,"Purples")
source(myplotFile)
mtext("V114: QA4 CHANGE 5 YRS:",at=-1300000,adj=0,line=-3)
mtext("LIFE IN GENERAL",at=-1300000,adj=0,line=-4.5)

# Titling

mtext(side=3,"Life Satisfaction in Europe",adj=0.05,outer=T,line=0.5,cex=2.25,family="Lato Black")
mtext(side=1,"Mean values. V84, V85: Low values are better.V100, V114: High values are better. Source: Eurobarometer 71.2, doi:10.4232/1.10990",adj=0.95,outer=T,line=1,font=3)
dev.off()
