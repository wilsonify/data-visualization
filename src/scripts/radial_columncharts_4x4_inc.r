pdf_file<-"pdf/radial_columncharts_4x4_inc.pdf"
cairo_pdf(bg=rgb(0.3137,0.3137,0.3137), pdf_file,width=18,height=18)

par(omi=c(0,0,0,0),family="Lato Light",mfcol=c(4,4))
library(plotrix)
mySelection<-c("AUS","CAN","CZE","FRA","GRC","DEU","IRL","ITA","JPN","KOR", "NOR","POL","SWE","TUR","GBR","USA")
source("scripts/inc_data_radial_columncharts.r")
source("scripts/inc_colours_radial_columncharts.r")
myGridColour<-par("bg")
myRadial_mar<-c(0,0,2,0)
myMLine<-0
myNames<-rep("", (length(myData)-2))
source("scripts/inc_plot_radial_columncharts.r")
dev.off()