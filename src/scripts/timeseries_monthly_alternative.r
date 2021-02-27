# https://stat.ethz.ch/pipermail/r-help/2008-September/173189.html
library(utils)
oneMonth <- 1.0 / 12.0
tsData <- ts(rnorm(103, 100), start = 2000, deltat = oneMonth) # goes until Jul
plot(tsData, ylab = "Values", xlab = "Zeit", xaxt = "n")
axis(1, time(tsData), rep(substr(month.abb, 1, 1), length = length(tsData)), cex.axis = .3, tcl = -.5)
jan <- time(tsData)[cycle(tsData) == 1]  # january
axis(1, jan, FALSE, tcl = -1)
abline(v = jan, lty = 2)
