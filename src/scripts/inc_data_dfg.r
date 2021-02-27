# inc_data_dfg.r
myC1a<-rgb(251,212,150,maxColorValue=255)
myC2a<-rgb(237,153,118,maxColorValue=255)
myC3a<-rgb(179,213,148,maxColorValue=255)
myC4a<-rgb(112,200,230,maxColorValue=255)

myC1b<-rgb(243,178,40,maxColorValue=255)
myC2b<-rgb(220,62,42,maxColorValue=255)
myC3b<-rgb(109,182,68,maxColorValue=255)
myC4b<-rgb(0,163,218,maxColorValue=255)

myColours1<-c(myC1a, myC2a, myC3a,myC4a)
myColours2<-c(myC1b, myC2b, myC3b, myC4b)

a<-c(418.7,418.7); b<-c(768.0,768.0); c<-c(436.1,436.1); d<-c(476.7,478.7)
x<-as.matrix(data.frame(a,b,c,d))
a<-c(0,148.6); b<-c(0,271.4); c<-c(0,154.7); d<-c(0,185.8)
y<-as.matrix(data.frame(a,b,c,d))

w1<-"Humanities and social sciences"
w2<-"Life sciences"
w3<-"Natural sciences"
w4<-"Engineering"

labelling<-c(w1,w2,w3,w4)
