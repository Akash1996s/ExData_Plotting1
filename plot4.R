setwd("F:/Dplyr/Exploratory Data Analysis")

library("data.table")
library(graphics)
library(ggplot2)

#Loading Data

Data <- data.table::fread("household_power_consumption.txt", na.strings = "?")

# Prevents Scientific Notation
Data$Sub_metering_1 <- as.numeric(Data$Sub_metering_1)
Data$Sub_metering_2 <- as.numeric(Data$Sub_metering_2)
Data$Sub_metering_3 <- as.numeric(Data$Sub_metering_3)
Data$Global_active_power <- as.numeric(Data$Global_active_power)
# Making a POSIXct date capable of being filtered and graphed by time of day

Data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
Data <- Data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

##Creating a png file.

png("plot4.png", width=480, height=480)

##par function to plot the graph in 2*2.

par(mfrow = c(2,2))

##Plot 4

plot(x = Data[, dateTime]
     , y = Data[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

with(Data, plot( dateTime
                 , Voltage
                 , type = "l"
                 , xlab = "dateTime"
                 , ylab = "Voltage"))
plot(x = Data[, dateTime]
     , y = Data[, Sub_metering_1]
     , col = "black"
     , type="l", xlab="", ylab="Energy sub metering")
lines(x = Data[, dateTime]
      , y = Data[, Sub_metering_2]
      , col = "red"
      , type="l")

lines(x = Data[, dateTime]
      , y = Data[, Sub_metering_3]
      , col = "blue"
      , type="l")

legend("topright"
       , legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , col = c("black","red","blue")
       , lty = 1
       , cex = 0.8)
with(Data, plot( dateTime
                 , Global_reactive_power
                 , type = "l"
                 , xlab = "dateTime"
                 , ylab = "Global_reactive_power"))
dev.off()
