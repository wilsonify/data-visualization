pdf_file <- "pdf/timeseries_missing_values.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 13, height = 9)

par(omi = c(0.65, 0.75, 0.95, 0.75), mai = c(0.9, 0.85, 0.25, 0.02), bg = "antiquewhite2", family = "Lato Light", las = 1)

# Import data and prepare chart

library(gdata)
myData <- read.xls("myData/Work_hours_data.xls", encoding = "latin1")
myColour <- rgb(139, 35, 35, maxColorValue = 255)
y <- ts(myData$v1, start = 1850, frequency = 1)

# Define chart 

plot(y, typ = "n", axes = F, xlim = c(1850, 2010), ylim = c(35, 85), xlab = "", ylab = "Hours")

# Other elements

axis(1, cex.axis = 1.25)
axis(2, cex.axis = 1.25, col = par("bg"), col.ticks = "grey81", lwd.ticks = 0.5, tck = -0.025)

myHeights <- c(40, 50, 60, 70, 80)
n <- length(myHeights)
for (i in 1:n) segments(1850, myHeights[i], 2000, myHeights[i], col = "white")
text(1905, 68, "Great Britain", col = myColour, cex = 1.5)

ptyp <- 19
source("scripts/inc_missing_values.r")

myColour <- rgb(39, 139, 16, maxColorValue = 255)
y <- ts(myData$v2, start = 1850, frequency = 1)
source("scripts/inc_missing_values.r")
text(1960, 38, "France", col = myColour, cex = 1.5)

myColour <- rgb(0, 0, 139, maxColorValue = 255)
y <- ts(myData$v3, start = 1850, frequency = 1)
source("scripts/inc_missing_values.r")
text(1872, 52, "Germany", col = myColour, cex = 1.5)

myColour <- rgb(205, 149, 12, maxColorValue = 255)
y <- ts(myData$v4, start = 1850, frequency = 1)
source("scripts/inc_missing_values.r")
text(1990, 44, "Belgium", col = myColour, cex = 1.5)

# Titling

mtext("Development of weekly working time 1850-2010", 3, line = 0.2, adj = 0, cex = 2.6, family = "Lato Black", outer = T)
mtext("Annual values ", 3, line = -2, adj = 0, cex = 2, font = 3, outer = T)
mtext("Source: Special analysis", 1, line = 0, adj = 1, cex = 1.25, font = 3, outer = T)
dev.off()
