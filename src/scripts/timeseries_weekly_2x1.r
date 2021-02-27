pdf_file<-"pdf/timeseries_weekly_2x1.pdf"
cairo_pdf(bg="grey98", pdf_file,width=9,height=6)

source("scripts/inc_datadesign_dbconnect.r")
par(omi=c(0.5,0.25,0.25,0.5),mai=c(0.25,0.75,0.75,0.25),mfcol=c(2,1),
	cex=0.7,mgp=c(4,1,0),family="Lato Light",las=1)

# Import data 

sql<-"select left(week,10) week, losing_weight, chicken_soup from google_trends"
myData<-dbGetQuery(con,sql)
myData$x<-as.Date(myData$week)
attach(myData)

# Create chart

plot(x,losing_weight,type="l",col="darkblue",ylab="Normalized Search Activity",cex.axis=1.2)
mtext("'losing weight'",3,line=1,adj=0,cex=1,col="darkblue",family="Lato Black")

plot(x,chicken_soup,type="l",col="darkred",ylab="Normalized Search Activity",cex.axis=1.2)
mtext("'chicken soup'",3,line=1,adj=0,cex=1,col="darkred",family="Lato Black")

# Titling

mtext("Google Trends: Number of search queries 2004-2012",3,line=-2,adj=0,cex=1.5,family="Lato Black",outer=T)
mtext("Weekly basis. Source: www.google.com/trends",1,line=1,adj=1.0,cex=0.85,font=3,outer=T)
dev.off()
