pdf_file<-"pdf/pyramids_multicoloured.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=9)

par(mai=c(0.5,1,0.5,0.5),omi=c(0.5,0.5,0.5,0.5),family="Lato Light",las=1)

# Import data and prepare chart

myWomen<-read.csv("myData/women.txt",header =F,sep=",")
for(i in 1:111) colnames(myWomen)[i]<-paste("x",i+1949,sep="")
myMen<-read.csv("myData/men.txt",header =F,sep=",")
for(i in 1:111) colnames(myMen)[i]<-paste("x",i+1949,sep="")

right<-myWomen$x2010
left<-myMen$x2010

myColour_right<-c(rep(rgb(210,210,210,maxColorValue=255),15),rep(rgb(144,157,172,maxColorValue=255),50),rep(rgb(225,152,105,maxColorValue=255),length(right)-65))
myColour_left<-myColour_right

# Create chart and other elements

barplot(right,axes=F,horiz=T,axis.lty=0,border=NA,col=myColour_right,xlim=c(-750,750))
barplot(-left,axes=F,horiz=T,axis.lty=0,border=NA,col=myColour_left,xlim=c(-750,750),add=T)

abline(v=0,lwd=28,col=par("bg"))
for (i in seq(10,90,by=10)) text(0,i+i*0.2,i,cex=1.1)
mtext(abs(seq(-600,600,by=200)),at=seq(-600,600,by=200),1,line=-1,cex=0.80)

rect(-1000,15+15*0.2,1000,66+66*0.2,xpd=T,col=rgb(210,210,210,90,maxColorValue=255), border=NA)

mtext("working age",2,line=1.5,las=3,adj=0.38)
mtext("Men",3,line=-5,adj=0.25,cex=1.5,col="grey")
mtext("Women",3,line=-5,adj=0.75,cex=1.5,col="grey")

# Titling

mtext("Age structure of the population in Germany in 2010",3,line=-1.5,adj=0,cex=1.75,family="Lato Black",outer=T)
mtext("Values in thousands per year of age",3,line=-3.25,adj=0,cex=1.25,font=3,outer=T)
mtext("Source: www.destatis.de/bevoelkerungspyramide/",1,line=0,adj=1.0,cex=0.95,font=3,outer=T)
dev.off()
