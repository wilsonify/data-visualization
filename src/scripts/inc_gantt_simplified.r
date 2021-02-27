# inc_gantt_simplified.r

library(gdata)

cairo_pdf(bg="grey98", pdf_file,width=11.7,height=8.26)

par(lend=1,omi=c(0.25,1,1,0.25),mai=c(1,1.85,0.25,2.75),family="Lato Light",las=1)
mySchedule<-read.xls("mydata/projectplanning.xlsx", encoding="latin1")
n<-nrow(mySchedule)
myScheduleData<-subset(mySchedule,nchar(as.character(mySchedule$from))>0)
myBegin<-min(as.Date(as.matrix(myScheduleData[,c('from','to')])))
myEnd<-max(as.Date(as.matrix(myScheduleData[,c('from','to')])))
attach(mySchedule)

plot(from,1:n,type="n",axes=F,xlim=c(myBegin,myEnd),ylim=c(n,1))
for (i in 1:n)
{
if (nchar(as.character(Group[i]))>0)
{
text(myBegin-2,i,Group[i],adj=1,xpd=T,cex=1.25)
}
else if (nchar(as.character(what[i]))>0)
{
x1<-as.Date(mySchedule[i,'from'])
x2<-as.Date(mySchedule[i,'to'])
x3<-x1+((x2-x1)*mySchedule[i,'done']/100)
x<-c(x1,x2)
x_done<-c(x1,x3)
y<-c(i,i)
segments(myBegin, i, myEnd, i, col="grey")
lines(x,y,lwd=20,col=myColour[i])
points(myEnd+90, i, cex=(mySchedule[i,'Persons']*mySchedule[i,'Durance'])^0.5, pch=19, col=rgb(110, 110, 110, 50, maxColorValue=255), xpd=T)
if (x3-x1>1) lines(x_done,y,lwd=20,col=myColour_done)
if (mySchedule[i,'PAG'] > 0) 
{
x4<-as.Date(mySchedule[i,'AG_from'])
x5<-as.Date(mySchedule[i,'AG_to'])
x_ag<-c(x4,x5)
rect(x4,i-0.75,x5,i+0.75,lwd=2)
}
text(myBegin-2,i,what[i],adj=1,xpd=T,cex=0.75)
text(myEnd+25,i,paste(done[i],"%",sep=" "),adj=1,xpd=T,cex=0.75)
text(myEnd+35,i,paste(format(x1,format="%d/%m/%y"),"-",format(x2,format="%d/%m/%y"),sep=" "),adj=0,xpd=T,cex=0.75)
}
else # Milestone
{
x3<-as.Date(mySchedule[i,'when'])
myHalf<-(myEnd-myBegin)/2
if (x3-x1<myHalf)
{
points(as.Date(mySchedule[i,'when']),i,pch=18,cex=1.25,col="red")
text(as.Date(mySchedule[i,'when'])+5,i,Milestone[i],adj=0,xpd=T,cex=0.75)
} else
{
points(as.Date(mySchedule[i,'when']),i,pch=18,cex=1.25,col="red")
text(as.Date(mySchedule[i,'when'])-5,i,Milestone[i],adj=1,xpd=T,cex=0.75)
}
}
}
axis(3,at=c(myBegin,myEnd),labels=c(format(myBegin,format="%d/%m/%Y"),format(myEnd,format="%d/%m/%Y")))
myToday<-as.Date("15.08.2012", "%d.%m.%Y")
abline(v=myToday)

mtext("today",1,line=0,at=myToday)

# Titling

mtext("Project plan",3,line=2,adj=0,cex=2.25,family="Lato Black",outer=T)
mtext(paste("planning status: ",format(myToday,format="%d/%m/%y"),sep=""),1,line=4,at=myEnd+20,cex=1.25,font=3)
rect(myBegin-36, n+5, myBegin, n+4, xpd=T,lwd=2)
text(myBegin-35, n+4.5, "Box: Client",xpd=T, adj=0)
