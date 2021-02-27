pdf_file<-"pdf/tablecharts_symbol_signs.pdf"
cairo_pdf(bg="grey98",pdf_file,width=9,height=4)

par(omi=c(0.5,0.25,0.5,0.25),mai=c(0,0,0,0),family="Lato Light",cex=1.2)

# Import data

library(gdata)
myData<-read.xls("myData/leaking_pipeline.xlsx", encoding="latin1")
attach(myData)

# Create graphics

b1<-barplot(Men+75,horiz=T,xlim=c(-175,175),border=NA,col="gainsboro",axes=F)
barplot(-Women-75,horiz=T,border=NA,add=T,col="gainsboro",axes=F)
barplot(rep(75,5),horiz=T,border=par("bg"),add=T,col=par("bg"),axes=F)
barplot(rep(-75,5),horiz=T,border=par("bg"),add=T,col=par("bg"),axes=F)
abline(v=seq(-175,195,by=10),col=par("bg"))
text(0,b1,Level)

# Titling

mtext("The 'Leaky Pipeline' 2005",3,line=0.25,adj=0,cex=1.75,family="Lato Black",outer=T)
mtext("Source: Wissenschaftsrat, Drucksache Drs. 8036-07.",1,line=0.25,adj=1.0,cex=0.65,outer=T,font=3)

# Symbols

par(family="Symbol Signs")
for (i in 1:5) 
{
MyMen_Number<-Men[i]
text(seq(10,10*round(MyMen_Number/10),by=10)+73.5,rep(b1[i],5),rep("M",MyMen_Number),
	cex=2.75,col="cornflowerblue")
MyWomen_Number<-Women[i]
text(-seq(10,10*round(MyWomen_Number/10),by=10)-68,rep(b1[i],5),rep("F",MyWomen_Number),
	cex=2.75,col="deeppink")
}

par(family="Lato Bold")
text(55,b1,paste(Men, "%", sep=" "))
text(-55,b1,paste(Women, "%", sep=" "))
dev.off()
