pdf_file<-"pdf/lorenzcurves_barcharts_05.pdf"
cairo_pdf(bg="grey98", pdf_file,width=12,height=9)

par(omi=c(0.5,0.5,1.1,0.5),mai=c(0,2,0,0.5),family="Lato Light",las=1)
library(fBasics)
library(gdata)

# Read data and prepare chart

myDataFile<-"myData/income_five_classes.xlsx"
myData<-read.xls(myDataFile,head=T,skip=1,dec=".",encoding="latin1")
layout(matrix(c(1,2),ncol=1),heights=c(80,20))

# Create chart

par(mai=c(0,1.75,1,0))
bp1<-barplot(as.matrix(myData),ylim=c(0,6),width=c(0.5),axes=F,horiz=T,col=c("grey",seqPalette(5,"OrRd")[2:5]),border=par("bg"),names.arg=gsub("."," ",names(myData),fixed=T),cex.names=1.55)

# Other elements

mtext(seq(0,100,by=20),at=seq(0,100,by=20),1,line=0,cex=1.15)
arrows(0,-0.03,0,7.30,lwd=1.5,length=0,xpd=T,col="grey") 
text(100-(myData[5,]/2),bp1,cex=1.1,labels=paste(round(myData[5,],digits=0),"%",sep=" "),col="white",family="Lato Black",xpd=T)

# Create chart

par(mai=c(0.55,1.75,0,0))
bp2<-barplot(as.matrix(rep(20,5)),ylim=c(0,0.5),width=c(0.20),horiz=T,col=seqPalette(5,"Greys"),border=par("bg"),names.arg=c("Uniform distribution"),axes=F,cex.names=1.25)

# Other elements

arrows(0,-0.01,0,0.35,lwd=1.5,length=0,xpd=T,col="grey") 
text(c(10,30,50,70,90),bp2,labels=c("20 %","20 %","20 %","20 %","20 %"),col=c("black","black","white","white","white"),xpd=T)

# Titling

title(main="Income Distribution over five Classes in different Countries",line=3,adj=0,cex.main=2.25,family="Lato Black",outer=T)
myBreak<-strsplit( strwrap("In Mexico the richest 10% of income recipients held over 45% of the overall income in 2000, in the USA 
                           it was 29%, in Germany 24. Compared to 1984 the share did increase.",width=110),"\n") 
for(i in seq(along=myBreak)) 
{
mtext(myBreak[[i]],line=(1.8-i)*1.5,adj=0,side=3,cex=1.25,outer=T)
}
mtext("Source: World Income Inequality Database V2.Oc 2008",side=1,adj=1,cex=0.95,font=3,outer=T)
dev.off()
