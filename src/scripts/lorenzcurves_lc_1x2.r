pdf_file<-"pdf/lorenzcurves_lc_1x2.pdf"
cairo_pdf(bg="grey98", pdf_file,width=14,height=8)

par(mfcol=c(1,2),mai=c(0.25,0.25,0.25,0.25),omi=c(1.25,0.5,1.25,0.5),pin=c(4.5,4.5),cex=1.3,family="Lato Light",las=1,family="Lato Light")
library(Hmisc) 
library(ineq)

# Read data and prepare chart

myData<-spss.get("myData/AEQU+.por",use.value.labels=T)
x2008<-subset(myData$EQINCOM1,myData$EQINCOM1 > 0 & myData$V2 == "STUDIEN-NR. 4600")
Lc.Eplus2008<-Lc(x2008)
x1988<-subset(myData$EQINCOM1,myData$EQINCOM1 > 0 & myData$V2 == "STUDIEN-NR. 1670")
Lc.Eplus1988<-Lc(x1988)
x<-Lc.Eplus1988$p
y<-Lc.Eplus1988$L

# Create chart

source("scripts/inc_plot_lorenz.r")
x<-Lc.Eplus2008$p
y<-Lc.Eplus2008$L
source("scripts/inc_plot_lorenz.r")

# Titling

mtext("Lorenz Curve of Income Distribution in 1988 and 2008",3,line=1.5,adj=0,cex=1.85,family="Lato Black",outer=T)
mtext("German General Social Survey",3,line=-0.5,adj=0,cex=1.85,font=3,outer=T)
mtext("Source: GESIS ZA 4600, ZA 1670",1,line=2,adj=1,cex=1.05,font=3,outer=T)
dev.off()
