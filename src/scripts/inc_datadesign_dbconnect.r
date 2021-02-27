# inc_datendesign_dbconnect.r
library(RMySQL)
con <- dbConnect(MySQL(), user="XXX", password="XXX", dbname = "XXX", host="XXX")
