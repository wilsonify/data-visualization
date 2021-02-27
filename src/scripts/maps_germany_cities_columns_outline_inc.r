pdf_file<-"pdf/maps_germany_cities_columns_outline_inc.pdf"
cairo_pdf(bg="grey98", pdf_file,width=13,height=11)

par(omi=c(0.5,0.5,0.5,0),mai=c(0,0,0,2),lend=1)  
library(sp)
library(gdata)

# Import data and create chart

myLocations<-read.xls("myData/data_maps_germany_cities_columns.xlsx",head=T, encoding="latin1")
attach(myLocations)

load("myData/gadm2/DEU_adm1.RData")
plot(gadm,border=rgb(151,151,151,50,maxColorValue=255),lwd=0.5)

load("myData/gadm2/DEU_adm0.RData")
plot(gadm,border="darkgrey",lwd=0.95,add=T)

# Other elements

n<-nrow(myLocations)
for (i in 1:n) 
{
myBar1<-data.frame(c(long[i],long[i]),c(lat[i],lat[i]+new[i]/4000))
lines(myBar1,lwd=17,col="darkred")
text(long[i]+0.2,lat[i]+0.08+new[i]/4000,new[i],adj=1)

myBar2<-data.frame(c(long[i]+0.3,long[i]+0.3),c(lat[i],lat[i]+used[i]/4000))
lines(myBar2,lwd=17,col="darkgrey")
text(long[i]+0.2,lat[i]+0.08+used[i]/4000,used[i],adj=0)
text(long[i],lat[i]-0.09,name[i],adj=0.5)
}
legend(14,50,c("new","used"),border=F,pch=15,col=c("darkred","darkgrey"),bty="n",cex=1.3,pt.cex=4,xpd=NA,ncol=2)

# Titling

mtext("Prices for condominiums in selected cities 2011",3,line=-0.5,adj=0,cex=2.25,family="Lato Black",outer=T)
mtext("Source: real estate price index from the LBS brochure 'Markt für Wohnimmobilien 2011'",1,line=0,adj=0.9,cex=1.25,font=3)
dev.off()