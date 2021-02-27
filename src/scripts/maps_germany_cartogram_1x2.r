pdf_file <- "pdf/maps_germany_cartogram_1x2.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 12, height = 6)
par(omi = c(0.15, 0.25, 0.55, 0.15), mai = c(0, 0, 0, 1), family = "Lato Light", mfcol = c(1, 2))

library(maptools)
library(gdata)
library(cartogram)
library(RColorBrewer)

# Prepare chart and import data

nuts2013 <- readShapeSpatial("myData/NUTS_2013_03M_SH/data/NUTS_RG_03M_2013.shp", proj4string = CRS("+proj=longlat"))
m <- spTransform(nuts2013, CRS = CRS("+proj=merc"))
DE <- m[substr(m$NUTS_ID, 1, 2) == "DE" & m$STAT_LEVL_ == 1,]

bl <- read.xls("myData/bl.xlsx")
DE@data$BIP <- bl$BIP
DE@data$AUS <- bl$AUS

westfarben <- brewer.pal(5, "PuRd")[2:5]
ostfarben <- brewer.pal(5, "PuBu")[2:5]

farb_nr <- cut(DE$BIP, c(0, 100000, 200000, 300000, 650000))
levels(farb_nr) <- c("up to 100 m €", "100 - 200 m €", "200 - 300 m €", "over 300 m €")

DE@data$farb_nr <- farb_nr
ostwest <- c(2, 1, 1, 1, 1, 0, 2, 1, 1, 1, 1, 1, 2, 2, 1, 2)
DE@data$ostwest <- ostwest
DEWest <- DE[DE$ostwest == 1,]
DEOst <- DE[DE$ostwest == 2,]

# Create chart

plot(DEWest, col = westfarben[DEWest$farb_nr], border = "white", new = T)
plot(DEOst, col = ostfarben[DEOst$farb_nr], border = "white", add = T)
plot(DE[DE$ostwest == 0,], col = "grey", border = "white", add = T)

legend(1580000, 6400000, xpd = T, c("", "", "", ""), cex = 0.95, border = FALSE, bty = "n", fill = westfarben)
legend(1620000, 6400000, xpd = T, levels(farb_nr), cex = 0.95, border = FALSE, bty = "n", fill = c(ostfarben[1], ostfarben[2], "white", "white"), text.col = "darkgrey")

DEC <- cartogram(DE, "BIP", 9)
DECWest <- DEC[DEC$ostwest == 1,]
DECOst <- DEC[DEC$ostwest == 2,]

plot(DECWest, col = westfarben[DECWest$farb_nr], border = "white")
plot(DECOst, col = ostfarben[DECOst$farb_nr], border = "white", add = T)
plot(DEC[DEC$ostwest == 0,], col = "grey", border = "white", add = T)

# Titling

mtext("Gross domestic product of the federal states 2015", line = 0, adj = 0, cex = 2.2, family = "Lato Black", outer = T)
mtext("Source: de.statista.com", side = 1, line = -1, adj = 1, cex = 0.9, font = 3, outer = T)
dev.off()