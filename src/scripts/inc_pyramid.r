# inc_pyramid.r

myMark_right<-right
myMark_right[!(rownames(myMark_right) %in% seq(10,90,by=10)),]<-0
myMark_left<-left
myMark_left[!(rownames(myMark_left) %in% seq(10,90,by=10)),]<-0

myColour_right_outer<-rgb(255,0,210,50,maxColorValue=255)
myColour_right_inner<-rgb(255,0,210,120,maxColorValue=255) 
myColour_left_inner<-rgb(191,239,255,220,maxColorValue=255)
myColour_left_outer<-rgb(191,239,255,100,maxColorValue=255)

myColour_right<-c(myColour_right_inner,myColour_right_outer)
myColour_left<-c(myColour_left_inner,myColour_left_outer)

myB1<-barplot(t(right),axes=F,horiz=T,axis.lty=0,border=NA,col=myColour_right,xlim=c(-750,750))
myB2<-barplot(-t(left),axes=F,horiz=T,axis.lty=0,border=NA,col=myColour_left,xlim=c(-750,750),add=T)

barplot(t(myMark_right),axes=F,horiz=T,axis.lty=0,border=NA,col=myColour_right,xlim=c(-750,750),add=T)
barplot(-t(myMark_left),axes=F,horiz=T,axis.lty=0,border=NA,col=myColour_left,xlim=c(-750,750),add=T)

abline(v=0,lwd=25,col=par("bg"))
mtext(abs(seq(-600,600,by=200)),at=seq(-600,600,by=200),1,line=-1,cex=0.80)
for (i in seq(10,90,by=10)) text(0,i+i*0.2,i,cex=1.1)

mtext("Men",3,line=0,adj=0.25,cex=1.5,col="grey")
mtext("Women",3,line=0,adj=0.75,cex=1.5,col="grey")