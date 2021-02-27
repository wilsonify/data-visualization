pdf_file <- "pdf/timeseries_areas_between.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 11.69, height = 8.27)

par(mai = c(1, 1, 0.5, 0.5), omi = c(0, 0.5, 1, 0), family = "Lato Light", las = 1)

# Import data and prepare chart

library(gdata)
rs <- read.xls("myData/B1_01.xls", 1, header = F, encoding = "latin1")
myColour1_150 <- rgb(68, 90, 111, 150, maxColorValue = 255)
myColour1_50 <- rgb(68, 90, 111, 50, maxColorValue = 255)
myColour2_150 <- rgb(255, 97, 0, 150, maxColorValue = 255)
myColour2_50 <- rgb(255, 97, 0, 50, maxColorValue = 255)
attach(rs)

# Define graphic and other elements

plot(V1, V11, axes = F, type = "n", xlab = "", ylab = "Number (per 100 000 population)", cex.lab = 1.5, xlim = c(1820, 2020), ylim = c(10, 40), xpd = T)
axis(1, at = c(1820, 1870, 1920, 1970, 2010))
axis(2, at = c(10, 15, 20, 25, 30, 35, 40), col = par("bg"), col.ticks = "grey81", lwd.ticks = 0.5, tck = -0.025)
lines(V1, V11, type = "l", col = myColour1_150, lwd = 3, xpd = T)
lines(V1, V12, type = "l", col = myColour2_150, lwd = 3)
text(1910, 35, "Live births", adj = 0, cex = 1.5, col = myColour1_150)
text(1850, 22, "Deaths", adj = 0, cex = 1.5, col = myColour2_150)
myBegin <- c(1817, 1915, 1919, 1972); ende <- c(1914, 1918, 1971, 2000)
myColour <- c(myColour1_50, myColour2_50, myColour1_50, myColour2_50)
for (i in 1:length(myBegin))
{
  mySubset <- subset(rs, V1 >= myBegin[i] & V1 <= ende[i])
  attach(mySubset)
  xx <- c(mySubset$V1, rev(mySubset$V1)); yy <- c(mySubset$V11, rev(mySubset$V12))
  polygon(xx, yy, col = myColour[i], border = F)
}

# Titling

mtext("Live births and deaths in Germany 1820-2001", 3, line = 1.5, adj = 0, family = "Lato Black", cex = 2.2, outer = T)
mtext("Annual values", 3, line = -0.75, adj = 0, font = 3, cex = 1.8, outer = T)
mtext("Source: gesis.org/histat", 1, line = 3, adj = 1, cex = 1.2, font = 3)
dev.off()
