# ===============================================================
# Author:      Michael O'Flaherty (michael@oflaherty.com)
# Create date: 7/10/2014
#
# Description: Forked repository from
#              https://github.com/rdpeng/ExData_Plotting1
#              to https://github.com/moflaherty/ExData_Plotting1
#
# Notes:       The purpose of this assignment is to create a plot
#              from the Electric power consumption data. We will 
#              only use data from 2007-02-01 and 2007-02-02.
# ===============================================================

# ===============================================================
#                          COMMON CODE
# ===============================================================

# we are going to use the data.table package for speed; VERY fast!
#install.packages("data.table")
library(data.table)

# we know that '?' is missing data; we want to account for those
missing.types <- c('?')

# set data column types to character to address missing data; we will convert back after subsetting
data.column.types <- c(
  'character', # Date
  'character', # Time 
  'character', # Global_active_power
  'character', # Global_reactive_power
  'character', # Voltage
  'character', # Global_intensity
  'character', # Sub_metering_1
  'character', # Sub_metering_2
  'character'  # Sub_metering_3
)

# load the data
data <- fread('household_power_consumption.txt', na.strings=missing.types, colClasses=data.column.types)

# subset the data for the days we want to work with
data <- subset(data, Date=='1/2/2007' | Date=='2/2/2007')

# reset the columns to the data types we want to work with
data$Date <- as.Date(data$Date, format='%d/%m/%Y')
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# times need massaged using strptime; we will store in
# another variable for this purpose
dateTimes <- paste(data$Date, data$Time)
dateTimes <- strptime(dateTimes, "%Y-%m-%d %H:%M:%S")

# ===============================================================
#                        PLOT and IMAGE
# ===============================================================

# I noticed that the background was transparent on their PNGs; I chose to make it white just to be safe.
# checking the forums, everybody seemed to think making it transparent was too anal!
#par("bg" = 'transparent') 

# set margins
par(mar=c(3, 5, 2, 2))

# create the plot
plot(dateTimes, data$Global_active_power, xlab='', ylab='Global Active Power (kilowatts)', 
     type='n', cex.lab=0.75, cex.axis=0.75)
lines(dateTimes, data$Global_active_power)

# write out the PNG
dev.copy(png, file='plot2.png', height=480, width=480)

# always close the device or else!
dev.off()