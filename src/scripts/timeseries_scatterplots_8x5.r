pdf_file<-"pdf/timeseries_scatterplots_8x5.pdf"
cairo_pdf(bg="grey98", pdf_file,width=8.27,height=11.7)
par(omi=c(0.25,0.1,0.7,0.1),mai=c(0.1,0.1,0.45,0.1),mfrow=c(9,5),family="Lato Light",las=1)  

source("scripts/inc_datadesign_dbconnect.r")

# Read data and prepare chart

myCountry<-c("ARG","AUS","AUT","BGR", "CAN","CHL", "CHN", "CZE", "DEU", "DNK",
	 "DOM", "EST", "FIN", "FRA", "GBR", "HRV", "HUN", "IRL", "ISR", "ITA", 
	 "JPN", "KOR", "LVA", "MEX", "NLD", "NOR", "NZL", "PHL", "POL", "PRT", 
	 "RUS", "SVK", "SVN", "ESP", "SWE", "TUR", "TWN", "UKR", "USA", "ZAF")
myPart1<-"select Year, Gini from v_wiid2c_Gini where Country3='"
myPart2<-"'"
for (i in 1:length(myCountry))
{
sql1<-paste(myPart1,myCountry[i],myPart2,sep="")
sql2<-paste(myPart1,myCountry[i],myPart2," and Gini > 36",sep="")
myData<-dbGetQuery(con,sql1)
myData2<-dbGetQuery(con,sql2)

# Create chart and other elements

plot(myData,xlim=c(1950,2010),ylim=c(10,75),main=myCountry[i], type="n",axes=F)
rect(1950,36,2010,75,col=rgb(255,0,0,50,maxColorValue=255),lwd=0)
rect(1950,0,2010,36,col=rgb(68,90,111,50,maxColorValue=255),lwd=0)
points(myData,col=rgb(68,90,111,100,maxColorValue=255),pch=19,type="b")
axis(1,at=c(1950,2010),col=par("bg"),cex.axis=0.95)
if (length(myData2) > 0)
{
points(myData2,pch=19,col=rgb(255,0,0,100,maxColorValue=255))
}
}

# Titling

mtext("Inequality in 40 countries 1950-2010",3,outer=T,line=2,xpd=T,adj=0,family="Lato Black",cex=1.3)
mtext("Gini coefficient of income distribution (yearly values)",3,outer=T,line=0,xpd=T,adj=0,font=3)
mtext("Source: World Income Inequality Database V2.0c May 2008",1,outer=T,line=-3,xpd=T,adj=0.9,font=3)
mtext("Blue: up to 0.36. Red: more than 0.36",1,outer=T,line=-3,xpd=T,adj=0,font=3)
dev.off()
