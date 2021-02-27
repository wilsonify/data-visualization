pdf_file <- "pdf/profile_chart.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 12, height = 8)

source("scripts/functions/profile.plot.r")
par(lheight = 1.15, mai = c(0.25, 0.25, 0.25, 0.25), omi = c(0.5, 0.5, 1.1, 0.5),
    family = "Lato Light", las = 1)

# Import labels

text.left <- NULL
text.right <- NULL
text.left <- c(text.left, "Individuals should take more responsibility for\nproviding for themselves.")
text.right <- c(text.right, "The state should take more\nresponsibility to ensure that everyone is\nprovided for.")
text.left <- c(text.left, "People who are unemployed should\nhave to take any job available or lose\ntheir unemployment benefits.")
text.right <- c(text.right, "People who are unemployed should\nhave the right to refuse a job they\ndo not want.")
text.left <- c(text.left, "Competition is good. It stimulates\npeople to work hard and develop\nnew ideas.")
text.right <- c(text.right, "Competition is harmful. It brings\nout the worst in people.")
text.left <- c(text.left, "The government should give companies\nmore freedom.")
text.right <- c(text.right, "The state should control firms more\neffectively.")
text.left <- c(text.left, "Incomes should be made more equal.")
text.right <- c(text.right, "There should be greater incentives\nfor individual effort.")
text.left <- c(text.left, "Private ownership of business\nand industry should be increased.")
text.right <- c(text.right, "Government ownership of\nbusiness and industry should be\nincreased.")

# Import and prepare data

library(Hmisc)
ZA4753 <- spss.get("myData/ZA4753_v1-1-0.sav", use.value.labels = F)
myVariables <- c("v302", "v194", "v195", "v196", "v197", "v198", "v199")
myResult <- dim(2)
myData <- ZA4753[, myVariables]
for (i in 2:length(myVariables))
{
  mySelection <- subset(myData[, c(1, i)], myData[, i] >= 1 & myData[, i] <= 10)
  myValues <- t(aggregate(mySelection[, 2], by = list(mySelection[, 1]), FUN = mean, na.rm = T))
  myResult <- rbind(myResult, myValues[2,])
}

# Create chart 

colnames(myResult) <- c("Men", "Women")
myC1 <- "skyblue"
myC2 <- "darkred"
profile.plot(myResult, text.left, text.right, colours = c(myC1, myC2), legend.n.col = 2)

# Titling

mtext("Now I’d ask you to please tell me your views on different statements.", 3, line = 3, adj = 0, cex = 1.5, family = "Lato Black", outer = T)
mtext("Source: ZA4753: European Values Study 2008: Germany (EVS 2008). N=2,075", 1, line = 1, adj = 1.0, cex = 1.1, font = 3, outer = T)
dev.off()
