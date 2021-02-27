# inc_missing_values.r
lines(y,lwd=3,col=myColour)
von<-2; bis<-length(y)-1
for (i in von:bis)
{
if (is.na(y[i-1]) & !is.na(y[i]) & is.na(y[i+1])) 
points(time(y)[i],y[i],pch=ptyp,cex=1.5,col=myColour)
}
# ... and the margins
if (!is.na(y[1]) & is.na(y[2])) points(time(y)[1],y[1],pch=ptyp,cex=1.5,col= myColour)
if (!is.na(y[length(y)]) & is.na(y[length(y)-1])) points(time(y)[length(y)],y[length(y)],pch=ptyp,cex=1.5,col= myColour)