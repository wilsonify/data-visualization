pdf_file<-"pdf/scatterplots_connected.pdf"
cairo_pdf(bg="grey98", pdf_file,width=10,height=10)

par(mai=c(1.1,1.25,0.15,0),omi=c(1,0.5,1,0.5), mgp=c(4.5,1,0),family="Lato Light",las=1)

# Import data and prepare chart

library(gdata)
myData<-read.xls("myData/gapminder/Greece.xlsx", encoding="latin1")
myData<-myData[myData$Year>=1985, ]

attach(myData)
n<-nrow(myData)
grGDP<-vector()
grLEXP<-vector()
for (i in 2:n) 
{
grGDP[i]<-(GDP[i]-GDP[i-1])/GDP[i-1]
grLEXP[i]<-(LEXP[i]-LEXP[i-1])/LEXP[i-1]
}
myData$grGDP<-grGDP*100
myData$grLEXP<-grLEXP*100
myData<-myData[2:n, ]

n<-nrow(myData)

t <- 1:n
ts <- seq(1, n, by = 1/10)
xs <- splinefun(t, myData$grGDP)(ts)
ys <- splinefun(t, myData$grLEXP)(ts)

# Define chart and other elements

plot(myData$grGDP, myData$grLEXP, type="n", xlab="Growth rate GDP (%)", ylab="Growth rate life expectancy (%)", cex.lab=1.5, axes=F)
axis(1,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025,cex.axis=1.25)
axis(2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025,cex.axis=1.25)

lines(xs, ys,lwd=7,col="grey")
for (i in 1:n)
{
symbols(myData$grGDP[i],myData$grLEXP[i],bg="brown",fg="white",circles=1,inches=0.25,add=T)
text(myData$grGDP[i],myData$grLEXP[i], myData$Year[i],col="white")
}

# Titling

mtext("GDP and life expectancy in Greece",3,adj=0,line=1.5,cex=2.5,family="Lato Black",outer=T)
mtext("Correlation of growth rates, 1986-2010",3,adj=0,line=-0.25,cex=1.5,font=3,outer=T)
mtext("Source: gapminder.org",1,line=2,adj=1,cex=1.25,font=3,outer=T)
dev.off()
