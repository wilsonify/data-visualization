pdf_file<-"pdf/timeseries_monthly_2x1.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=6.2)

source("scripts/inc_datadesign_dbconnect.r")
par(omi=c(0.65,0.55,0.55,0.25),mai=c(0.25,0.25,0.25,0.25),mfcol=c(2,1),family="Lato Light",las=1)

# Read data

sql<-"select dezjahr decyear,v8,v9,v11,v12 from t_za2391_zeitreihen"
myData<-dbGetQuery(con,sql)
attach(myData)

# Create chart and other elements

plot(type="n",xlab="",ylab="Mittelwert",decyear, v8,col=rgb(255,97,0,150,maxColorValue=255),lwd=2,ylim=c(-2.5,2.5))
myVars1<-c("decyear","v8")
myVars2<-c("decyear","v9")
myColour1<-rgb(255,0,0,150,maxColorValue=255)
myColour2<-rgb(0,0,0,150,maxColorValue=255)
points(myData[myVars1],col=myColour1,lwd=1,type="l")
points(myData[myVars2],col=myColour2,lwd=1,type="l")
text(2007.5,0,"SPD",col=myColour1)
text(2007.5,2,"CDU",col=myColour2)

plot(type="n",xlab="",ylab="Mittelwert",decyear, v8,col=rgb(255,97,0,150,maxColorValue=255),lwd=2,ylim=c(-2.5,2.5))
myVars3<-c("decyear","v11")
myVars4<-c("decyear","v12")
myColour3<-"orange"
myColour4<-rgb(0,128,0,150,maxColorValue=255)
points(myData[myVars3],col=myColour3,lwd=1,type="l")
points(myData[myVars4],col=myColour4,lwd=1,type="l")
text(2007.5,1,"FDP",col=myColour3)
text(2007.5,-0.5,"Grüne",col=myColour4)

# Titling

mtext("Skalometer SPD, CDU, FDP, Grüne: 1977-2007",3,line=0,adj=0,cex=1.5,family="Lato Black",outer=T)
mtext("Monthly values. Source: www.gesis.org, ZA2391",1,line=3,adj=1.0,cex=0.95,font=3)
dev.off()
