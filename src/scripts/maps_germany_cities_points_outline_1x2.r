pdf_file<-"pdf/maps_germany_cities_points_outline_1x2.pdf"
cairo_pdf(bg="lavender", pdf_file,width=12,height=6)

par(mai=c(0,0,0,0), omi=c(0.15,0.25,0.55,0.25),mfcol=c(1,2),family="Lato Light",las=1)
library(sp); library(RColorBrewer); library(geoR)
source("scripts/inc_datadesign_dbconnect.r")

# Import data and prepare chart

sql<-"select substr(sighting,7,4) year, lng, lat, identification from v_ufos where substr(sighting,7,4) in (2006, 2012)"
myDataset<-dbGetQuery(con,sql)
myDataset$myYear<-as.numeric(myDataset$year)
attach(myDataset)

myYear1<-2006; myYear2<-2012

myYear1id<-subset(myDataset,myYear == myYear1 & identification != "-")
myYear1ui<-subset(myDataset,myYear == myYear1 & identification == "-")

myYear2id<-subset(myDataset,myYear == myYear2 & identification != "-")
myYear2ui<-subset(myDataset,myYear == myYear2 & identification == "-")

myData<-c(myYear1ui,myYear2ui,myYear1id,myYear2id)
load("myData/gadm2/DEU_adm1.RData")
myColour<-"linen"
myColour_uid<-rgb(128,0,0,200,maxColorValue=255)
myColour_id<-rgb(0,153,0,120,maxColorValue=255)

# Create chart and other elements

plot(gadm,border="white",col=myColour)
par(family="Quivira")
text(jitterDupCoords(cbind(myYear1ui$lng,myYear1ui$lat),max=0.01),"👽",col=myColour_uid,cex=2.3)
points(jitterDupCoords(cbind(myYear1id$lng,myYear1id$lat),max=0.01),pch=15,col=myColour_id,cex=1.6)

mtext("👽", side=1, line=-3, col=myColour_uid, cex=1.5, adj=0)
mtext("◼", side=1, line=-1.9, col=myColour_id, cex=1.15, adj=0)
par(family="Lato Light")
mtext("not identified", side=1, line=-3, cex=1.1, adj=0.05)
mtext("identified", side=1, line=-2, cex=1.1, adj=0.05)

text(5,53,myYear1,cex=2.7,col="azure4")

plot(gadm,border="white",col=myColour)
par(family="Quivira")
text(jitterDupCoords(cbind(myYear2ui$lng,myYear2ui$lat),max=0.01),"👽",col=myColour_uid,cex=2.3)
par(family="Lato Light")
points(jitterDupCoords(cbind(myYear2id$lng,myYear2id$lat),max=0.01),pch=15,col=myColour_id,cex=1.6)
text(5,53,myYear2,cex=2.7,col="azure4")

# Titling

mtext("UFO Sightings in Germany",line=0,adj=0,cex=2.2,family="Lato Black",outer=T)
mtext("Source: www.ufo-datenbank.de.",side=1,line=-1,adj=1,cex=0.9,font=3,outer=T)
dev.off()
