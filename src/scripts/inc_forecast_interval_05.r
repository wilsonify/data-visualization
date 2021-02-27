# inc_forecast_interval_05.r
myCountry<-subset(UNPop,UNPop$Country==mySelection[i] & UNPop$Variant=="Medium variant")
myPrognoses<-subset(UNPop,UNPop$Country == mySelection[i] & Year >= 2010)
myPrognosis_L<-subset(myPrognoses,myPrognoses$Variant=="Low variant")$Value/1000
myPrognosis_M<-subset(myPrognoses,myPrognoses$Variant=="Medium variant")$Value/1000
myPrognosis_H<-subset(myPrognoses,myPrognoses$Variant=="High variant")$Value/1000
myYears<-seq(2010,2100,by=5)
attach(myCountry)

plot(axes=F,type="n",xlab="",ylab="",Year,Value/1000,ylim=c(ymin[[i]],ymax[[i]]))
axis(1,tck=-0.01,col="grey",at=c(1950,2010,2100),cex.axis=1.2) 
axis(2,tck=-0.01,col="grey",at=py<-pretty(c(myPrognosis_L,Value/1000,myPrognosis_H)),labels=format(py,big.mark=","),cex.axis=1.2) 

xx<-c(myYears,rev(myYears))
yy<-c(myPrognosis_H,rev(myPrognosis_L))
polygon(xx,yy,col=rgb(68,90,111,50,maxColorValue=255),border=F)

lines(Year,Value/1000,col="grey",lwd=2)
lines(myYears,myPrognosis_H,col="black",lwd=2)
lines(myYears,myPrognosis_L,col="orange",lwd=2)
lines(myYears,myPrognosis_M,col="white",lwd=2)