library(lubridate)
library(dplyr)

hpc <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric","numeric","numeric","numeric","numeric"))

hpc <- hpc %>% 
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
        mutate(datetime = dmy_hms(paste(Date, Time))) %>% 
        select(datetime, Global_active_power:Sub_metering_3)

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2,2), mar = c(4,4,2,1), bg = "transparent", col.lab = "black", col.main = "black")

with(hpc, {
        plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(datetime,Sub_metering_2, col = "red")
        lines(datetime,Sub_metering_3, col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 1, col = c("black", "red", "blue"), bty = "n")
        plot(datetime, Voltage, type = "l")
        plot(datetime, Global_reactive_power, type = "l")
        }
     )

dev.off()