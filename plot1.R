setwd("F:/Dplyr/Exploratory Data Analysis")

#Loading Data

Data <- data.table::fread("household_power_consumption.txt", na.strings = "?")

##Changing the class of the Date column.

Data$Date <- as.Date(Data$Date, format = "%d/%m/%Y")

##Selecting the data for specified dates.

SubData <- subset(Data, Date = c("2007-02-01","2007-02-02"))

##Changing the Global Active Power column to numeric format

SubData$Global_active_power <- as.numeric(SubData$Global_active_power)

##Creating a png file with specific height and width

png("plot1.png", width = 480, height = 480)
hist(SubData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

##Closing the opened device.
dev.off()
