pdf_file <- "pdf/pyramids_aggregated.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 8, height = 8)

par(mai = c(0.2, 0.25, 0.8, 0.25), omi = c(0.75, 0.2, 0.85, 0.2), cex = 0.75,
    family = "Lato Light", las = 1)

# Import data and prepare chart

x <- read.xls("myData/popclass.xlsx", encoding = "latin1")

right <- t(as.matrix(data.frame(800, x$F)))
left <- -t(as.matrix(data.frame(800, x$M)))

myColour_right <- c(par("bg"), rgb(255, 0, 210, 150, maxColorValue = 255))
myColour_left <- c(par("bg"), rgb(191, 239, 255, maxColorValue = 255))

# Create charts and other elements

b1 <- barplot(right, axes = F, horiz = T, axis.lty = 0, border = NA, col = myColour_right, xlim = c(-8000, 8000))
barplot(left, axes = F, horiz = T, axis.lty = 0, border = NA, col = myColour_left, xlim = c(-7500, 7500), add = T)

abline(v = seq(0, 6000, by = 2000) + 800, col = "darkgrey", lty = 3)
abline(v = seq(-6000, 0, by = 2000) - 800, col = "darkgrey", lty = 3)

mtext(format(seq(0, 6000, by = 2000), big.mark = "."), at = seq(0, 6000, by = 2000) + 800, 1, line = 0, cex = 0.95)
mtext(format(abs(seq(-6000, 0, by = 2000)), big.mark = "."), at = seq(-6000, 0, by = 2000) - 800, 1, line = 0, cex = 0.95)
text(0, b1, x$des, cex = 1.25, font = 3)

mtext("Men", 3, line = 1, adj = 0.25, cex = 1.5, col = "darkgrey")
mtext("Women", 3, line = 1, adj = 0.75, cex = 1.5, col = "darkgrey")

# Titling

mtext("Age structure of the population in Germany", 3, line = 2, adj = 0, cex = 1.75, family = "Lato Black", outer = T)
mtext("Values in thousand per year of age", 3, line = -0.5, adj = 0, cex = 1.25, font = 3, outer = T)
mtext("Source: www.destatis.de/bevoelkerungspyramide, own calculations", 1, line = 2, adj = 1.0, cex = 0.95, font = 3, outer = T)
mtext("...", 1, line = 2, adj = 0, cex = 0.95, font = 3, outer = T)
dev.off()
