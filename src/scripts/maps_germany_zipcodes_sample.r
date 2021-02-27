pdf_file<-"pdf/maps_germany_zipcodes_sample.pdf"
cairo_pdf(bg="grey98", pdf_file,width=10,height=10)

par(bg="darkolivegreen1",mai=c(0,0,0,0),oma=c(1,1.5,1,1),family="Lato Light",las=1)
library(maptools)
library(rgdal)

# Import data and prepare chart

myY<-readShapeSpatial("myData/PLZ/post_pl.shp",proj4string=CRS("+proj=longlat"))
myX<-spTransform(myY,CRS=CRS("+proj=merc"))
myY<-subset(myX,substr(myX$PLZ99,1,3)=="539")

# Create chart

plot(myY,col="darkblue",border="white",lwd=3)
text(getSpPPolygonsLabptSlots(myY),labels=myY$PLZ99,cex=1.5,col="white",family="Lato Bold")

# Titling

mtext("Zip Code border, districts 539..",side=3,line=-4,adj=0,cex=2.7,family="Lato Black")
mtext("Source: arnulf.us/PLZ",side=1,line=-1,adj=1,cex=1.3)
dev.off()