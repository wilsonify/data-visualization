# inc_forecast_interval_05_index.r
myLand<-subset(UNPop,UNPop$Country==mySelection[i] & UNPop$Variant=="Medium variant")
myPrognoses<-subset(UNPop,UNPop$Country == mySelection[i] & Year >= 2010)
myPrognosis_L<-subset(myPrognoses,myPrognoses$Variant=="Low variant")$Value/1000
myPrognosis_M<-subset(myPrognoses,myPrognoses$Variant=="Medium variant")$Value/1000
myPrognosis_H<-subset(myPrognoses,myPrognoses$Variant=="High variant")$Value/1000
myYears<-seq(2010,2100,by=5)
attach(myLand)
myBase<-(Value[13]/1000)

plot(axes=F,type="n",xlab="",ylab="",Year,Value/1000,ylim=c(ymin[i],ymax[i]))
py<-c(0,100,200,300,400,500)
abline(h=py[2:6], col="lightgray",lty="dotted")
axis(1,tck=-0.01,col="grey",at=c(1950,2010,2100),cex.axis=1.2) 
py<-c(0,100,200,300,400,500)
if (mySelection[i]=="World")
{
axis(2,tck=-0.01,col="grey",at=py,labels=format(py,big.mark="."),cex.axis=1.2) 
}
xx<-c(myYears,rev(myYears))
yy<-c(100*myPrognosis_H/basis,rev(100*myPrognosis_L/basis))

polygon(xx,yy,col=rgb(192,192,192,maxColorValue=255),border=F)

lines(Year,100*(Value/1000)/basis,col="grey",lwd=2)
lines(myYears,100*myPrognosis_H/basis,col="black",lwd=2)
lines(myYears,100*myPrognosis_L/basis,col="orange",lwd=2)
lines(myYears,100*myPrognosis_M/basis,col="white",lwd=2)


