# PLOT 2

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

# 2: Global Active Power
# From this point now on, I'll understand the problem is to get the closest
# plot to the sample plots. I say this because of the x axis, where we have
# dates, but want a short weekday label. Even though I could get a more natural
# axis labeling massaging a bit our data, I'll 'force' it a bit so we don't
# make any mistakes and always get those three ticks that say 'Thu', 'Fri' and
# 'Sat'

png(width = 480, height = 480, file = "Course Project 1/plot2.png")
filtered_power_consumption %>% 
    select(Global_active_power) %>% 
    plot.ts(xaxt = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
axis(1, at = c(0, nrow(filtered_power_consumption)/2, nrow(filtered_power_consumption)),
     labels=c("Thu", "Fri", "Sat"))
dev.off()