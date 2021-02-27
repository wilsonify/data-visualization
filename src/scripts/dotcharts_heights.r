pdf_file<-"pdf/dotcharts_heights.pdf"
cairo_pdf(bg="grey98", pdf_file,width=8,height=9)

par(omi=c(0.5,0.5,1.1,0.5),mai=c(0,2,0,0.5),family="Lato Light",las=1)
myColour_dotchart<-rgb(55,55,55,maxColorValue=255)
par(omi=c(0,0,1,0),mai=c(0.75,0,0,1)) 
myPersons<-read.xls("myData/persons.xlsx", encoding="latin1")
mySelection<-subset(myPersons,s=="m")
attach(mySelection)
sort.mySelection<-mySelection[order(h),]
attach(sort.mySelection)
group3<-factor(group3)
dotchart(h,labels=name,cex=.6,groups=group3,xlab="cm",gcolor=myColour_dotchart,color=markings)

# Titling

mtext("Body height of selected celebrities",3,adj=0,line=1,cex=1.5,col="black")
dev.off() 
