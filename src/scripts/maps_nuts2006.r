pdf_file <- "pdf/maps_nuts2006.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 10, height = 7)

par(omi = c(0, 0, 0, 0), mai = c(0, 0, 0, 0), family = "Lato Light", las = 1)
library(maptools)
library(rgdal)
library(RColorBrewer)

# Import data and prepare chart

myX <- readShapeSpatial("myData/NUTS-2006/NUTS_RG_03M_2006.shp", proj4string = CRS("+proj=longlat"))
m <- spTransform(myX, CRS = CRS("+proj=merc"))
colour <- sample(1:7, length(m), replace = T)
m$colour <- colour
palette <- brewer.pal(7, "Purples")

# Create chart

plot(m, xlim = c(-1000000, 3000000), ylim = c(4000000, 10000000), border = F, col = palette[m$colour])
dev.off()
