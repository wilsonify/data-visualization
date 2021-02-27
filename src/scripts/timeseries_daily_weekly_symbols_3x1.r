pdf_file<-"pdf/timeseries_daily_weekly_symbols_3x1.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=8.27)

par(mfcol=c(3,1),cex.axis=1.4,omi=c(1,0.5,0.75,0.5),mai=c(0.1,0.2,0.1,0.2),family="Lato Light",las=1) 

# Prepare chart and import data

library(gdata)

myCountry<-c("USA","GB","GER")
myCountryName<-c("USA","GB","GER")
for (i in 1:length(myCountry)) 
{
myFile<-paste("myData/Facebook Happiness Index-",myCountry[i],".csv",sep="")
myData<-read.csv(myFile,skip=1)
myData$x<-as.Date(myData$Date)
myData<-subset(myData,myData$x>"2010-10-01")

# Define chart and other elements

plot(myData$x,myData$GNH,type="n",axes=F,ylab="",ylim=c(-0.05,0.4))
points(myData$x,myData$GNH,type="l",col="darkblue")

myData$myYear<-as.numeric(format(myData$x,"%Y"))
myData$myCw<-as.numeric(format(myData$x,"%V"))
myNewData<-myData[order(myData$myYear,myData$myCw,myData$GNH),]
myDay<-NULL
myColour<-NULL
n<-nrow(myNewData)-1
for (j in 1:n) 
{
if(myNewData$myCw[j+1] != myNewData$myCw[j]) 
{
	myDay<-c(myDay,as.character(myNewData$x[j]))
	myColour<-c(myColour,weekdays(myNewData$x[j]))
}
}
myColour<-as.numeric(as.factor(myColour))
points(as.Date(myDay),rep(-0.05,length(myDay)),pch=15,cex=1.5, col=myColour)

mtext(myCountryName[i],3,line=-3,adj=0,cex=1.3,font=3)
source("scripts/inc_daily_weeksymbols_datelabels.r")
}
axis(1,at=myData$x[c(1,length(myData$x))],labels=format(myData$x[c(1,length(myData$x))],"%d. %m. %Y "))
mtext("Happiest day in week:",1,line=3,adj=0,cex=0.9,font=3,outer=T)
legend(as.Date("2010-08-22"),-0.21,c("Mon","Tue","Wed","Thu","Fri","Sat","Sun"),pch=15,col=c(1,2,3,4,5,6,7),ncol=7,bty="n",xpd=NA,cex=1.5)

# Titling

mtext("Facebook Gross National Happiness Index 2010-2012",3,line=1,adj=0,cex=2,family="Lato Black",outer=T)
mtext("Daily values. Source: facebook.com",1,line=4.25,adj=1,cex=0.9,font=3,outer=T)
dev.off()

