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

## plotting chart 4 and saving it into a png file

data$Date_Time <- as.POSIXct(paste(data$Date, data$Time))

png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")

par(mfrow = c(2, 2))

with(data, {
  plot(data$Date_Time, data$Global_active_power, type="l", xlab = "",  
       ylab = "Global Active Power")
  plot(data$Date_Time, data$Voltage, type="l", xlab = "datetime",  
       ylab = "Voltage")
  with(data, plot(Date_Time, Sub_metering_1, type="l", col="black", xlab = "", ylab = "Energy sub metering"), lwd = 2)
  with(data, points(Date_Time, Sub_metering_2, type="l", col="red"), lwd = 2)
  with(data, points(Date_Time, Sub_metering_3, type="l", col="blue"), lwd = 2)
  legend("topright", col = c("black","red","blue"), 
         legend = c("Sub_metering_1", "Sub_metering_3", "Sub_metering_3"), lwd = 2, bty="n", cex=0.7)
  plot(data$Date_Time, data$Global_reactive_power, type="l", xlab = "datetime",  
       ylab = "Global_reactive_power")
})  

dev.off()
