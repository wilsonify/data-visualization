pdf_file<-"pdf/maps_world_great_circles.pdf"
cairo_pdf(bg="grey98", pdf_file,width=13.75,height=8)

par(omi=c(0.5,0.5,1.25,0.5),mai=c(0,0,0,0),lend=1,bg="antiquewhite",family="Lato Light") 
library(mapdata) 
library(geosphere)
library(gdata)
# library(mapproj)

# Import data and prepare chart

myProj.type<-"mercator"
myProj.orient<-c(90,0,30)
x<-map(proj=myProj.type,orient=myProj.orient,wrap=T) 

# Create chart and other elements

plot(x,xlim=c(-3,3),ylim=c(-1,2),type="n",axes=F,xaxs="i",yaxs="i")
rect(-3,-1,3,3,col="aliceblue",border=NA)
map("worldHires","Germany",fill=T,add=T,col="antiquewhite",proj=myProj.type,orient=myProj.orient)
lines(x,col="darkgrey")
data(world.cities)
myData<-read.xls("myData/orthodat.xlsx", encoding="latin1")
attach(myData)
 
myTColour<-rgb(128,128,128,100,maxColorValue=255)
for (i in 1:nrow(myData))
{
myStart<-world.cities[11769,] # Frankfurt
myDestination<-subset(world.cities,name==stadt[i] & country.etc==land[i])
myGC1<-gcIntermediate(c(myStart$long,myStart$lat),c(myDestination$long,myDestination$lat),addStartEnd=T, n=50)
merc<-mapproject(myGC1[,1],myGC1[,2],projection=myProj.type,orientation=myProj.orient) 
lines(merc$x,merc$y,lwd=10,col=myTColour)
 
myDestP<-mapproject(myDestination$long,myDestination$lat,proj=myProj.type,orient=myProj.orient)
points(myDestP,col="darkred",pch=19,cex=2)
}
myStartP<-mapproject(myStart$long,myStart$lat,proj=myProj.type,orient=myProj.orient)
points(myStartP,col="darkblue",pch=19,cex=2)

# Titling

mtext("Destination Airports of Airbus A380 (Lufthansa)",3,line=3,adj=0,cex=3,family="Lato Black",outer=T)
mtext("As of: August 2013",3,line=1,adj=0,cex=1.75,font=3,outer=T)
mtext("Source: de.wikipedia.org/wiki/Lufthansa",1,line=0.8,adj=1.0,cex=1.25,font=3)
dev.off()