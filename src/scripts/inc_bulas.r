# inc_bulas.r

library(readr)
library(sqldf)

df0 <- read_csv("myData/2010 GIM data.csv")
df1 <- read_csv("myData/2010 GIM data lookup.csv")

bulas <- read_csv("~/myData/bulas.csv")

kreise<-sqldf("select min(kreis_destatis/1000) bula, hk_id from df1 group by hk_id")

df_bula<-sqldf("select a.bula bula_destination, b.* from kreise a, df0 b where a.hk_id = b.destination_hk")
df_bula<-sqldf("select a.bula bula_origin, b.* from kreise a, df_bula b where a.hk_id = b.origin_hk")
df_bula<-sqldf("select bula_origin, bula_destination, sum(t_total) t_total from df_bula group by bula_origin, bula_destination")

