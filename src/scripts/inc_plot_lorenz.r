plot(x,y,type="n",axes=F,xlab="cumulative percentage of population",ylab="cumulative percentage of income")

pos1<-round(0.25*length(x),0)
pos2<-round(0.75*length(x),0)

rect(0,0,1,1,border=F,col=rgb(200,0,0,25,maxColorValue=255))
rect(0,0,x[pos2],y[pos2],border=F,col="white")
rect(0,0,x[pos1],y[pos1],border=F,col=rgb(200,0,0,100,maxColorValue=255))
lines(x,y)
x<-array(c(0,1,0,1),dim=c(2,2))
lines(x)
text(0.35,y[pos1]/2,paste(round(100*y[pos1],digits=0),"%",sep=" "))
text(0.1,1-(1-y[pos2])/2,paste(round(100*(1-y[pos2]),digits=0),"%",sep=" "))

source("scripts/inc_axes_with_lines_lorenz.r")
