pdf_file<-"pdf/lorenzcurves_panel_05.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=8)

par(omi=c(0.5,0.5,1.1,0.5),family="Lato Light",las=1)
layout(matrix(data=c(1,2,3,4,5),nrow=1,ncol=5),widths=c(2.0,1,1,1,1),heights=c(1,1))

library(gdata)

# Read data and prepare chart

myData<-read.xls("myData/income_five_classes.xlsx",skip=1,dec=".", encoding="latin1")
tmyData<-t(myData)
transparency<-c(0,50,100,150,200)
number_colour<-c("black","black","black","black","white")
pos<-c(45,45,45,45,35)
par(cex=1.05)

# Create chart and other elements

for (i in 1:5) {
if (i == 1)
{
par(mai=c(0.25,1.75,0.25,0.15))
bp1<-barplot(tmyData[ ,i],horiz=T,cex.names=1.6,axes=F,names.arg=gsub("."," ",names(myData),fixed=T),xlim=c(0,60),col=rgb(43,15,52,0,maxColorValue=255))
} else
{
par(mai=c(0.25,0.1,0.25,0.15))
bp2<-barplot(tmyData[ ,i],horiz=T,axisnames=F,axes=F,xlim=c(0,60),col=rgb(200,0,0,transparency[i],maxColorValue=255),border=par("bg"))
}
text(pos[i],bp1,adj=1,labels=paste(round(myData[i ,],digits=0),"%",sep=" "),col=number_colour[i],xpd=T,cex=1.3)
mtext(seq(0,60,by=15),at=seq(0,60,by=15),1,line=0,cex=0.85)
arrows(0,-0.1,0,14.6,lwd=2.5,length=0,xpd=T,col="grey") 
}

# Titling

title(main="Income Distribution over five Classes in different Countries",line=3,adj=0,cex.main=1.75,family="Lato Black",outer=T)
myBreak<-strsplit( strwrap("In Mexico the richest 20% of income recipients hold over 64% of the overall income, in Norway 
                              the figure is 40%. Compared interntionally Germany is in the upper half.",width=110),"\n") 
for(i in seq(along=myBreak)) 
{
mtext(myBreak[[i]],line=(1.8-i)*1.7,adj=0,side=3,cex=1.25,outer=T)
}
mtext("Source: World Income Inequality Database V2.Oc 2008",1,line=2,adj=1,font=3)
dev.off()