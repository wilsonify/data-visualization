pdf_file<-"pdf/maps_world_gapminder_regions.pdf"
cairo_pdf(bg="grey98", pdf_file,width=8.4,height=6)

par(omi=c(0,0,0,0),mai=c(0,0.82,0.82,0),family="Lato Light",las=1)

library(maptools) # contains wrld_simpl
library(rgdal) # for spTransform
library(gdata)

# Import data and prepare chart

data(wrld_simpl) 
w<-wrld_simpl[wrld_simpl@data[,"NAME"] != "Antarctica",] 
m<-spTransform(w,CRS=CRS("+proj=merc"))

myCountries<-m@data$ISO2
n<-length(myCountries) 
myMapColours<-numeric(n) 

myR1<-"Sub-Saharan Africa"
myR2<-"South Asia"
myR3<-"Middle East & North Africa"
myR4<-"America"
myR5<-"Europe & Central Asia"
myR6<-"East Asia & Pacific"

myC1<-rgb(0,115,157,150,maxColorValue=255)
myC2<-rgb(158,202,229,150,maxColorValue=255)
myC3<-rgb(84,196,153,150,maxColorValue=255)
myC4<-rgb(255,255,0,150,maxColorValue=255)
myC5<-rgb(246,161,82,150,maxColorValue=255)
myC6<-rgb(255,0,0,150,maxColorValue=255)

myRegion<-c(myR1,myR2,myR3,myR4,myR5,myR6)
myColour<-c(myC1,myC2,myC3,myC4,myC5,myC6)

myRegions<-read.xls("myData/gapminder/regions.xlsx", encoding="latin1")

for (i in 1:length(myRegion)) 
{
myRegionSelection<-subset(myRegions$ID,myRegions$Group==myRegion[i])
myCountrySelection<-NULL
for (j in 1:length(myRegionSelection)) myCountrySelection<-c(myCountrySelection, trim(as.character(myRegionSelection[j])))
for (j in 1:length(myCountrySelection))
{
myMapColours[grep(paste("^",myCountrySelection[j],"$",sep=""),myCountries)]<-myColour[i]
} 
}

# Create chart

plot(m,col=myMapColours,border=F)

# Titling

mtext("Colour by region",3,line=0,adj=0,cex=4,family="Lato Black")


dev.off()
