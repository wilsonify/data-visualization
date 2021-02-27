pdf_file<-"pdf/histograms_7x7.pdf"
cairo_pdf(bg="grey98", pdf_file,width=25,height=25)

par(omi=c(2,0.75,2.5,0.25),mai=c(0,0,0,0),mfrow=c(7,7),family="Lato Light")  
library(memisc)

# Import data and prepare chart

ZA4804<-spss.system.file("mydata/ZA4804_v3-0-0.sav")

myData<-subset(ZA4804,select=c(s002evs,s003,x047d))
attach(myData)
t<-subset(myData,x047d>0 & s002evs=="2008-2010")

tMedians<-aggregate(as.numeric(x047d),list(as.factor(s003)),median,na.rm =T)

tCountries<-tMedians[order(tMedians$x),1]

# Create chart

attach(t)
for (i in 1:(length(tCountries)-2))
{
Country<-subset(t,s003==tCountries[i])
hist(Country$x047d,main="",axes=F,xlab="",ylab="",xlim=c(0,8),ylim=c(0,1000),border="white",col="red",breaks=seq(from=-2,to=16,by=0.5))
text(4,900,tCountries[i],cex=3.0)
box(lty='dotdash',col='grey')
if (i==43) axis(1,cex.axis=3,at=c(0,8),labels=c("Less\nthan €150","€8,000"),mgp=c(0,8,1))
}

# Titling

mtext("European Value Study 2008-2010: Income Distribution of 47 Countries",3,line=10,adj=0,cex=3.8,family="Lato Black",outer=T)
mtext("Monthly Household Income (PPP Adjusted) in Euro",3,line=3,adj=0,cex=3.5,font=3,outer=T)
mtext("Source: ZA4804 European Values Study Longitudinal Data File 1981-2008, www.gesis.org",1,line=7,adj=1.0,cex=2,font=3,outer=T)
dev.off()
