### reading 1st 70,000 of rows of data into a variable data70K
data70K<-read.table("household_power_consumption.txt", sep=";", nrows=70000, na.strings = "?",
                    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header = TRUE)

### subsetting the data
data70K$Date <- as.Date(data70K$Date, format = "%d/%m/%Y")

data01 <- subset(data70K, Date == "2007-02-01")
data02 <- subset(data70K, Date == "2007-02-02")

data <- rbind(data01, data02, deparse.level = 1, make.row.names=FALSE)

### plotting chart 1 and saving it into a png file
png(filename = "plot1.png", width = 480, height = 480, bg = "transparent")

hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()