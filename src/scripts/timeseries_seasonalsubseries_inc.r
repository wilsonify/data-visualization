pdf_file<-"pdf/timeseries_seasonalsubseries_inc.pdf"
cairo_pdf(bg="grey98", pdf_file,width=8,height=8)
par(omi=c(1,0,1,0.5),mai=c(2,0.80,0,0.5),family="Lato Light",las=1)


# Import data and prepare chart

source("scripts/inc_datadesign_dbconnect.r")
sql<-"select left(week, 4) year, substr(week, 6, 2) month, avg(chicken_soup) chicken_soup from google_trends group by left(week, 4), substr(week, 6, 2) order by year, month"
myData<-dbGetQuery(con,sql)
attach(myData)
y<-ts(chicken_soup,frequency =12,start=c(2004,1))

# Create chart

monthplot(y,axes=F,box=F,type="h",lwd=3,col="darkred",ylab="Normalized Search Activity")
axis(2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)

# Titling

mtext("Google trend for 'chicken soup'",3,line=2,adj=0,cex=2.0,family="Lato Black",outer=T)
mtext("Jan 2004 to Feb 2012",3,line=0,adj=0,cex=1.5,font=3,outer=T)
mtext("Source: www.google.com/trends",1,line=3,adj=1.0,cex=0.95,font=3,outer=T)
dev.off()