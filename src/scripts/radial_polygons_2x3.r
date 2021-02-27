pdf_file<-"pdf/radial_polygons_2x3.pdf"
cairo_pdf(bg="grey98", pdf_file,width=12,height=12)

par(mfcol=c(2,3),omi=c(1,0.5,1,0.5),mai=c(0,0,0,0),cex.axis=0.9,cex.lab=1,xpd=T,col.axis="green",col.main="red",family="Lato Light",las=1)

library(plotrix)
library(gdata)

# Import data and prepare chart

myRegions<-read.xls("myData/worldenergymix.xlsx", encoding="latin1")
row.names(myRegions)<-myRegions$Region
myRegions$Region<-NULL
myLabelling<-c("Oil","Coal","Gas","Renewable E.","Nuclear Energy")

myRegions<-myRegions[, c(1,2,3,4,5)]
myLabelling<-myLabelling[c(1,2,3,4,5)]

# Create charts

for (i in 2:nrow(myRegions))
{
radial.plot(rep(100/length(myRegions),length(myRegions)),labels=myLabelling,rp.type="p",main="",line.col="grey",show.grid=T,show.grid.labels=F,radial.lim=c(0,55),poly.col="grey")
radial.plot(myRegions[i,],labels="",rp.type="p",main="",line.col="red",show.grid=F,radial.lim=c(0,55),poly.col="red",add=T)
mtext(row.names(myRegions)[i],line=2,family="Lato Black")
}

# Titling

mtext("World energy mix",line=2,cex=3,family="Lato Black",outer=T,adj=0)
mtext(line=-1,"Shares of different energy types in total energy use",cex=1.5,font=3,outer=T,adj=0)
mtext(side=1, "Source: German Federal Agency for Civic Education: keyword 'Enegiemix' [energy mix], www.bpb.de [website in German]",line=2,cex=1.3,font=3,outer=T,adj=1)
dev.off()
