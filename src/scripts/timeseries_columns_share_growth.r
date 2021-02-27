pdf_file<-"pdf/timeseries_columns_share_growth.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=9)

par(las=1,cex=0.9,omi=c(0.75,0.5,1.25,0.5),mai=c(0.5,1,0,1),family="Lato Light",las=1)

# Define data

myData<-c(25296,28365,32187,36835,39788,44282,51122,60420,58437,62484)/1000
myLabels<-c(2002:2011)
myGrowth<-0
for (i in 2:length(myData)) myGrowth<-c(myGrowth,myData[i]-myData[i-1])
myValueLeft<-myData-myGrowth

x<-rbind(t(myData),t(myData))
y<-rbind(t(myValueLeft),rep(0,length(myData)))
f1<-"darkgreen"; f2<-"grey60"
myColours<-c(f1,f2)
for (i in 1:length(myData)-1) myColours<-c(myColours,f1,f2)

for (i in 1:length(myData))
{
if (y[1,i]>x[1,i]) 
{
	tmp<-x[1,i]; x[1,i]<-y[1,i]; y[1,i]<-tmp
	myColours[(2*i)-1]<-"darkred"
}
}

# Create chart and other elements

barplot(x,beside=T,border=NA,col=myColours,space=c(0,2),axes=F)
barplot(y,beside=T,border=NA,col=rep("grey60",2*length(myData)),add=T,names.arg=myLabels,space=c(0,2),axes=F)
axis(2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)

hoehe<-0.1*max(myData)
j<-1
k<-j
for (i in 1:length(myData))
{
if (j > 1) k<-k+4 
text(k+1.3,hoehe,format(round(x[2,i]),nsmall=0),cex=1.25,adj=0,xpd=T,col="white")
j<-j+3
if (i<length(myData)) text(k+3.1,y[1,i+1]+((x[1,i+1]-y[1,i+1])/2), 
	format(round(myGrowth[i+1],1),cex=0.75,nsmall=1),adj=0)
}

# Titling

mtext("Sales Development Microsoft",3,line=4,adj=0,family="Lato Black",outer=T,cex=2)
mtext("Figures in Bill. US-Dollars",3,line=1,adj=0,cex=1.35,font=3,outer=T)
mtext("Source: money.cnn.com",1,line=2,adj=1.0,cex=1.1,font=3,outer=T)
dev.off()