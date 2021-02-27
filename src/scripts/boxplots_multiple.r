pdf_file <- "pdf/boxplots_multiple.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 7, height = 9)

par(omi = c(0.35, 0.25, 0.75, 0.75), mai = c(0.95, 1.75, 0.25, 0), family = "Lato Light", las = 1)
library(RColorBrewer)
library(memisc)

# Import data and prepare chart

myDataFile <- "myData/ZA4804_v2-0-0.sav"
ZA4804 <- spss.system.file(myDataFile)
myData <- subset(ZA4804, select = c(s002evs, s003, x047d))
attach(myData)
x <- subset(myData, x047d > 0 & s002evs == "2008-2010")
attach(x)

tM <- aggregate(as.numeric(x047d), list(as.factor(s003)), median, na.rm = T)

s003f <- factor(s003, levels = tM[order(tM$x), 1])

myC1 <- brewer.pal(6, "PuRd")[2]
myC2 <- brewer.pal(6, "PuRd")[3]
myC3 <- brewer.pal(6, "PuRd")[4]
myC4 <- brewer.pal(6, "PuRd")[5]
myC5 <- brewer.pal(6, "PuRd")[6]
myColour <- c(rep(myC1, 7), rep(myC2, 10), rep(myC3, 10), rep(myC4, 10), rep(myC5, 10))
par(fg = "grey75")

# Create chart and other elements

boxplot(1000 * x047d ~ s003f, horizontal = T, ylim = c(0, 4000), border = NA, boxwex = 0.25, las = 1, col = myColour, outline = F, cex.axis = 0.7)

points(sort(1000 * tM$x, decreasing = T), length(unique(s003)):1, pch = 19, cex = 1.15, col = rev(myColour))

abline(v = 2000)
abline(h = seq(7.5, 37.5, by = 10))

par(fg = "black")
mtext("25 %", 3, at = 1300, line = -2)
mtext("75 %", 3, at = 3000, line = -2)
mtext("Median", 3, at = 2800, line = -1, cex = 0.75)

mtext("Monthly Household Income (PPP adjusted) in Euro", 1, adj = 0.5, line = 2.5)

# Titling

mtext("Income Distribution 2008-2010", 3, line = 1.6, adj = 0, cex = 1.8, family = "Lato Black", outer = T)
mtext("European Values Study", 3, line = -0.2, adj = 0, cex = 1.5, font = 3, outer = T)
mtext("Source: ZA4804 European Values Study Longitudinal Data File 1981-2008, www.gesis.org", 1, line = 0, adj = 1.0, cex = 0.95, font = 3, outer = T)
mtext("N (total): 55,635", 1, line = -2, adj = 0, cex = 1.25, font = 3, outer = T)
dev.off()

