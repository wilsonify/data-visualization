pdf_file<-"pdf/pyramids_finely_outside_1x2.pdf"
cairo_pdf(bg="grey98", pdf_file,width=12,height=9)

#par(mai=c(0.2,0.1,0.2,0.1),omi=c(0.75,0.2,0.85,0.2),mfcol=c(1,2),cex=0.75,
par(mai=c(0.2,0.1,0.8,0.1),omi=c(0.75,0.2,0.85,0.2),mfcol=c(1,2),cex=0.75,family="Lato Light",las=1)

# Import data and prepare chart

myWomen<-read.csv("myData/women.txt",header =F,sep=",")
for(i in 1:111) colnames(myWomen)[i]<-paste("x",i+1949,sep="")
myMen<-read.csv("myData/men.txt",header =F,sep=",")
for(i in 1:111) colnames(myMen)[i]<-paste("x",i+1949,sep="")

myWSurplus<-(myWomen$x1970-myMen$x1970)
myWSurplus[myWSurplus < 0]<-0
myMSurplus<-(myMen$x1970-myWomen$x1970)
myMSurplus[myMSurplus < 0]<-0

right<-data.frame(myWomen$x1970-myWSurplus,myWSurplus)
left<-data.frame(myMen$x1970-myMSurplus,myMSurplus)

source("scripts/inc_pyramid.r")
mtext("1970",3,line=0,adj=0.5,cex=1,font=3)

myWSurplus<-(myWomen$x2010-myMen$x2010)
myWSurplus[myWSurplus < 0]<-0
myMSurplus<-(myMen$x2010-myWomen$x2010)
myMSurplus[myMSurplus < 0]<-0

right<-data.frame(myWomen$x2010-myWSurplus,myWSurplus)
left<-data.frame(myMen$x2010-myMSurplus,myMSurplus)

source("scripts/inc_pyramid.r")
mtext("2010",3,line=0,adj=0.5,cex=1,font=3)

# Titling

mtext("Age structure of the population in Germany",3,line=2,adj=0,cex=2.25,family="Lato Black",outer=T)
mtext("All values in thousands per year of age.",3,line=-0.5,adj=0,cex=1.25,font=3,outer=T)
mtext("Source: www.destatis.de/bevoelkerungspyramide/",1,line=2,adj=1.0,cex=0.95,font=3,outer=T)
mtext("Outer highlighted areas: surplus of women and men.",1,line=2,adj=0,cex=0.95,font=3,outer=T)
dev.off()
