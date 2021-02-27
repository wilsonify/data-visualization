pdf_file<-"pdf/columncharts_shares_1x4.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=7)

par(cex=0.9,omi=c(0.75,0.5,1.25,0.5),mai=c(0.5,1,0.75,1),mgp=c(3,2,0),family="Lato Light",las=1)

# Import data

source("scripts/inc_data_dfg.r", encoding="latin1")

# Create charts and other elements

barplot(x,col=c(myC1a,myC1a,myC2a,myC2a,myC3a,myC3a,myC4a,myC4a),beside=T,border=NA,axes=F,names.arg=c("","","",""))
barplot(2*y,col=c(myC1a,myC1b,myC2a,myC2b,myC3b,myC3b,myC4a,myC4b),beside=T,border=NA,axes=F,add=T,names.arg=labelling,cex.names=1.25)
z<-1
for (i in 1:4)
{
text(z+0.25,x[1,i]/2,format(round(x[1,i],1),nsmall=1),adj=0)
text(z+1.25,y[2,i],format(round(y[2,i],1),nsmall=1),adj=0,col="white")
text(z+0.65,x[1,i]+50,paste(format(round(100*y[2,i]/x[1,i],1),
	nsmall=1),"%",sep=" "),adj=0,cex=1.5,xpd=T)
z<-z+3
}

# Titling

mtext("DFG grants in 2010",3,line=4,adj=0,family="Lato Black",outer=T,cex=2)
mtext("Individual grants by science sector, values in million Euro. Percent value: approval quota",3,line=1,adj=0,cex=1.35,font=3,outer=T)
mtext("Source: DFG Information Cards, www.dfg.de",1,line=2,adj=1.0,cex=1.1,font=3,outer=T)
dev.off()
