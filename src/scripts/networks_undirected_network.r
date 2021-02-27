pdf_file <- "pdf/networks_undirected_network.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 8, height = 7)

par(mai = c(0.25, 0.25, 0.25, 0.5), omi = c(0.25, 0.25, 0.25, 0.25), family = "Lato Light", las = 1)

library(igraph)
library(sqldf)
library(gdata)

# Import data and prepare chart

X2013_2014 <- read.csv("myData/2013_2014.txt", sep = "\t", head = FALSE)
X2014_2015 <- read.csv("myData/2014_2015.txt", sep = "\t", head = FALSE)
X2015_2016 <- read.csv("myData/2015_2016.txt", sep = "\t", head = FALSE)
links <- rbind(X2013_2014, X2014_2015, X2015_2016)

teams <- as.data.frame(unique(c(links$V1, links$V2)))
teams <- sqldf("select team, count(*) games from (select V1 team from links union all select V2 team from links) a group by team")
teams$col <- "grey55"
teams$col[c(11, 12, 13, 14, 24, 51)] <- "#f768a1"

mySeed <- as.POSIXlt(Sys.time())
mySeed <- 1000 * (mySeed$hour * 3600 + mySeed$min * 60 + mySeed$sec)
mySeed

set.seed(56313585)
net2 <- graph_from_data_frame(d = links, directed = F, vertices = teams)
net2simp <- simplify(net2, edge.attr.comb = list(weight = "sum", "ignore"))

# Crete chart

plot(net2simp, vertex.shape = "none", vertex.label = V(net2simp)$media, vertex.label.font = 2, vertex.label.color = teams$col, vertex.label.cex = 0.7 * sqrt(teams$games / 23), edge.color = "grey80", vertex.label.family = ifelse(teams$col == "grey95", "Avenir Next Condensed Ultra Light", "Avenir Next Condensed Demi Bold"))

# Titling

mtext("Champions League - Matches", line = -1.5, adj = 0, cex = 2, family = "Lato Black", col = "grey40", outer = T)
mtext("Base: all matches 2013-2016", line = -2.75, adj = 0, cex = 0.9, family = "Lato Bold", col = "grey40", outer = T)
mtext("Source: http://www.weltfussball.de/alle_spiele/champions-league-2015-2016/", side = 1, line = -1, adj = 1, cex = 0.9, font = 3, outer = T)

dev.off()
