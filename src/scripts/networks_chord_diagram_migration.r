# https://github.com/gjabel/migest/blob/master/demo/cfplot_reg2.R
pdf_file <- "pdf/networks_chord_diagram_migration.pdf"
cairo_pdf(bg = "grey98", pdf_file, width = 8, height = 8)
par(omi = c(0.25, 0.25, 0.25, 0.25), mai = c(0, 0, 0, 0), family = "Lato Light")

library("circlize")

# Read data and prepare chart

df0 <- read.csv("myData/reg_flow.csv", stringsAsFactors = FALSE)
df1 <- read.csv("myData/reg_plot.csv", stringsAsFactors = FALSE)

circos.par(start.degree = 90, gap.degree = 4, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
par(mar = rep(0, 4))

# Create chart

chordDiagram(x = df0, grid.col = df1$col, transparency = 0.25,
             order = df1$region, directional = 1,
             direction.type = c("arrows", "diffHeight"), diffHeight = -0.04,
             annotationTrack = "grid", annotationTrackHeight = c(0.05, 0.1),
             link.arr.type = "big.arrow", link.sort = TRUE, link.largest.ontop = TRUE)

circos.trackPlotRegion(
  track.index = 1,
  bg.border = NA,
  panel.fun = function(x, y) {
    xlim <- get.cell.meta.data("xlim")
    sector.index <- get.cell.meta.data("sector.index")
    reg1 <- df1$reg1[df1$region == sector.index]
    reg2 <- df1$reg2[df1$region == sector.index]

    circos.text(x = mean(xlim), y = ifelse(test = nchar(reg2) == 0, yes = 5.2, no = 6.0),
                labels = reg1, facing = "bending", cex = 1.2)
    circos.text(x = mean(xlim), y = 4.4,
                labels = reg2, facing = "bending", cex = 1.2)
    circos.axis(h = "top",
                major.at = seq(from = 0, to = xlim[2], by = ifelse(test = xlim[2] > 10, yes = 2, no = 1)),
                minor.ticks = 1, major.tick.percentage = 0.5,
                labels.niceFacing = FALSE)
  }
)

circos.clear()

# Titling


text(x = -1.1, y = -1, pos = 4, cex = 0.6,
     labels = "Based on estimates from:")
text(x = -1.1, y = -1 - 1 * 0.03, pos = 4, cex = 0.6,
     labels = expression(paste(
       plain(" Abel G.J. (2016) "), italic("Estimates of Global Bilateral Migration Flows by Gender")
     )))
text(x = -1.1, y = -1 - 2 * 0.03, pos = 4, cex = 0.6,
     labels = expression(paste(
       italic(" between 1960 and 2015. "), plain("Vienna Institute of Demography Working Papers. 2/2016")
     )))

dev.off()
