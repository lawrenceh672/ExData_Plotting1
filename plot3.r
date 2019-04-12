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

#draw the frequency histogram into the 480x480 png file
png(filename ="plot3.png", width = 480, height = 480)
plot(c(data$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering", lab=c(3,4,31) , xaxt = "n")
#find out how many rows are from thursday and how many from friday and put the labels appropriately
thursdays<-sum(data$Date=="1/2/2007")
#label the dates
axis(side=1, at=c(1, thursdays, nrow(data)), labels=c("Thu","Fri","Sat"))
lines(data$Sub_metering_2,col="red")
lines(data$Sub_metering_3,col="blue")
legend("topright","left",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()
