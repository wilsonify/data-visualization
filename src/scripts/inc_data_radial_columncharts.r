# inc_data_radial_columncharts.r
myData<-read.xls("myData/BetterLifeIndex_Data_2011V6.xls",pattern="ISO3",sheet=3, encoding="latin1")
n<-nrow(myData)-2
myData<-myData[1:n, ]
myData<-myData[,c(1:12,14,13,15:length(myData))]

row.names(myData)<-myData$ISO3
myDataMargin<-NULL
myDataCenter<-NULL
for (i in 3:length(myData)) 
{
myDataMargin<-c(myDataMargin,list(11.5:12.5))
myDataCenter<-c(myDataCenter,list(0:1))
}