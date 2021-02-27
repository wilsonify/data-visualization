pdf_file <- "pdf/boxplots_multiple_compare.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 7, height = 10)

par(omi = c(0.35, 0.25, 0.75, 0.25), mai = c(0.75, 1.75, 0.55, 0), family = "Lato Light", las = 1)
library(memisc)

# Import data and prepare chart

myDatafile <- "myData/ZA4804_v2-0-0.sav"
ZA4804 <- spss.system.file(myDatafile)
myData <- subset(ZA4804, select = c(s002evs, s003, x047d))
attach(myData)
t1 <- subset(myData, x047d > 0 & s002evs == "1999-2001")
t1_countries <- unique(t1$s003)
t2 <- subset(myData, x047d > 0 &
  s002evs == "2008-2010" &
  is.element(s003, t1_countries))

attach(t1)
a1 <- aggregate(as.numeric(x047d), list(as.factor(s003)), quantile, na.rm = T)

attach(t2)
a2 <- aggregate(as.numeric(x047d), list(as.factor(s003)), quantile, na.rm = T)

a1.sorted <- a1[order(a1$x[, 3]),]

# Define chart

plot(1:1, type = "n", xlim = c(0, 4.25), ylim = c(0.5, 51.5), axes = F, xlab = "", ylab = "", yaxs = "i")

# Other elements

abline(v = c(0, 1, 2, 3, 4), lty = "dotted", col = "grey70")

myC1 <- "gray55"
myC2 <- "deeppink"
myBckgrnd <- rgb(191, 239, 255, 70, maxColorValue = 255)

for (i in 1:25)
{
  rect(0, 2 * i - 0.9, 4.25, 2 * i + 0.9, col = myBckgrnd, border = NA)
  segments(a1.sorted$x[i, 2], 2 * i - 0.2, a1.sorted$x[i, 4], 2 * i - 0.2, lwd = 4, col = myC1)
  segments(a2$x[a2$Group.1 == a1.sorted$Group.1[i], 2], 2 * i + 0.2, a2$x[a2$Group.1 == a1.sorted$Group.1[i], 4], 2 * i + 0.2, col = myC2, lwd = 4)

  par(family = "Symbola")
  text(a1.sorted$x[i, 3], 2 * i - 0.4, "▼", col = myC1, cex = 0.8)
  text(a2$x[a2$Group.1 == a1.sorted$Group.1[i], 3], 2 * i + 0.4, "▲", col = myC2, cex = 0.8)

  par(family = "Lato Light")
  text(-0.1, 2 * i, a1.sorted$Group.1[i], adj = 1, xpd = T)
}
mtext(c(0, "1.000", "2.000", "3.000", "4.000"), 1, at = c(0:4), cex = 0.85)
mtext("Monthly Household Income (PPP adjusted) in Euro", 1, adj = 0.5, line = 1.5)

# Titling

mtext("Income Distribution 1999 and 2008", 3, line = 1.6, adj = 0, cex = 1.8, family = "Lato Black", outer = T)
mtext("European Values Study", 3, line = -0.2, adj = 0, cex = 1.5, font = 3, outer = T)
mtext("Source: ZA4804 European Values Study Longitudinal Data File 1981-2008, www.gesis.org", 1, line = 0, adj = 1.0, cex = 0.95, font = 3, outer = T)

# Legend

par(new = T, omi = c(0, 0, 0, 0), mai = c(8.5, 5.5, 0.5, 0.55))
plot(0:1, xlim = c(0, 1), ylim = c(0, 1), type = "n", axes = F, xlab = "", ylab = "")
segments(0, 0.42, 1, 0.42, col = myC1, xpd = T, lwd = 4)
segments(0, 0.57, 1, 0.58, col = myC2, xpd = T, lwd = 4)
text(0, 0.75, "25%", adj = 0.5, cex = 0.7, xpd = T, font = 3)
text(1, 0.75, "75%", adj = 0.5, cex = 0.7, xpd = T, font = 3)
text(0.5, 0.75, "Median", adj = 0.5, cex = 0.7, font = 3)
text(-0.1, 0.42, "1999-2001", adj = 1, cex = 0.65, xpd = T, font = 3)
text(-0.1, 0.58, "2008-2010", adj = 1, cex = 0.65, xpd = T, font = 3)
par(family = "Symbola")
text(0.5, 0.6, "▲", col = myC2, cex = 0.8)
text(0.5, 0.39, "▼", col = myC1, cex = 0.8)
dev.off()
