#download the file from the internet
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl,destfile="data.zip",method="curl")

#unzip it for reading
unzip("data.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)

#get the data, change the ?s into NAS as specified, and formatting the columns
data<-read.table("household_power_consumption.txt",sep=";",header=TRUE,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?",nrows=170000)

#remove rows with NA values
data<-data[complete.cases(data),]

#select data from feb 1 and 2 2007
data<-subset(data,Date=="1/2/2007" | Date=="2/2/2007")
#count the number of thursdays for labelling the thu fri and sat x axis labels
thursdays<-sum(data$Date=="1/2/2007")
daycount<-nrow(data)

#draw the frequency histogram into the 480x480 png file
png(filename ="plot4.png", width = 480, height = 480)
#define the plot as a 2x2 series of 4 graphs
par(mfrow=c(2,2))
plot(data$Global_active_power, type="l", xlab="", ylab="Global Active Power", xaxt="n")
axis(side=1, at=c(1, thursdays, daycount), labels=c("Thu","Fri","Sat"))

#Graph 2
plot(data$Voltage, type="l", xlab="datetime", ylab="Voltage", xaxt = "n")
axis(side=1, at=c(1, thursdays, daycount), labels=c("Thu","Fri","Sat"))

#graph 3
plot(data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", lab=c(3,4,31) , xaxt = "n")
axis(side=1, at=c(1, thursdays, daycount), labels=c("Thu","Fri","Sat"))
lines(data$Sub_metering_2,col="red")
lines(data$Sub_metering_3,col="blue")
legend("topright","left",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1, bty="n")

#graph 4
plot(data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", xaxt = "n")
axis(side=1, at=c(1, thursdays, daycount), labels=c("Thu","Fri","Sat"))
dev.off()

