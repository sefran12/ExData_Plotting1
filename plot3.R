# PLOT 3

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

# 3: Energy sub metering
# The same warning applies. Also don't really think the original script
# had any of the 'cex = 0.95' minutiae, but like that it looks the closest
# to the sample

png(width = 480, height = 480, file = "Course Project 1/plot3.png")
plot.ts(filtered_power_consumption$Sub_metering_1, xaxt = "n", ylab = "Energy sub metering", xlab = "")
axis(1, at = c(0, nrow(filtered_power_consumption)/2, nrow(filtered_power_consumption)),
     labels=c("Thu", "Fri", "Sat"))
lines(filtered_power_consumption$Sub_metering_2, col = "red")
lines(filtered_power_consumption$Sub_metering_3, col = "blue")
legend("topright", cex = 0.95,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, seg.len = 2,
       col = c("black", "red", "blue"))
dev.off()