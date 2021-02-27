pdf_file<-"pdf/networks_chord_diagram.pdf"
cairo_pdf(bg="grey98", pdf_file, width=8,height=8)
par(omi=c(0.25,0.25,0.5,0.25), mai=c(0,0,0,0), family="Lato Light")

library(circlize)
library(RColorBrewer)
library(readr)
library(sqldf)

# Import data and prepare chart


df0 <- read_csv("myData/2010 GIM data.csv")
df1 <- read_csv("myData/2010 GIM data lookup.csv")

bulas <- read_csv("data/bulas.csv")
kreise<-sqldf("select min(kreis_destatis/1000) bula, hk_id from df1 group by hk_id")

df_bula<-sqldf("select a.bula bula_destination, b.* from kreise a, df0 b where a.hk_id = b.destination_hk")
df_bula<-sqldf("select a.bula bula_origin, b.* from kreise a, df_bula b where a.hk_id = b.origin_hk")
df_bula<-sqldf("select bula_origin, bula_destination, sum(t_total) t_total from df_bula group by bula_origin, bula_destination")
df_bula<-sqldf("select a.bula bula_origin_name, b.bula_destination, b.t_total from bulas a, df_bula b where a.nr = b.bula_origin")
df_bula<-sqldf("select b.bula_origin_name, a.bula bula_destination_name, b.t_total/1000 t_total from bulas a, df_bula b where a.nr = b.bula_destination")
df_bula<-df_bula[df_bula$t_total>15, ]
df_bula<-df_bula[df_bula$bula_origin!=df_bula$bula_destination, ]


circos.clear()
circos.par(start.degree = 90, gap.degree = 4, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
par(mar = rep(0, 4))

# Create chart

chordDiagram(x = df_bula, grid.col = brewer.pal(length(unique(df_bula$bula_origin)), "Spectral"), transparency = 0.25,
             directional = 1,
             direction.type = c("arrows", "diffHeight"), diffHeight  = -0.04,
             annotationTrack = c("grid", "name", "axis"), annotationTrackHeight = c(0.05, 0.1),
             link.arr.type = "big.arrow", link.sort = TRUE, link.largest.ontop = TRUE)

# Titling

mtext("Migration between states 2010", adj=0, cex=2, family="Lato Black", col="grey40", outer=T)
mtext("all migrations over 15,000 persons, without internal migration, data in thousands", line=-1.25, adj=0, cex=0.9, family="Lato Bold", col="grey40", outer=T)
mtext("Source: www.nikolasander.net/news/diy", side=1, line=-1, adj=1, cex=0.9, font=3, outer=T)
 
circos.clear()
dev.off()


