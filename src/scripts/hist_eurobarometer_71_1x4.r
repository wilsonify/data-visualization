pdf_file<-"pdf/hist_eurobarometer_71_1x4.pdf"
cairo_pdf(bg="grey98", pdf_file,width=12,height=3)

par(omi=c(1,0.5,0.75,0.5),mai=c(0.1,1.25,0.1,0.2),family="Lato Light",las=1) 
source("scripts/inc_datadesign_dbconnect.r")

# Daten einlesen und Grafik vorbereiten

sql<-"select * from v_za4972_countries"
myData<-dbGetQuery(con,sql)
attach(myData)
par(mfcol=c(1,4))

# Grafik erstellen

for (i in 2:5) hist(myData[,i],main=names(myData[i]),xlab="")
dev.off()