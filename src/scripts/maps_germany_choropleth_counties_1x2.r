pdf_file<-"pdf/maps_germany_choropleth_counties_1x2.pdf"
cairo_pdf(bg="grey98", pdf_file,width=15,height=8)

par(omi=c(0.5,0,0,0), mai=c(0,6,1,1),family="Lato Light",las=1)
library(maptools)
library(RColorBrewer)
library(gdata)

myC0<-rgb(0,0,0,0,maxColorValue=255)
myC1a<-rgb(68,90,111,50,maxColorValue=255)
myC1b<-rgb(68,90,111,150,maxColorValue=255)
myC1c<-rgb(68,90,111,250,maxColorValue=255)
myC2a<-rgb(255,97,0,50,maxColorValue=255)
myC2b<-rgb(255,97,0,150,maxColorValue=255)
myC2c<-rgb(255,97,0,250,maxColorValue=255)

# first the right map

x<-readShapeSpatial("myData/VG250_Kreise_Shapefile_UTM32_VZ_2011.shp")
myDistrict_structure_data<-read.xls("myData/konfession_vz_2011.xls",sheet=1, encoding="latin1")
n<-length(x)
myNo<-as.numeric(as.character(x$RS))
position<-vector()
for (i in 1:n){
	position[i]<-match(myNo[i], myDistrict_structure_data$AGS)
}
myColour_no<-cut(100*myDistrict_structure_data$RKAT[position]/ myDistrict_structure_data$BEV[position],c(0,50,70,90,100))
myColourPalette<-c(myC0,myC1a,myC1b,myC1c)
plot(x,col=myColourPalette[myColour_no],border=grey(.8),lwd=.3)

myColour_no<-cut(100*myDistrict_structure_data$EVANG[position]/ myDistrict_structure_data$BEV[position],c(0,50,70,90,100))
myColourPalette<-c(myC0,myC2a,myC2b,myC2c)
plot(x,col=myColourPalette[myColour_no],border=grey(.8),lwd=.3,add=T)

# then the left map

par(mai=c(0,0,0,7),plt=c(0,0.5,0,0.95),new=T)
x<-readShapeSpatial("myData/OGP86/SDE2_GERMAN1895ELECTORALDISTRICTS.shp")
myDistrict_structure_data<-read.xls("myData/ZA8145_1912.xlsx",sheet=1, encoding="latin1")
n<-length(x)
myNo<-x$DISTRICT_N
position<-vector()
for (i in 1:n){
	position[i]<-match(myNo[i], myDistrict_structure_data$wkr_nr)
}
myColour_no<-cut(myDistrict_structure_data$kat05p[position],c(0,50,70,90,100))
myColourPalette<-c(myC0,myC1a,myC1b,myC1c)
plot(x,col=myColourPalette[myColour_no],border=grey(.8),lwd=.3,xpd=T)

myColour_no<-cut(myDistrict_structure_data$ev05p[position], c(0,50,70,90,100))
myColourPalette<-c(myC0,myC2a,myC2b,myC2c)
plot(x,col=myColourPalette[myColour_no],border=grey(.8),lwd=.3,add=T,xpd=T)

# Titling

mtext("Protestant and Catholic counties 1905... ",3,line=-2.75,adj=0.05,family="Lato Black",outer=T,cex=2,xpd=T)
mtext("... and 2011",3,line=-2.75,adj=0.65,family="Lato Black",outer=T,cex=2,xpd=T)
mtext("map 1905: geodata.tutfts.edu (goo.gl/Lq3QU); data 1905: Schmädeke (GESIS: doi:10.4232/1.1845);map 2011: www.zensus2011.de; data 2011: destatis.de",1,line=-0.7,adj=0.04,cex=0.95,font=3,outer=T,xpd=T)

# Lastly, the bar charts as legend 

par(mai=c(0.75,5,5.5,9),fg="white",new=T)
myDistrict_structure_data<-read.xls("myData/ZA8145_1912.xlsx",sheet=1, encoding="latin1")

protestant<-myDistrict_structure_data[myDistrict_structure_data$ev05p>50,]
attach(protestant)
myClasses<-c(50,70,90,100)
levels(myClasses)<-c("50 to 70 %","70 to 90 %","over 90  %")
barplot(table(cut(ev05p,myClasses)),col=myColourPalette<-c(myC2a,myC2b,myC2c),xlim=c(-150,150),names.arg=levels(myClasses),main="",cex.axis=0.75,cex.names=0.75,cex.main=0.75,col.axis="black",col.main="red",horiz=T)
text(130,4.5,"Protestant",pos=1,col="black",xpd=T,cex=1)

catholic<-myDistrict_structure_data[myDistrict_structure_data$kat05p>50,]
attach(catholic)
myClasses<-c(50,70,90,100)
levels(myClasses)<-c("50 to 70 %","70 to 90 %","over 90  %")
barplot(-table(cut(kat05p,myClasses)),col=myColourPalette<-c(myC1a,myC1b,myC1c),names.arg=levels(myClasses),main="",cex.axis=0.75,cex.names=0.75,cex.main=0.75,col.axis="black",col.main="red",horiz=T,add=T)
text(-120,4.5,"Catholic",pos=1,col="black",xpd=T,cex=1)

par(mai=c(0.75,13,5.5,1),fg="white",new=T)
myDistrict_structure_data<-read.xls("myData/konfession_vz_2011.xlsx",sheet=1)

protestant<-myDistrict_structure_data[myDistrict_structure_data$PEVANG>50,]
attach(protestant)
myClasses<-c(50,70,90,100)
levels(myClasses)<-c("50 to 70 %","70 to 90 %","over 90  %")
barplot(table(cut(PEVANG,myClasses)),col=myColourPalette<-c(myC2a,myC2b,myC2c),xlim=c(-150,150),names.arg=levels(myClasses),main="",cex.axis=0.75,cex.names=0.75,cex.main=0.75,col.axis="black",col.main="red",horiz=T)
text(130,4.5,"Protestant",pos=1,col="black",xpd=T,cex=1)

catholic<-myDistrict_structure_data[myDistrict_structure_data$PRKAT>50,]
attach(catholic)
myClasses<-c(50,70,90,100)
levels(myClasses)<-c("50 to 70 %","70 to 90 %","over 90  %")
barplot(-table(cut(PRKAT,myClasses)),col=myColourPalette<-c(myC1a,myC1b,myC1c),names.arg=levels(myClasses),main="",cex.axis=0.75,cex.names=0.75,cex.main=0.75,col.axis="black",col.main="red",horiz=T,add=T)
text(-120,4.5,"Catholic",pos=1,col="black",xpd=T,cex=1)
dev.off()