pdf_file<-"pdf/lorenzcurves_barcharts_10.pdf"
cairo_pdf(bg="grey98", pdf_file,width=12,height=9)

library(fBasics) # for seqPalette
library(gdata)

layout(matrix(c(1,2,1,2),2,2),heights=c(6,1))
par(omi=c(1,0.5,1.25,0.25),mai=c(0,2.65,0.75,0.25),cex=1.5,family="Lato Light",las=1)

# Read data

myData<-read.xls("myData/income_ten_classes.xlsx",head=T,skip=1,dec=".", encoding="latin1")

# Create chart and other elements

bp1<-barplot(as.matrix(myData),ylim=c(0,3),width=c(0.45),axes=F,horiz=T,col=c("grey",seqPalette(10,"OrRd")[2:10]),border=par("bg"),names.arg=c("2000","1986","2000","1984","2004","1984"))
arrows(0,-0.01,0,3.25,lwd=1.5,length=0,xpd=T,col="grey") 
text(100-(myData[10,]/2),bp1,col="white",cex=1.1,family="Lato Black",labels=paste(round(myData[10,],digits=0),"%",sep=" "),xpd=T)
text(-15,bp1[2],"USA",family="Lato Black",adj=1,xpd=T)
text(-15,bp1[4],"Mexico",family="Lato Black",adj=1,xpd=T)
text(-15,bp1[6],"Germany",family="Lato Black",adj=1,xpd=T)

# Create chart and other elements

par(mai=c(0,2.65,0.1,0.25))
bp2<-barplot(as.matrix(rep(10,10)),ylim=c(0,0.5),width=c(0.25),axes=F,horiz=T,col=seqPalette(10,"Greys"),border=par("bg"),names.arg=c("Uniform distribution"))
arrows(0,-0.01,0,0.35,lwd=1.5,length=0,xpd=T,col="grey") 
text(95,bp2,labels="10 %",col="white",xpd=T)
mtext(seq(0,100,by=20),at=seq(0,100,by=20),3,line=0,cex=1.15)

# Titling

mtext("Income Distribution over ten Classes in three Countries",line=2,adj=0,cex=2.25,family="Lato Black",outer=T)
myBreak<-strsplit( strwrap("In Mexico the richest 10% of income recipients held over 45% of the overall income in 2000, in the USA 
                           it was 29%, in Germany 24. Compared to 1984 the share did increase.",width=110),"\n") 
for(i in seq(along=myBreak)) 
{
mtext(myBreak[[i]],line=1.8-i,adj=0,side=3,cex=1.25,outer=T)
}
mtext("Source: World Income Inequality Database V2.Oc 2008",1,line=1.5,adj=1,cex=0.95,font=3,outer=T)
dev.off()