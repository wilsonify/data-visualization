pdf_file<-"pdf/timeseries_areas_corridor_2x2.pdf"
cairo_pdf(bg="grey98", pdf_file,width=10.65,height=9.2)

source("scripts/inc_datadesign_dbconnect.r")
par(mai=c(0.6,0.5,0,0),omi=c(0.2,0.5,1.25,0.25),mfcol=c(2,2),family="Lato Light",las=1)

# Import data and prepare chart

myColour1_150<-rgb(68,90,111,150,maxColorValue=255) 
myColour2_150<-rgb(255,97,0,150,maxColorValue=255)  

y1variable<-c("England_Weizen",
			  "Frankreich_Weizen",
			  "Niederlande_Roggen",
			  "Oesterreich_Roggen")
y2variable<-c("Belgien_Weizen",
			  "Oberitalien_Weizen",
			  "Deutschland_Roggen",
			  "Polen_Roggen")
			  
y1label<-c("England\n(Wheat)",
				  "France\n(Wheat)",
				  "Netherlands\n(Rye)",
				  "Austria\n(Rye)")
y2label<-c("Belgiun\n(Wheat)",
				  "North Italy\n(Wheat)",
				  "Germany\n(Rye)",
				  "Poland\n(Rye)")

for (i in 1:length(y1variable))
{
sql<-paste("select jahr x,",y1variable[i]," y1,",y2variable[i]," y2,Min_Getreide,Max_Getreide from z8082 where jahr > 0",sep="")
rs<-dbGetQuery(con,sql)

attach(rs)


# Create chart and other elements

plot(x,y1,axes=F,type="n",xlab="",ylab="",cex.lab=0.8,xlim=c(1200,2000),ylim=c(0,250),xpd=T)
xx<-c(x,rev(x))
yy<-c(Max_Getreide,rev(Min_Getreide))
polygon(xx,yy,col=rgb(68,90,111,80,maxColorValue=255),border=F)
lines(x,y1,type="l",col=myColour1_150,lwd=3,xpd=T)
lines(x,y2,type="l",col=myColour2_150,lwd=3)
text(1600,200,y1label[i],adj=0,cex=1.3,col=myColour1_150)
text(1810,25,y2label[i],adj=0,cex=1.3,col=myColour2_150)
if (i==2 | i==4) axis(1,at=c(1200,1400,1600,1800,2000))
axis(2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
}

# Titling

mtext("Prices for wheat and rye in Europe 1200-1960",3,line=3,adj=0,family="Lato Black",cex=1.8,outer=T)
mtext("in g silver/100 kg, decennial means",3,line=1,adj=0,font=3,cex=1.2,outer=T)
dev.off()