pdf_file<-"pdf/tablecharts_treemap.pdf"
cairo_pdf(bg="grey98", pdf_file,width=11.69,height=7.5)

# par(omi=c(0.65,0.25,1.25,0.75),mai=c(0.3,2,0.35,0),family="Lato Light",las=1)  
par(omi=c(0.55,0.25,1.15,0.75),family="Lato Light",las=1)  
library(treemap)
library(gdata)


# Import data

federalbudget<-read.xls("mydata/federalbudget.xlsx",sheet=1, encoding="latin1")

#  Create chart

plot.new()
treemap(federalbudget,title="",index="Title",type="index",vSize="Expenditures",palette="YlOrRd",aspRatio=1.9,inflate.labels=T)

# Titling

mtext("Federal Budget 2011",3,line=3.8,adj=0,cex=2.2,family="Lato Black",outer=T)
mtext("Shares of Expenditure",3,line=2.3,adj=0,cex=1.5,outer=T,font=3)
mtext("Source: bund.offenerhaushalt.de",1,line=1,adj=1.0,cex=0.95,outer=T,font=3)
dev.off()