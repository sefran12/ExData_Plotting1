# PLOT 4

# According to instructions, I need to provide the code to get the data
# in each of these snippets, so I'll do that

# REQUIRED LIBRARIES

library(tidyverse)
library(data.table)
library(lubridate)

# DOWNLOADING FILES

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("ElectricPowerConsumption.zip")) {
    download.file(url = fileURL,
                  destfile = "ElectricPowerConsumption.zip")
}

if (!file.exists("household_power_consumption.txt")) {
    unzip("ElectricPowerConsumption.zip")
}

# LOADING DATA
if (!exists('power_consumption')) {
    power_consumption <- fread(file = "household_power_consumption.txt",
                               sep = ";", header = TRUE)
}

str(power_consumption) # checking everything is OK

# FILTERING

filtered_power_consumption <- power_consumption %>% 
    mutate(Date = dmy(Date)) %>%
    filter(Date >= '2007-02-01' & Date <= '2007-02-02')

# 4: Composite plot
# Here I had to fight a bit with the legend positioning and size, that
# appearead all messed up with the default settings

png(width = 480, height = 480, file = "Course Project 1/plot4.png")
par(mfcol = c(2,2))
filtered_power_consumption %>% 
    select(Global_active_power) %>% 
    plot.ts(xaxt = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
axis(1, at = c(0, nrow(filtered_power_consumption)/2, nrow(filtered_power_consumption)),
     labels=c("Thu", "Fri", "Sat"))

plot.ts(filtered_power_consumption$Sub_metering_1, xaxt = "n", ylab = "Energy sub metering", xlab = "")
axis(1, at = c(0, nrow(filtered_power_consumption)/2, nrow(filtered_power_consumption)),
     labels=c("Thu", "Fri", "Sat"))
lines(filtered_power_consumption$Sub_metering_2, col = "red")
lines(filtered_power_consumption$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, cex = 0.9,
       col = c("black", "red", "blue"), bty = 'n')

plot.ts(filtered_power_consumption$Voltage, xaxt = "n", ylab = "Voltage", xlab = "datetime")
axis(1, at = c(0, nrow(filtered_power_consumption)/2, nrow(filtered_power_consumption)),
     labels=c("Thu", "Fri", "Sat"))

plot.ts(filtered_power_consumption$Global_reactive_power, xaxt = "n", ylab = "Global_reactive_power", xlab = "datetime")
axis(1, at = c(0, nrow(filtered_power_consumption)/2, nrow(filtered_power_consumption)),
     labels=c("Thu", "Fri", "Sat"))
dev.off()
