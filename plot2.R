library(lubridate)
library(dplyr)

hpc <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric","numeric","numeric","numeric","numeric"))

hpc <- hpc %>% 
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
        mutate(datetime = dmy_hms(paste(Date, Time))) %>% 
        select(datetime, Global_active_power:Sub_metering_3)

png(filename = "plot2.png", width = 480, height = 480, units = "px")

par(bg = "transparent", col.lab = "black", col.main = "black")

with(hpc, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()