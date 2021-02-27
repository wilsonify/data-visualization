pdf_file<-"pdf/radial_polygons_overlay.pdf"
cairo_pdf(bg="grey98", pdf_file,width=10,height=10)

par(omi=c(1,0.25,1,1),mai=c(0,2,0,0.5),cex.axis=1.5,cex.lab=1,xpd=T,family="Lato Light",las=1)
library(plotrix)

# Import data and prepare chart

myRegions<-read.xls("myData/worldenergymix.xlsx", encoding="latin1")
myC1<-rgb(80,80,80,155,maxColorValue=255)
myC2<-rgb(255,97,0,155,maxColorValue=255)
myRegions$Region<-NULL
myLabelling<-c("Oil","Coal","Gas","Renewable Energies","Nuclear\nenergy")

# Create chart

radial.plot(myRegions[2:3,],start=1,grid.left=T,labels=myLabelling,rp.type="p",main="",line.col=c(myC1,myC2),poly.col=c(myC1,myC2),show.grid=T,radial.lim=c(0,55),lwd=8)
legend("bottomleft",c("OECD","Asia"),pch=15,col=c(myC1,myC2),bty="n",cex=1.5)

# Titling

mtext(line=3,"Energy mix: OECD and Asia by comparison",cex=2.5,adj=0,family="Lato Black")
mtext(line=1,"All values in percent",cex=1.5,adj=0,font=3)
mtext(side=1,line=2,"Source: German Federal Agency for Civic Education: keyword 'Enegiemix' [energy mix], www.bpb.de [website in German]",cex=1.05,adj=1,font=3,outer=T)
dev.off()

