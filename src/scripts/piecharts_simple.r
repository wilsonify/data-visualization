pdf_file<-"pdf/piecharts_simple.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11,height=11)

par(omi=c(2,0.5,1,0.25),mai=c(0,1.25,0.5,0.5),family="Lato Light",las=1)
library(RColorBrewer)

# Create chart

pie.myData<-c(5.8,27.0,0.2,21.1,12.8,33.1)
energytypes<-c("Nuclear energy:","Coal**:","Others***:","Gas:","Renewable\nenergies****:","Oil:")
names(pie.myData)<-paste(energytypes,pie.myData,"%",sep=" ")
pie(pie.myData,col=brewer.pal(length(pie.myData),"Reds"),border=0,cex=1.75,radius=0.9,init.angle=90)

# Titling

mtext("Global energy mix (including sea and air transport)",3,line=2,adj=0,family="Lato Black",outer=T,cex=2.5)
mtext("Shares of energy sources in the primary energy supply* in percent, 2008",3,line=-0.75,adj=0,cex=1.65,font=3,outer=T)
mtext("* Primary energy sources = primary energy production + imports - exports +/- stock changes",1,line=2,adj=0,cex=1.05,outer=T)
mtext("** Including peat",1,line=3.2,adj=0,cex=1.05,outer=T)
mtext("*** Bio matter, biodegradable waste (excluding industrial waste), water power, geothermal energy, solar, wind, and marine power.",1,line=4.4,adj=0,cex=1.05,outer=T)
mtext("**** Industrial waste and flammable waste that can serve as energy sources and are non-biodegradable",1,line=5.6,adj=0,cex=1.05,outer=T)
mtext("Source: German Federal Agency for Civic Education: keyword 'Enegiemix' [energy mix], www.bpb.de [website in German]",1,line=8,adj=1,cex=1.25,font=3,outer=T)
dev.off()
