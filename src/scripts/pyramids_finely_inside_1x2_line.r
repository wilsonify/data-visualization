pdf_file<-"pdf/pyramids_finely_inside_1x2_line.pdf"
cairo_pdf(bg="grey98", pdf_file,width=12,height=9)

par(mai=c(0.2,0.1,0.8,0.1),omi=c(0.75,0.2,0.85,0.2),mfcol=c(1,2),cex=0.75,family="Lato Light",las=1)

# Import data and prepare chart
library(gdata)
x1991<-read.xls("myData/12411-0008_1991_reformatted.xlsx", encoding="latin1")
x1991<-x1991[1:nrow(x1991)-1,]

attach(x1991)

myF_married<-X6/1000
myF_unmarried<-(X5+X7+X8)/1000
myM_married<-X2/1000
myM_unmarried<-(X1+X3+X4)/1000

right<-data.frame(myF_married,myF_unmarried)
left<-data.frame(myM_married,myM_unmarried)

source("scripts/inc_pyramid.r")
mtext("1970",3,line=0,adj=0.5,cex=1,font=3)

x2010<-read.xls("myData/12411-0008_2010_reformatted.xlsx", encoding="latin1")
x2010<-x2010[1:nrow(x2010)-1,]

right_line<-myF_married+myF_unmarried
left_line<--(myM_married+myM_unmarried)

attach(x2010)

myF_married<-X6/1000
myF_unmarried<-(X5+X7+X8)/1000
myM_married<-X2/1000
myM_unmarried<-(X1+X3+X4)/1000

left<-data.frame(myM_married,myM_unmarried)
right<-data.frame(myF_married,myF_unmarried)

source("scripts/inc_pyramid.r")

lines(right_line,myB1,type="l",col="black")
lines(left_line,myB2,type="l", col="black")

mtext("2010",3,line=0,adj=0.5,cex=1,font=3)

# Titling

mtext("Age structure and married proportion of the population in Germany",3,line=2,adj=0,cex=2.25,family="Lato Black",outer=T)
mtext("all values in thousand per year of age",3,line=-0.5,adj=0,cex=1.25,font=3,outer=T)
mtext("destatis, GENESIS-Online, Tab. 12411-0008",1,line=2,adj=1.0,cex=0.95,font=3,outer=T)
mtext("Inner highlighted areas: married",1,line=2,adj=0,cex=0.95,font=3,outer=T)
dev.off()

