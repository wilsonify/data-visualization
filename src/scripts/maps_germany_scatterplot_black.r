pdf_file<-"pdf/maps_germany_scatterplot_black.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=11)

par(bg="black",mai=c(0,0,0,0),omi=c(0.5,1,1,0.5),family="Lato Light",las=1)
library(RColorBrewer)

# Import data

source("scripts/inc_datadesign_dbconnect.r")
sql<-"select * from v_women_men"
myDataset<-dbGetQuery(con,sql)
attach(myDataset)

# Create chart

plot(lng,lat,type="n",axes=F)
myColour<-rgb(255,255,0,100,maxColorValue=255)
points(lng,lat,pch=19,col=myColour,cex=4*sqrt(bevinsg),lwd=0)

# Titling

mtext("Germany at night......",side=3,adj=0,line=1,cex=3,family="Lato Black",col="white")
mtext("Source: www.bundeswahlleiter.de",side=1,adj=1,line=0,cex=1,font=3,col="white")
dev.off()
