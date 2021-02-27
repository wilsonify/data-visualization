pdf_file<-"pdf/maps_shp_osm.pdf"
cairo_pdf(bg="grey98", pdf_file,width=12,height=6)

library(maptools)
par(mfcol=c(1,2))
x <- readShapeSpatial("myData/london/greater_london_const_region.shp")
plot(x, axes=TRUE)
y <- readShapeSpatial("myData/london/london.osm-amenities.shp")
plot(y, axes=TRUE, pch=1, col=rgb(100,100,100,60,maxColorValue=255))
dev.off()
