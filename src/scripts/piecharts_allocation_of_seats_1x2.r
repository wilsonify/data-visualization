pdf_file<-"pdf/piecharts_allocation_of_seats_1x2.pdf"
cairo_pdf(bg="grey98", pdf_file,width=10,height=3.75)

par(omi=c(0.5,0.5,1,0.5),mai=c(0,0,0,0),xpd=T,mfcol=c(1,2),family="Lato Light")
library(plotrix)

# Define chart

plot(1:5,type="n",axes=F,xlab="",ylab="",xlim=c(1,5),ylim=c(1,10))
mySeats<-c(51,54,61,222,226)
myDes<-c(mySeats,""); mySlices<-50*mySeats /sum(mySeats)
myValues<-c(mySlices,50); myDisc<-100
MyColour<-c("white", "white", "black", "white", "white")

# Create chart

mySemiCircle<-floating.pie(3,1,myValues,border="white",radius=1.9,xpd=F,col=c("green","pink","yellow","red","black",par("bg")))
pie.labels(3,1,mySemiCircle,myDes,bg=NA,border=NA,radius=1.5,cex=2,col=MyColour)
floating.pie(3,1,myDisc,border="white",col=par("bg"),radius=0.7,xpd=F)
mtext("16th German Bundestag",3,line=0,adj=0.5,font=3,cex=1.3)

par(xpd=T)
legend(1,0.5,c("Union (CDU/CSU)","Socialist Party (SPD)","Free Democratic Party (FDP)","Left Party (Die Linke)"," Alliance '90/The Greens (Bündnis 90/Die Grünen)"),border=F,pch=15,col=c("black","red","yellow","pink","green"),bty="n",cex=0.7,xpd=NA,ncol=3)
par(xpd=F)

# Define chart

plot(1:5,type="n",axes=F,xlab="",ylab="",xlim=c(1,5),ylim=c(1,10))
mySeats<-c(68,76,93,146,237)
myDes<-c(mySeats,""); mySlices <-50*mySeats/sum(mySeats)
myValues<-c(mySlices,50); myDisc<-100

# Create chart

semicirlce<-floating.pie(3,1,myValues,border="white",radius=1.9,xpd=F,col=c("green","pink","yellow","red","black",par("bg")))
pie.labels(3,1,mySemiCircle,myDes,bg=NA,border=NA,radius=1.5,cex=2,col=MyColour)
floating.pie(3,1,myDisc,border="white",col=par("bg"),radius=0.7,xpd=F)
mtext("17th German Bundestag",3,line=0,adj=0.5,font=3,cex=1.3)

# Titling

mtext("Seat distribution in the German Bundestag",3,line=3,adj=0,family="Lato Black",outer=T,cex=1.8)
mtext("Source: www.bundestag.de",1,line=1,adj=1.0,cex=0.7,font=3,outer=T)
dev.off()

