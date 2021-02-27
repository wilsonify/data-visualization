pdf_file<-"pdf/maps_minard_napoleon_inc.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11.69,height=7.26)

par(omi=c(1,0.1,0.75,0.1),mai=c(0.25,0,3,0),lend=1,family="Felipa",las=1)  
library(HistData); library(mapdata)

# Import data

#load("data/Minard.troops_de"); data(Minard.cities)
data(Minard.troops); data(Minard.cities)
towards_all<-subset(Minard.troops,direction=="A")
backwards_all<-subset(Minard.troops,direction=="R")

# Define chart and other elements

plot(Minard.troops$long,Minard.troops$lat,type="n",axes=F,xlab="",ylab="")
for (i in 1:3)
{
towards<-towards_all[towards_all$group==i,]
n<-nrow(towards)-1
for (j in 1:n)
{
z<-j+1
x<-towards[j:z,]
x
lines(x$long,x$lat,type="l",col="bisque2",lwd=x$survivors[1]/4500)
}
backwards<-backwards_all[backwards_all$group==i,]
n<-nrow(backwards)-1
for (j in 1:n)
{
backwards<-backwards_all[backwards_all$group==i,]
z<-j+1
x<-backwards[j:z,]
x
lines(x$long,x$lat,type="l",col="azure4",lwd=x$survivors[1]/4500)
}
}
attach(Minard.cities)
text(long,lat,city)
rivers<-map("rivers",plot=F,add=T)
points(rivers$x,rivers$y,col=rgb(0,0,255,120,maxColorValue=255),type="l")
par(xpd=T)
legend(32.5,54.15,c("300,000","200,000","100,000"),border=F,pch="|",col=c("bisque2","bisque2","bisque2"),bty="n",cex=1.3,pt.cex=c(3,2,1),xpd=NA,ncol=3)
legend(32.5,53.6,c("Campaign","Retreat"),border=F,pch=19,pt.cex=4,col=c("bisque2","azure4"),bty="n",cex=1.3,xpd=NA,ncol=3)
text(37.4,53.93,"Survivors",cex=1.1,xpd=T)
par(family="Dr Sugiyama")

# Titling

mtext("Carte figurative ",line=-0.5,adj=0.12,cex=3,col="azure4",outer=T)
mtext("des pertes ",line=-0.5,adj=0.80,cex=1.5,col="azure4",outer=T)
par(family="Lato Light")
mtext(side=1,adj=0,line=3,"Source: www.insee.fr/fr/ffc/docs_ffc/CS126L.PDF (Text); R library histdata (Data)",outer=T)
dev.off()
