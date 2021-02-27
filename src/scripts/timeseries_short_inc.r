pdf_file<-"pdf/timeseries_short_inc.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=4.2)

source("scripts/inc_datadesign_dbconnect.r")
par(mar=c(3,5,0.5,2),omi=c(0,0,0,0),family="Lato Light",las=1)

# Read data 

sql<-"select dezjahr, v39_weitere, v39_nutzen, v39_stilllegen from t_za2391_zeitreihen"
myDataset<-dbGetQuery(con,sql)
attach(myDataset)

# Create chart and other elements

plot(type="n",xlab="",ylab="Share in percent",dezjahr,v39_weitere,ylim=c(0,80))

myVars1<-c("dezjahr","v39_weitere")
myPoints1<-subset(myDataset[myVars1],!is.na(myDataset[myVars1]$v39_weitere))

myVars2<-c("dezjahr","v39_nutzen")
myPoints2<-subset(myDataset[myVars2],!is.na(myDataset[myVars2]$v39_nutzen))

myVars3<-c("dezjahr","v39_stilllegen")
myPoints3<-subset(myDataset[myVars3],!is.na(myDataset[myVars3]$v39_stilllegen))

myColour1<-rgb(200,97,0,150,maxColorValue=255)
myColour2<-rgb(100,97,0,maxColorValue=255)
myColour3<-rgb(130,130,130,maxColorValue=255)

points(myPoints1,col=myColour1,lwd=2,type="b")
points(myPoints2,col=myColour2,lwd=2,type="b")
points(myPoints3,col=myColour3,lwd=2,type="b")

text(2006,2,"build further",col=myColour1)
text(2005.5,78,"use existing",col=myColour2)
text(2005.5,25,"shut down existing",col=myColour3)

dev.off()
