pdf_file<-"pdf/scatterplots_three_points.pdf"
cairo_pdf(bg="grey98", pdf_file,width=14,height=9)

par(mai=c(2,1,1,1),omi=c(0,0,0,0),xpd=T,family="Lato Light",las=1)

# Define data and prepare chart

names<-c("BMW:\n44,6 Bn.","Daimler:\n45,5 Bn.","","Facebook:\n75-100 Bn.")
myValue<-c(44.6,45.5,100,75)
myRevenue<-c(60.5,97.8,2.5,2.5)
myProfit<-c(4.8,4.7,1,1)

myC1<-rgb(80,80,80,maxColorValue=255)
myC2<-rgb(255,97,0,maxColorValue=255)
myC3<-"grey"
myC4<-rgb(58,87,151,maxColorValue=255)

# Define chart and other elements

plot(myRevenue,myProfit,axes=F,type="n",xlab="Revenue (years)",ylab="Profit (years)",xlim=c(-20,100),ylim=c(-1,6),cex.lab=1.5)
for (i in 1:3) 
{
arrows(myRevenue[i],-1,myRevenue[i],myProfit[i],length=0.10,lty="dotted",angle=10,code=0,lwd=1,col="grey70")
arrows(-20,myProfit[i],myRevenue[i],myProfit[i],length=0.10,lty="dotted",angle=10,code=0,lwd=1,col="grey70")
}
points(myRevenue,myProfit,pch=19,cex=myValue/2.6,col=c(myC1,myC2,myC3,myC4))
text(myRevenue,myProfit,names,col="white",cex=1.3)
axis(1,at=c(2.5,60.5,97.8),labels=c("2.5*","60.5","97.8"),cex.axis=1.25)
axis(2,at=c(1,4.8),labels=c("1.0","4.8\n4.7"),cex.axis=1.25)
text(-25.5,5.08,"**")
text(-26.5,1.08,"*")

# Titling

mtext(line=1,"Facebook, BMW and Daimler by comparison",cex=3.5,adj=0,family="Lato Black")
mtext(line=-1,"Profit, revenue, stock market value (circle size, status: 01.30.2012)",cex=1.75,adj=0,font=3)
mtext(line=-3,"All values in Bn. Euro",cex=1.75,adj=0,font=3)
mtext(side=1,line=6.5,"Source www.spiegel.de",cex=1.75,adj=1,font=3)
mtext(side=1,line=4.5,"* Estimated",cex=1.75,adj=0)
mtext(side=1,line=6.5,"** Result before tax",cex=1.75,adj=0)
dev.off()