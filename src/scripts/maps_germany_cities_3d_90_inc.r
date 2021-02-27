pdf_file<-"pdf/maps_germany_cities_3d_90_inc.pdf"
cairo_pdf(bg="grey98", pdf_file,width=13,height=11)

par(omi=c(0.5,0,0.25,0.25),mai=c(0,0,0,0),lend=2,family="Lato Light",las=1)  
library(scatterplot3d)
library(mapdata)

# Import data

dt.map<-map("worldHires","Germany",plot=F)
dt.map2<-map("rivers",plot=F,add=T)
data(world.cities)
Germany<-subset(world.cities,country.etc=="Germany") 
attach(Germany)

# Create chart and other elements

s3d<-scatterplot3d(long, lat, pop^0.42, box=F, axis=F, grid=F, scale.y=2.2, mar=c(0, 1.5, 2, 0), type="n", xlim=c(5, 15), ylim=c(47, 55), zlim=c(0, 2000), angle=90, color="grey", pch=20, cex.symbols=2, col.axis="grey", col.grid="grey")
s3d$points3d(dt.map$x,dt.map$y,rep(0,length(dt.map$x)),col="grey",type="l")
s3d$points3d(dt.map2$x,dt.map2$y,rep(0,length(dt.map2$x)),col=rgb(0,0,255,170,maxColorValue=255),type="l")
s3d$points3d(long, lat, pop^0.42, col=rgb(255, 0, 0, pop^0.36, maxColorValue=255), type="h", lwd=5, pch=" ")

# Titling

mtext("Where we live...",adj=0.0,cex=3.5,line=-5,family="Lato Black",outer=T)
mtext("Source: Richard A. Becker, Allan R. Wilks, worldHires/mapdata, CIA World Data Bank II",1,adj=0.9,cex=1.5,line=0,font=3,outer=T)
dev.off()