pdf_file <- "pdf/maps_europe_choropleth_countries.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 13, height = 11)

par(omi = c(0, 0, 0, 0), mai = c(0, 0, 0, 0), family = "Lato Light", las = 1)
library(maptools)
library(RColorBrewer)
library(sp)
library(rgdal) # for spTransform
library(gdata)

# Import data and prepare chart

myData <- read.csv("myData/prop.table EVS cntr.csv", sep = ";", dec = ",")
myData[is.na(myData$ATHE), "ATHE"] <- -9
data(wrld_simpl)
w <- wrld_simpl[!(wrld_simpl@data[, "ISO2"] %in% myData$Country),]
w <- w[w@data[, "NAME"] != "Antarctica",]
m <- spTransform(w, CRS = CRS("+proj=merc"))

# Create chart

plot(m, xlim = c(-2000000, 5000000), ylim = c(4000000, 10000000), col = rgb(160, 160, 160, 100, maxColorValue = 255), border = F)

x <- readShapeSpatial("myData/NUTS-2010/NUTS_RG_60M_2010.shp", proj4string = CRS("+proj=longlat"))
y <- x[x$NUTS_ID %in% myData$Country,]
m <- spTransform(y, CRS = CRS("+proj=merc"))

myClasses <- c(-10, 0, 10, 20, 30, 50)
myColourPalette <- c("cornflowerblue", brewer.pal(4, "Reds"))

id <- m$NUTS_ID
n <- length(id)
position <- vector()
for (i in 1:n) {
  position[i] <- match(m$NUTS_ID[i], myData$Country)
}
myColour_no <- cut(myData$ATHE[position], myClasses)
levels(myColour_no) <- c("missing", "0 to 10", "10 to 20", "20 to 30", "30 to 50")
plot(m, col = myColourPalette[myColour_no], border = "white", add = T)

legend("bottomleft", levels(myColour_no), cex = 1.45, border = F, bty = "n", fill = myColourPalette, text.col = "black")

# Titling

mtext("Atheism in Europe", at = -1300000, cex = 2, adj = 0, line = -3)
mtext("", at = -1300000, cex = 2, adj = 0, line = -4.8)
mtext("Source: European Values Study", 1, at = 3200000, cex = 1.7, adj = 0, line = -2.3, font = 3)
dev.off()
