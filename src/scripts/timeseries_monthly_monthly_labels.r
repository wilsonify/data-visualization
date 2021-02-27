pdf_file<-"pdf/timeseries_monthly_monthly_labels.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=4.8)

source("scripts/inc_datadesign_dbconnect.r")
par(cex=0.75,bg=rgb(240,240,240,maxColorValue=255))
par(omi=c(0.75,0.25,0.5,0.25),mai=c(0.25,0.55,0.25,0),mgp=c(2,1,0),family="Lato Light",las=1)  
myColour1<-rgb(255,0,0,150,maxColorValue=255)
myColour2<-rgb(0,0,0,150,maxColorValue=255)

# Read data

sql<-"select concat_ws('-',jahr,monat,'01') monat, v8, v9 from t_za2391_zeitreihen where jahr >= 2002"
myData<-dbGetQuery(con,sql)
attach(myData)

# Create chart and other elements

plot(type="n",axes=F,xlab="",ylab="Mean",as.Date(monat),v8,col=rgb(255,97,0,150,maxColorValue=255),lwd=2,ylim=c(-1,2))

mbegin<-seq(as.Date("2002-01-01"),as.Date("2008-01-01"),by="1 months")
ybegin<-seq(as.Date("2002-01-01"),as.Date("2008-01-01"),by="1 years")
abline(v=ybegin,col="lightgrey")

points(as.Date(monat),v8,col=myColour1,lwd=5,type="l")
points(as.Date(monat),v9,col=myColour2,lwd=5,type="l")

text(as.Date("2007-10-01"),0.5,"SPD",col=myColour1,cex=1.5)
text(as.Date("2007-10-01"),1.5,"CDU",col=myColour2,cex=1.5)

axis(1,col=rgb(60,60,60,maxColorValue=255),at=mbegin,labels=format(mbegin,"%b\n%Y"),cex.axis=0.85,lwd.ticks=0.1,tck=-0.02)
axis(2,col=rgb(240,240,240,maxColorValue=255),col.ticks=rgb(60,60,60,maxColorValue=255),lwd.ticks=0.5,cex.axis=0.85,tck=-0.025,pos=as.Date("2001-12-15"))

# Titling

mtext("Politbarometer 2002-2007",3,line=0,adj=0,cex=1.5,family="Lato Black",outer=T)
mtext("Monthly values. Source: ZA2391, www.gesis.org",1,line=2,adj=1.0,cex=0.85,font=3,outer=T)
dev.off()
