pdf_file<-"pdf/scatterplots_path_ellipse.pdf"
cairo_pdf(bg="grey98", pdf_file,width=10,height=10)

source("scripts/inc_datadesign_dbconnect.r")
par(mai=c(1,1,0.25,0.25),omi=c(1,0.5,1,0.5), mgp=c(4,1,0),family="Lato Light",las=1)

# Import data and prepare chart

sql<-"select * from gemeinden"
myData<-dbGetQuery(con,sql)
attach(myData)
mySelection<-subset(myData,bevinsg >= 12000 & bevinsg <= 16000)
attach(mySelection)
library(ellipse)
mx<-mean(bevm)
my<-mean(bevw)
mxy<-c(mx,my)
sxy<-sapply(mySelection[,c("bevm","bevw")],sd)
r<-cor(bevm,bevw)

# Define chart and other elements

plot(bevm,bevw,type="n",axes=F,xlab="Number of men",ylab="Number of women",xlim=c(4000,9000),ylim=c(4000,9000))
lines(ellipse(r,scale=sxy,centre=mxy))
abline(v=seq(4000,9000,by=1000),col="black",lty=3,lwd=1) 
abline(h=seq(4000,9000,by=1000),col="black",lty=3,lwd=1) 
axis(1,cex.axis=1.2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
axis(2,cex.axis=1.2,col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)
symbols(bevm,bevw,bg="red",circles=rep(2,nrow(mySelection)),inches=0.15,add=T,xpd=T,fg="white")
mySelection2<-subset(mySelection,bevm >= 7500 & bevw <= 6500)
attach(mySelection2)
text(bevm,bevw,iconv(gemeinde,"LATIN1","UTF-8"),family="Lato Black",pos=3,offset=1.1)

# Titling

mtext("Number of men and women in Germany",3,adj=0,line=1.5,cex=2.5,family="Lato Black",outer=T)
mtext("Municipalities, between 12,000 and 16,000 inhabitants",3,adj=0,line=-0.25,cex=1.5,font=3,outer=T)
mtext("Source: GV-ISys",1,line=2,adj=1,cex=1.25,font=3,outer=T)
dev.off()