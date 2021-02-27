# inc_plot_maps_europe_choropleth_countries.r
data(wrld_simpl)
w <- wrld_simpl[wrld_simpl@data[, "NAME"] != "Antarctica",]
m <- spTransform(w, CRS = CRS("+proj=merc"))

plot(m, xlim = c(-2000000, 5000000), ylim = c(4000000, 10000000), col = rgb(120, 120, 120, maxColorValue = 255), border = F)

x <- readShapeSpatial("myData/NUTS-2006/NUTS_RG_03M_2006.shp", proj4string = CRS("+proj=longlat"))

xls <- read.xls("myData/eb_nuts.xlsx", encoding = "latin1")

y <- x[x$NUTS_ID %in% xls$nuts_id,]

m <- spTransform(y, CRS = CRS("+proj=merc"))

source("scripts/inc_datadesign_dbconnect.r")
sql <- paste("select ", mySelection, " selection from v_za4972_countries", sep = "")
myDataset <- dbGetQuery(con, sql)
attach(myDataset)

myNo <- m$NUTS_ID
myDataset$ref_NUTS_ID <- xls$nuts_id

position <- vector()
for (i in 1:30) {
  position[i] <- match(m$NUTS_ID[i], myDataset$ref_NUTS_ID)
}

myColour_no <- cut(myDataset$selection[position], myClasses)
levels(myColour_no) <- myClass_des

plot(m, col = myColourPalette[myColour_no], border = "white", add = T)
legend("right", levels(myColour_no), cex = 0.95, border = F, bty = "n", fill = myColourPalette, text.col = "white")

