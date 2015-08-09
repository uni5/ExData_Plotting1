library(datasets)
Sys.setlocale("LC_ALL", "English")

### reading 1st 70,000 of rows of data into a variable data70K

data70K<-read.table("household_power_consumption.txt", sep=";", nrows=70000, na.strings = "?",
                    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header = TRUE)

### subsetting the data

data70K$Date <- as.Date(data70K$Date, format = "%d/%m/%Y")

data01 <- subset(data70K, Date == "2007-02-01")
data02 <- subset(data70K, Date == "2007-02-02")
data <- rbind(data01, data02, deparse.level = 1, make.row.names=FALSE)

data$Date_Time <- as.POSIXct(paste(data$Date, data$Time))

### plotting chart 3 and saving it into a png file

png(filename = "plot3.png", width = 480, height = 480, bg = "transparent")

with(data, plot(Date_Time, Sub_metering_1, type="l", col="black", xlab = "", ylab = "Energy sub metering"), lwd = 2)
with(data, points(Date_Time, Sub_metering_2, type="l", col="red"), lwd = 2)
with(data, points(Date_Time, Sub_metering_3, type="l", col="blue"), lwd = 2)
legend("topright", col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_3", "Sub_metering_3"), lwd = 2)

dev.off()