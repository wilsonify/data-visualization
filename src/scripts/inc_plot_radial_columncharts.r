# inc_plot_radial_columncharts.r

# go through all data in the selection 

for (i in 1:length(mySelection)) {
myCountry<-myData[mySelection[i],3:length(myData)]+1 
myCountry[is.na(myCountry)]<-1    # replacing missing values 

# ... produce a list for every country 

myCountryData<-NULL
for (j in 1:length(myCountry)) 
{
myCountryData<-c(myCountryData,list(0:as.numeric(myCountry[j])))
}
radial.pie(myDataMargin,label.prop=1.35,show.grid.labels=F,boxed.radial=F,show.radial.grid=F,grid.bg=par("bg"),grid.col=myGridColour,labels=myNames,sector.colors=myRColours,mar=myRadial_mar,radial.lim=c(0,11),xpd=T)

radial.pie(myCountryData,label.prop=1.35,show.grid.labels=F,boxed.radial=F,show.radial.grid=T,grid.bg=par("bg"),grid.col=myGridColour,labels=myNames,sector.colors=myRColours,mar=myRadial_mar,radial.lim=c(0,11),xpd=T,add=T)

radial.pie(myDataCenter,label.prop=1.35,show.grid.labels=F,boxed.radial=F,show.radial.grid=F,grid.bg=par("bg"),grid.col=myGridColour,labels=myNames,sector.colors=myMColours,mar=myRadial_mar,radial.lim=c(0,11),xpd=T,add=T)

myTitle<-myData[mySelection[i], "COUNTRY"]
mtext(myTitle,3,line=myMLine,adj=0.5,cex=2,col="white")
}
