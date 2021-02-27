# inc_temperatur_daten.r
# 2012-04-25,TR
# http://climate.rutgers.edu/stateclim_v1/data/north_njhisttemp.html
# Monthly Mean Temperatures in Northern New Jersey (Division 1) From 1895-2012
temp<-read.table("daten/temperature.txt",header =T,row.names=1)
temp$Avg<-NULL
temp$Abw<-NULL
x<-NULL
for (i in 1:nrow(temp)) 
{
	for (j in 1:ncol(temp[i,])) x<-c(x,temp[i,j])
}
x <- ts(x, start=1895, frequency=12)
