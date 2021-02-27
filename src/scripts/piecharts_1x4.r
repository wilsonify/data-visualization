pdf_file<-"pdf/piecharts_1x4.pdf"
cairo_pdf(bg="grey98", pdf_file,width=14,height=6)

library(plotrix)
par(omi=c(0.5,0.5,1,0.5),mai=c(0,0,0,0),xpd=T,mfcol=c(1,4),family="Lato Light",las=1)

# Import data

source("scripts/inc_data_dfg.r")

# Define charts and other elements

for (i in 1:4)
{ 
plot(1:5,type="n",axes=F,xlab="",ylab="")
values<-c(x[2,i]-y[2,i],y[2,i])
myCircle<-floating.pie(3,3,values,border="white",radius=2.1*sqrt(x[1,i]/max(x[1,])),col=c(myColours1[i],myColours2[i]))
pie.labels(3,3,myCircle,values,bg=NA,border=NA,radius=x[1,i]/max(x[1,]),cex=2,col="white")
if (i==1) pie.labels(3,3,myCircle,c("rejected","granted"),bg=NA,border=NA,radius=1.95,font=3)
text(3,4.7,cex=2,adj=0.5,paste(format(round(100*y[2,i]/x[1,i],1),nsmall=1),"%",sep=" "))
text(3,1.2,labelling[i],cex=2,adj=0.5)
}

# Titling

mtext("DFG grants 2010",3,line=4,adj=0,family="Lato Black",outer=T,cex=2)
mtext("Individual grants by science sector, values in million Euro. Percent values: approval ratio",3,line=1,adj=0,cex=1.35,font=2,outer=T)
mtext("Source: DFG Information Cards 2011, www.dfg.de",1,line=2,adj=1.0,cex=1.1,font=3,outer=T)
dev.off()
