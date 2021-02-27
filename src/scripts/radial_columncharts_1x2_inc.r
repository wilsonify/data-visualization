pdf_file<-"pdf/radial_columncharts_1x2_inc.pdf"
cairo_pdf(bg=rgb(0.3137,0.3137,0.3137),pdf_file,width=14,height=7)

par(omi=c(0,0,0,0),family="Lato Regular",mfcol=c(1,2),cex.axis=1.25, col.lab=par("bg"))
library(plotrix)
library(gdata)

mySelection<-c("DEU","GRC")
source("scripts/inc_data_radial_columncharts.r")
source("scripts/inc_colours_radial_columncharts.r")
myGridColour<-"grey"
myRadial_mar<-c(4,0,6,0)
myMLine<-4
myNames<-c(
	"Rooms",
	"Dwelling",
	"Income",
	"Wealth",
	"    Employ-\nment",
 	"Unemploy-    \nment", 
	"Network    ",
	"Educational",
	"Reading",
	"Air",
	"Voter",
	"Consultation",
	"Life",
	"Health",
	"Satis-\nfaction",
	"Homi-\ncide",
	"Assault",
	"Long",
	"Children","Time")
source("scripts/inc_plot_radial_columncharts.r")
dev.off()
