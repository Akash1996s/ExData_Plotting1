setwd("F:/Dplyr/Exploratory Data Analysis")

library("data.table")

#Loading Data

Data <- data.table::fread("household_power_consumption.txt", na.strings = "?")

# Convering from character to numeric
Data$Sub_metering_1 <- as.numeric(Data$Sub_metering_1)
Data$Sub_metering_2 <- as.numeric(Data$Sub_metering_2)
Data$Sub_metering_3 <- as.numeric(Data$Sub_metering_3)

# Making a POSIXct date capable of being filtered and graphed by time of day

Data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
Data <- Data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

## Plot 3
plot(x = Data[, dateTime]
     , y = Data[, Sub_metering_1]
     , col = "black"
     , type="l", xlab="", ylab="Energy sub metering")

##LINE function for plotting in same plot.

lines(x = Data[, dateTime]
                , y = Data[, Sub_metering_2]
                , col = "red"
                , type="l")

lines(x = Data[, dateTime]
      , y = Data[, Sub_metering_3]
      , col = "blue"
      , type="l")

##Adding Legend to the plot

legend("topright"
       , legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , col = c("black","red","blue")
       , lty = 1)

dev.off()
