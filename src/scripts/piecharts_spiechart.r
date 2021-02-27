pdf_file<-"pdf/piecharts_spiechart.pdf"
cairo_pdf(bg="grey98", pdf_file,width=15,height=11)

par(omi=c(0.5,0.5,0.75,0.5),mai=c(0.1,0.1,0.1,0.1),family="Lato Light",las=1)
library(RColorBrewer)

# Import data and prepare chart

x<-read.xls("myData/Healthcare_costs.xlsx",1,encoding="latin1")
attach(x)
n<-nrow(x)
myFactor<-max(sqrt(Acosts60))/0.8

# Define chart and other elements

plot.new()
myC0<-rep(NA,n)
myColours<-brewer.pal(n,"Set3")
for (i in 1:n)
{
  par(new=T)
  r<-col2rgb(myColours[i])[1]
  g<-col2rgb(myColours[i])[2]
  b<-col2rgb(myColours[i])[3]
  myC0[i]<-rgb(r,g,b,190,maxColorValue=255)
  myValue<-format(Total60/1000000,digits=1)
  myTotal<-paste(Disease,": ",myValue," Mio. $",sep="") 
  if (Acosts60[i] == max(Acosts60)) {myDes<-myTotal} else {myDes<-NA}
  
  # Create slices
  
  pie(Patients60,border=NA,radius=sqrt(Acosts60[i])/myFactor,col=myC0,
      labels=myDes,cex=1.8)
  par(new=T)
  r<-col2rgb(myColours[i])[1]
  g<-col2rgb(myColours[i])[2]
  b<-col2rgb(myColours[i])[3]
  myC0[i]<-rgb(r,g,b,maxColorValue=255)
  pie(Patients60,border=NA,radius=sqrt(Pcosts60[i])/myFactor,col=myC0,labels=NA)
  myC0<-rep(NA,n)
}

# Titling

mtext("The Cost of Getting Sick",3,line=-1,adj=0,cex=3.5,family="Lato Black",outer=T)
mtext("The Medical Expenditure Panel Survey. Age: 60, Total Costs:  41.4 Mio. US $",3,line=-3.6,adj=0,cex=1.75,outer=T)
mtext("Inside: Personal Costs.  Outside: Insurer Costs.",1,line=0,adj=0,cex=1.75,outer=T,font=3)
mtext("visualization.geblogs.com/visualization/health_costs/",1,line=0,adj=1.0,cex=1.75,outer=T,font=3)
dev.off()
