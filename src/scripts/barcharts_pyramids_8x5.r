pdf_file<-"pdf/barcharts_pyramids_8x5.pdf"
cairo_pdf(bg="grey98", pdf_file,width=8.27,height=11.7)

par(omi=c(0.25,0.1,1.0,0.1),mai=c(0.1,0.1,0.55,0.1),mfrow=c(8,5),family="Lato Light",las=1) 
library(Hmisc)

# Import data and prepare chart

ISSP<-spss.get("myData/ZA5400_v3-0-0.sav",use.value.labels=T)
attach(ISSP)
countries<-as.data.frame(table(V5))
country_list<-countries$V5[1:45]

for (i in 1:length(country_list))
{
land<-subset(ISSP,ISSP$V5==country_list[i])
attach(land)
y<-as.data.frame(prop.table(table(V44))*100)
if (!(is.na(y[1,2])))
{
left<--(y$Freq/2)
right<-y$Freq/2

# Create charts

barplot(left,horiz=T,xlim=c(-30,30),border="orange",col="orange",
	main=country_list[i],cex.axis=0.6,axes=F)
barplot(right,horiz=T,add=T,border="orange",col="orange",cex.axis=0.6,axes=F)
segments(-25,-0, 25,0)
}
}

# Legend

myDes<-c("Bottom,Lowest,01","",".","",".","",".","",""," Top,Highest,10")
n<-length(myDes)
plot(0:n,type="n",axes=F,xlab="",ylab="", xlim=c(-25,25),ylim=c(0,11)) #
for (i in 1:n) text(0,i+0.5,myDes[i],cex=0.9,xpd=T)
segments(-25,-0, 25,0)
text(0,-1.5, "50%", xpd=T)

# Titling

mtext("International Social Survey Programme: Social Inequality IV",3,line=2.2,adj=0,cex=1.4,family="Lato Black",outer=T)
mtext("Q10a: Groups tending towards top and bottom. Where would you put yourself now on this scale?",3,line=0,adj=0,cex=1.1,outer=T)
mtext("Source: ZA5400: ISSP 2009",1,line=0,adj=1,cex=0.7,outer=T,font=3)
dev.off()
