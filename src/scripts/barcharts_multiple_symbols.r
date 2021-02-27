pdf_file<-"pdf/barcharts_multiple_symbols.pdf"
cairo_pdf(bg="grey98", pdf_file,width=13,height=10.5)

par(omi=c(0.65,0.65,0.85,0.85),mai=c(1.1,5.85,1.55,0),family="Lato Light",las=1)  

# Prepare chart

col_f<-rgb(255,97,0,190,maxColorValue=255)
col_m<-rgb(68,90,111,190,maxColorValue=255)
source("scripts/inc_labels_za4753.r")

# Create chart

plot(1:5,type="n",axes=F,xlab="",ylab="",xlim=c(0,20),ylim=c(1,6))
mySymbols<-function(n_f,n_m,y,labelling,... ){
par(family="Symbol Signs")
for (i in 1:n_f)
{
text(runif(1,0,(n_f+ n_m)/10),runif(1,y,y+1),"F",cex=3.25,
	col=col_f)
}
for (i in 1:n_m)
{
text(runif(1,0,(n_f+ n_m)/10),runif(1,y,y+1),"M",cex=3.25,
	col=col_m)
}
par(family="Lato Light")
text(-3,y+0.5,labelling,xpd=T,cex=1.45,adj=1)
}
mySymbols(round(336/10),round(350/10),1,myC_v161)
mySymbols(round(454/10),round(525/10),3,myC_v160)
mySymbols(round(865/10),round(720/10),5,myC_v159)
axis(1,at=c(0,5,10,15,20),labels=c("0","500","1,000","1,500","2,000"),col=par("bg"),col.ticks="grey81",lwd.ticks=0.5,tck=-0.025)

# Other elements

abline(v=c(0,5,10,15,20),lty="dotted")

# Titling

mtext("It is often said that attitudes towards gender roles are changing",3,line=-0.5,adj=0,cex=1.8,family="Lato Black",outer=T)
mtext("Agree strongly / agree",3,line=-3,adj=0,cex=1.8,outer=T,font=3)
mtext("Source: EVS 2008 Germany, ZA4753",1,line=0,adj=1,cex=1.5,outer=T,font=3)
mtext("2,075 respondents. Every figure represents 10 people ",1,line=-2,adj=0,cex=1.5,outer=T,font=3)

par(family="Lato Light")
mtext(" Women",1,line=1,adj=0.02,cex=1.5,outer=T,font=3)
mtext(" Men",1,line=1,adj=0.12,cex=1.5,outer=T,font=3)
par(family="Symbol Signs")
mtext("F",1,line=1,adj=0,cex=2.5,outer=T,font=3,col=col_f)
mtext("M",1,line=1,adj=0.1,cex=2.5,outer=T,font=3,col=col_m)
dev.off()
