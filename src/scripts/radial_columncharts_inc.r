pdf_file<-"pdf/radial_columncharts_inc.pdf"
cairo_pdf(bg=par("bg"), pdf_file,width=9,height=9)

par(bg=rgb(0.8627,0.8627,0.8627))
par(omi=c(0,0,0,0),mai=c(0,2,0,0.5),family="Droid Sans Mono", col.lab=par("bg"))
library(plotrix)

# Import data and prepare chart

library(gdata)
source("scripts/inc_data_radial_columncharts.r")
myNames<-c("Rooms", 
		 "Dwelling", 
		 "Income", 
		 "Wealth", 
		 "Employment", 
		 "Unemployment", 
		 "Network", 
		 "Educational", 
		 "Reading", 
		 "Air", 
		 "Consultation", 
		 "Voter", 
		 "Life", 
		 "Health", 
		 "Satisfaction  ", 
		 "  Homicide", 
		 "Assault", 
		 "Long", 
		 "Children", 
		 "Time")

g1<-rgb(150,150,150,maxColorValue=255)
g2<-rgb(80,80,80,maxColorValue=255)
m<-rgb(180,180,180,maxColorValue=255)

n<-length(myNames)
myRadialColours<-rep(rgb(255,128,0,maxColorValue=255),n)
myMarginColours<-c(rep(g1,6),rep(g2,n-6))
myCenterColours<-rep(m,n)

radial_mar<-c(7,7,7,7)

myCountry<-myData["DEU",3:length(myData)]+1 
myCountry[is.na(myCountry)]<-1   

myCountryData<-NULL

for (j in 1:length(myCountry)) myCountryData<-c(myCountryData,list(0:as.numeric(myCountry[j])))

# Create chart

radial.pie(myDataMargin,label.prop=1.35,show.grid.labels=F,radlab=T,boxed.radial=F,show.radial.grid=F,grid.bg=par("bg"),grid.col="white",labels=myNames,sector.colors=myMarginColours,mar=radial_mar,radial.lim=c(0,11),xpd=T)

radial.pie(myCountryData,label.prop=1.35,show.grid.labels=F,radlab=T,boxed.radial=F,show.radial.grid=T,grid.bg=par("bg"),grid.col="white",labels=myNames,sector.colors=myRadialColours,mar=radial_mar,radial.lim=c(0,11),xpd=T,add=T)

radial.pie(myDataCenter,label.prop=1.35,show.grid.labels=F,radlab=T,boxed.radial=F,show.radial.grid=F,grid.bg=par("bg"),grid.col="white",labels=myNames,sector.colors=myCenterColours,mar=radial_mar,radial.lim=c(0,11),xpd=T,add=T)

par(family="Droid Sans Mono")
arctext("Economic Indicators",col="white",radius=12,start=1.3)
arctext("Social and Other Indicators",col="white",radius=12,start=4.3)
dev.off() 
