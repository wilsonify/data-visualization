pdf_file <- "pdf/scatterplots_symbols.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 7.5, height = 12)

par(omi = c(0.5, 0.5, 0, 0), mai = c(0.5, 1.25, 0, 0.25), family = "Lato Light", las = 1)
library(maptools)

# Import data and prepare chart

library(gdata)
myData <- read.xls("myData/Intra-StateWarData_v4.1.xlsx", encoding = "latin1")
mySelection <- subset(myData, myData$StartYear1 >= 1995 &
  myData$SideADeaths > 0 &
  myData$SideADeaths < 2000 &
  myData$SideBDeaths > 0 &
  myData$SideBDeaths < 4000)
attach(mySelection)

myColour <- "darkred"
myN <- nrow(mySelection)
h <- rep(0, myN)
v <- rep(0, myN)
myOffset <- cbind(h, v)

# mySelection[, c("WarName", "StartYear1", "SideADeaths", "SideBDeaths")]
myOffset[1, "h"] <- -400
myOffset[5, "h"] <- 232
myOffset[4, "h"] <- -275
myOffset[2, "h"] <- 270; myOffset[2, "v"] <- 100
myOffset[13, "h"] <- -275
myOffset[12, "h"] <- -300

myX <- as.numeric(SideADeaths)
myY <- as.numeric(SideBDeaths)

# Define chart and other elements

plot(myX, myY, typ = "n", xlab = "", ylab = "", axes = F, xlim = c(0, 2000), ylim = c(0, 4000))
axis(1, col = par("bg"), col.ticks = "grey81", lwd.ticks = 0.5, tck = -0.025)
axis(2, col = par("bg"), col.ticks = "grey81", lwd.ticks = 0.5, tck = -0.025)
text(myX + 130 + myOffset[, "h"], myY - 180 + myOffset[, "v"], paste(WarName, StartYear1, sep = " "), cex = 0.8, xpd = T, col = "grey")

mtext(side = 1, "Side A Deaths (Authorities)", adj = 0.5, line = 3)
mtext(side = 2, "Side B Deaths (Rebels)", las = 0, adj = 0.5, line = 4)

# Titling

mtext("Deaths by Intra-state Wars", 3, adj = 1, line = -3, cex = 2.1, family = "Lato Black")
mtext("1997-2007", 3, adj = 1, line = -5, cex = 1.4, font = 3)
mtext("Source: correlatesofwar.org", 1, line = 1, adj = 0, cex = 0.95, outer = T, font = 3)

# Other elements of chart

par(family = "Datendesign")
text(myX, myY, "b", col = myColour, cex = 5, xpd = T)
dev.off()
