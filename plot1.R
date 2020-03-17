# PLOT 1

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

# 1: Histogram
# Probably the easiest one

par(mfrow = c(1,1))

png(width = 480, height = 480, file = "Course Project 1/plot1.png")
with(filtered_power_consumption,
     hist(as.numeric(Global_active_power),
          col = 'red',
          main = "Global Active Power",
          xlab = 'Global Active Power (kilowatts)')
)
dev.off()
