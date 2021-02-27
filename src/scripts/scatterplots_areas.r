pdf_file<-"pdf/scatterplots_areas.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11.69,height=9)

par(mai=c(0.85,1,0.25,0.25),omi=c(1,0.5,1,0.5),family="Lato Light",las=1)

# Import data and prepare chart

library(gdata)
myPersons<-read.xls("myData/persons.xlsx", encoding="latin1")
attach(myPersons)
myData<-subset(myPersons,w>0 & s=="m" & name!="Max Schmeling")
attach(myData)

# Define chart and other elements

plot(type="n",xlab="Height (cm)",ylab="Weight (kg)",h,w,xlim=c(160,220),ylim=c(50,125),axes=F)
axis(1,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
axis(2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)

myC1<-rgb(255,0,210,maxColorValue=255)
myC2<-rgb(0,208,226,100,maxColorValue=255)

myP1<-subset(myData[c("h","w")],w>20*(h/100*h/100) & w<25*(h/100*h/100))
myP2<-subset(myData[c("h","w")],w<20*(h/100*h/100))
myP3<-subset(myData[c("h","w")],w>25*(h/100*h/100))

myDes2<-as.matrix(subset(name,w<20*(h/100*h/100)))
myDes3<-as.matrix(subset(name,w>25*(h/100*h/100)))

symbols(myP1,bg=myC1,fg="white",circles=rep(1,nrow(myP1)),inches=0.25,add=T)
symbols(myP2,bg=myC2,fg="white",circles=rep(1,nrow(myP2)),inches=0.25,add=T)
symbols(myP3,bg=myC2,fg="white",circles=rep(1,nrow(myP3)),inches=0.25,add=T)

text(myP2,myDes2,cex=0.75,pos=1,offset=1.1,family="Lato Black")
text(myP3,myDes3,cex=0.75,pos=3,offset=1.1,family="Lato Black")

curve(20*(x/100*x/100),xlim=c(160,220),add=T)
curve(25*(x/100*x/100),xlim=c(160,220),add=T)

abline(v=mean(h,na.rm=T),lty=3)
abline(h=mean(w,na.rm=T),lty=3)
text(182.5,52,"Average height: 182 cm",adj=0,font=3)

# Titling

mtext("Relationship between height and weight",3,adj=0,line=2,cex=2.1,outer=T,family="Lato Black")
mtext("Selected celebrities",3,adj=0,line=0,cex=1.4,outer=T,font=3)
mtext("Source: celebrityheights.com, howmuchdotheyweigh.com",1,line=1,adj=1,cex=0.95,outer=T,font=3)
dev.off()
