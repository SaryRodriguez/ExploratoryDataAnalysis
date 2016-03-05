setwd("~/Coursera/Exploratory Data Analysis")
unzip('./data.zip')

#OPTION 1
mydata <- read.table(text = grep("^[1,2]/2/2007", readLines(file("household_power_consumption.txt")), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE, na.strings="?")

#OPTION 2
data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?") 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, subset=(Date >="2007-02-01" & Date <= "2007-02-02"))

data$day <- as.POSIXlt(data$Date)$wday
data$dayLetter <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", 
                    "Friday", "Saturday")[as.POSIXlt(data$Date)$wday + 1]
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()