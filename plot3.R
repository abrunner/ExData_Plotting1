
##import header names
header<-read.table("household_power_consumption.txt",sep=";",header=T,nrows=2)

##import approximate rows for Feb 1-2, 2007, with buffer on either side
rough4000<-read.table("household_power_consumption.txt",sep=";",header=F,na.strings="?",skip=66000,nrows=4000)

##add colnames to subsetted dataframe
colnames(rough4000)<-colnames(header)

##format the time column to "POSIXlt" "POSIXt"  
x<-paste(rough4000$Date,rough4000$Time,sep=" ")
rough4000$Time<-strptime(cbind(x), format="%d/%m/%Y %H:%M:%S")

##convert Date column from factor to Date
rough4000$Date<-as.Date(rough4000$Date, "%d/%m/%Y")

##Subset dataframe for only rows containing Feb 1, 2007 and Feb 2, 2007
DF1 <- subset(rough4000, Date >= "2007-02-01")
DF2 <- subset(DF1, Date <= "2007-02-02")

##plot3
png(file = "plot3.png",height=480,width=480) ## PNG file
with(DF2,plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(DF2,lines(Time,Sub_metering_1,col="black"))
with(DF2,lines(Time,Sub_metering_2,col="red"))
with(DF2,lines(Time,Sub_metering_3,col="blue"))
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()
