pdf_file<-"pdf/maps_tunisia_symbols.pdf"
cairo_pdf(bg="grey98", pdf_file,width=10,height=10)

par(bg="lightskyblue1",mai=c(0,0,0,0),oma=c(0,0,0,0),family="Lato Light",las=1)
library(maptools)
library(rgdal)
library(gdata)

# Import data and prepare chart

myTun<-readShapeSpatial("myData/TUN_adm/TUN_adm0.shp",proj4string=CRS("+proj=longlat"))
plot(myTun,col="mintcream",border="white",lwd=3, xlim=c(8,14), ylim=c(32,38))
myDza<-readShapeSpatial("myData/DZA_adm/DZA_adm0.shp",proj4string=CRS("+proj=longlat"))
plot(myDza,col="burlywood1",border="white",lwd=3, add=T)
myLby<-readShapeSpatial("myData/LBY_adm/LBY_adm0.shp",proj4string=CRS("+proj=longlat"))

# Create chart and other elements

plot(myLby,col="burlywood1",border="white",lwd=3, add=T)

myLocations<-read.xls("myData/tunisia.xlsx", encoding="latin1")
attach(myLocations)
n<-nrow(myLocations)
for (i in 1:n)
{
text(long[i]+hoffset[i], lat[i]+voffset[i], place[i], cex=1.75,col="black", adj=adjust[i])
}
text(10.12, 36.43, "Tunis", cex=3, family="Lato Black")
text(12.5, 33.5, "Mediterranean", adj=0, cex=2, family="Lato Regular", col="darkblue")
text(7.25, 32, "ALGERIA", adj=0, cex=2, family="Lato Black")
text(9,33, "TUNISIA", adj=0, cex=2, family="Lato Black")
text(12, 32, "LIBYA", adj=0, cex=2, family="Lato Black")

par(family="Datendesign")
text(long, lat, "a", cex=size, col="red")

# Titling

mtext("Unrest in Tunisia",side=3,line=-4,adj=0.05,cex=2.7,family="Lato Black",col="black")

# Separate figure 

par(mai=c(6,6,0,0), bg="white",new=T)
data(wrld_simpl) 
w <- wrld_simpl[wrld_simpl@data[, "NAME"] != "Antarctica",]
m <- spTransform(w, CRS=CRS("+proj=merc"))
plot(m,xlim=c(-900000,2800000),ylim=c(3300000,7000000),col=rgb(160,160,160,100,maxColorValue=255),border=F)
w <- wrld_simpl[wrld_simpl@data[, "NAME"] == "Tunisia",]
m <- spTransform(w, CRS=CRS("+proj=merc"))
plot(m, add=T,col="red",border=F)
dev.off()
