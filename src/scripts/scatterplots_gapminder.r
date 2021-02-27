pdf_file<-"pdf/scatterplots_gapminder.pdf"
cairo_pdf(bg="grey98", pdf_file,width=13,height=9)

par(omi=c(0.25,0.25,1.25,0.25),mai=c(1.5,0.85,0,0.5),family="Lato Light",las=1)

# Import data and prepare chart

library(gdata)
myGdp<-read.xls("myData/gapminder/indicatorgapmindergdp_per_capita_ppp.xls", encoding="latin1")
mySelection<-c("X","X2010")
myGdp2010<-myGdp[mySelection]

myExp<-read.xls("myData/gapminder/indicatorlife_expectancy_at_birth.xls", encoding="latin1")
mySelection<-c("Life.expectancy.at.birth","X2010")
myExp2010<-myExp[mySelection]

myGdpExp2010<-merge(myGdp2010,myExp2010,by.x="X",by.y="Life.expectancy.at.birth",all =T)

myPop<-read.xls("myData/gapminder/indicatorgapminderpopulation.xls",dec=".", encoding="latin1")
mySelection<-c("Total.population","X2010")
myPop2010<-myPop[mySelection]

myGdpExpPop2010<-merge(myGdpExp2010,myPop2010,by.x="X",by.y="Total.population",all =T)

myRegions<-read.xls("myData/gapminder/regions.xlsx", encoding="latin1")

myData<-merge(myGdpExpPop2010,myRegions,by.x="X",by.y="Entity",all =T)
myData<-na.omit(myData)

attach(myData)
X2010<-as.numeric(gsub(",","",X2010))/10000000

xmax<-round(max((X2010)),1)
x75<-round(quantile((X2010),probs=0.75),1)
x25<-round(quantile((X2010),probs=0.25),1)

xmax_leg<-round(max((X2010)^0.5)/3,1)
x75_leg<-round(quantile((X2010)^0.5,probs=0.75)/3,1)
x25_leg<-round(quantile((X2010)^0.5,probs=0.25)/3,1)

mySize<-(X2010)^0.5
myData$mySize<-mySize

myOld<-c("Sub-Saharan Africa","South Asia","Middle East & North Africa",
	"America","Europe & Central Asia","East Asia & Pacific")
myNew<-c(rgb(0,115,157,150,maxColorValue=255),
	   rgb(158,202,229,150,maxColorValue=255),
	   rgb(84,196,153,150,maxColorValue=255),
	   rgb(255,255,0,150,maxColorValue=255),
	   rgb(246,161,82,150,maxColorValue=255),
	   rgb(255,0,0,150,maxColorValue=255))
myColours<-as.character(Group)
for (i in 1:length(myOld)) {myColours[myColours == myOld[i]]<-myNew[i]}

# Define chart and other elements

plot(log10(X2010.x),X2010.y,type="n",axes=F,xlab="",ylab="")
points(log10(X2010.x),X2010.y,cex=mySize,pch=19,col=myColours,lwd=0)
axis(1,at=log10(c(200,400,1000,2000,4000,10000,20000,50000)),label=format(c(200,400,1000,2000,4000,10000,20000,50000),big.mark="."))
axis(2)
title(xlab="GDP per Person in US Dollars (purchasing power adjusted) (log scale)",ylab="Life expectancy at birth (years)",font=3)

myFit<-lm(X2010.y ~ log10(X2010.x))
myData$resid<-residuals(myFit)
myData$myFit<-fitted(myFit)

myData.sort<-myData[order(-abs(myData$resid)) ,]
myData.sort_begin<-myData.sort[1:5,]

attach(myData.sort_begin)
text(log10(X2010.x),X2010.y,X,cex=0.95,pos=1,offset=0.8)

# Titling

mtext("Gapminder World Map 2010",3,line=3,adj=0,cex=3,family="Lato Black",outer=T)
mtext("More money often leads to longer lives (i.e. better health). ",3,line=0,adj=0,cex=1.75,font=3,outer=T)
mtext("Source: http://www.gapminder.org/",1,line=5.5,adj=1.0,cex=1.55,font=3)

text(log10(30000),72.5,"Population Size",family="Lato Black",cex=1.35,adj=0)
text(log10(65000),70,paste(10*x25," Mio.",sep=""),adj=0)
text(log10(65000),68,paste(10*x75," Mio.",sep=""),adj=0)
text(log10(65000),66,paste(10*xmax," Mio.",sep=""),adj=0)

# Map Legend

library(mapplots)
legend.bubble(log10(45000),67,z=c(x25_leg,x75_leg,xmax_leg*0.7),maxradius=xmax_leg*0.7,bg=NA,txt.cex=0.01,txt.col=NA,pch=21,pt.bg="#00000020",bty="n",round=1)

# Integration of the chart  

par(new=T, mai=c(1,9,3.5,0.75))
library(maptools) # contains  wrld_simpl
library(rgdal) # for spTransform

data(wrld_simpl) 
myW<-wrld_simpl[wrld_simpl@data[,"NAME"] != "Antarctica",] 
m<-spTransform(myW,CRS=CRS("+proj=merc"))

myCountries<-m@data$ISO2
n<-length(myCountries) 
myMapColours<-numeric(n) 

myR1<-"Sub-Saharan Africa"
myR2<-"South Asia"
myR3<-"Middle East &amp; North Africa"
myR4<-"America"
myR5<-"Europe & Central Asia"
myR6<-"East Asia & Pacific"

myF1<-rgb(0,115,157,150,maxColorValue=255)
myF2<-rgb(158,202,229,150,maxColorValue=255)
myF3<-rgb(84,196,153,150,maxColorValue=255)
myF4<-rgb(255,255,0,150,maxColorValue=255)
myF5<-rgb(246,161,82,150,maxColorValue=255)
myF6<-rgb(255,0,0,150,maxColorValue=255)

myRegion<-c(myR1,myR2,myR3,myR4,myR5,myR6)
myColour<-c(myF1,myF2,myF3,myF4,myF5,myF6)

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

plot(m,col=myMapColours,border=F, bg=NA)
mtext("World Regions",3,line=-2,adj=0.5,cex=1.25,family="Lato Black")

dev.off()
