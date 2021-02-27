pdf_file <- "pdf/maps_germany_shp_onb_zipcode.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 16, height = 9)

par(mar = c(0, 0, 0, 0), oma = c(1, 1, 1, 0), mfcol = c(1, 2), family = "Lato Light", las = 1)
library(maptools)
library(rgdal)
library(RColorBrewer)

# Import data and prepare chart

myX <- readShapeSpatial("myData/ONB_Grenzen/ONB_Grenzen.shp")
myColour <- sample(1:7, length(myX), replace = T)

# Create chart and other elements

plot(myX, col = brewer.pal(7, "Greens")[myColour], border = F)
mtext(paste("N=", format(length(myX), big.mark = ","), sep = ""), side = 3, line = -6, adj = 0, cex = 1.7)
mtext("Local Network Area \nborders", side = 3, line = -4, adj = 0, cex = 1.7)
mtext("Source: http://bundesnetzagentur.de", side = 1, line = -1, adj = 0, cex = 1.3)

# Import data and prepare chart

myY <- readShapeSpatial("myData/PLZ/post_pl.shp", proj4string = CRS("+proj=longlat"))
myX <- spTransform(myY, CRS = CRS("+proj=merc"))
myColour <- sample(1:7, length(myX), replace = T)

# Create chart and other elements

plot(myX, col = brewer.pal(7, "Oranges")[myColour], border = F)
mtext(paste("N=", format(length(myX), big.mark = ","), sep = ""), side = 3, line = -6, adj = 0, cex = 1.7)

# Titling

mtext("Zip Code \nborders", side = 3, line = -4, adj = 0, cex = 1.7)
mtext("Source: http://arnulf.us/PLZ", side = 1, line = -1, adj = 0, cex = 1.3)
dev.off()