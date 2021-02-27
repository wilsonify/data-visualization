pdf_file<-"pdf/timeseries_daily.pdf"
cairo_pdf(bg="grey98", pdf_file,width=10,height=8.27)

par(cex.axis=1.1,omi=c(1,0.5,0.95,0.5),mai=c(0.1,1.25,0.1,0.2),mgp=c(5,1,0),family="Lato Light",las=1) 

# Import data

christmas<-read.csv(file="myData/allyears.calendar.byday.dat.a",head=F,sep=" ",dec=".")
attach(christmas)

# Create chart

plot(axes=F,type="n",xlab="",ylab="number of deaths",V1,V2)

# other elements 

axis(1,tck=-0.01,col="grey",cex.axis=0.9,at=V1[c(1,length(V1))],labels=c("1 July","30 June")) 
axis(2,at=py<-pretty(V2),labels=format(py,big.mark=","),cex.axis=0.9,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
points(V1,V2,type="l")
points(lowess(V2,f=1/5),type="l",lwd=25,col=rgb(255,97,0,70,maxColorValue=255))
text(123,V2[179],"Christmas",cex=1.1)
arrows(157,V2[179],172,V2[179],length=0.10,angle=10,code=0,lwd=2,col=rgb(100,100,100,100,maxColorValue=255))
arrows(192,V2[185],220,V2[185],length=0.10,angle=10,code=0,lwd=2,col=rgb(100,100,100,100,maxColorValue=255))
text(240,V2[185],"New Year",cex=1.1)

# Titling

mtext("Death risk on Christmas and New Year 1979-2004 (USA)",3,line=1.5,adj=0,cex=2,family="Lato Black",outer=T)
mtext("Number of deaths before reaching the emergeny room, sums of years per day",3,line=-0.2,adj=0,cex=1.35,font=3,col="black",outer=T)
mtext("Source: David Phillips, Gwendolyn E. Barker, Kimberly E. Brewer, Christmas and New Year as risk factors for death, Social Science & Medicine 71 (2010) 1463-1471",1,line=3,adj=1,cex=0.75,font=3,outer=T)
dev.off()
