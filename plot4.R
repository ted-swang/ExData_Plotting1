library(lubridate)
library(dplyr)

## read the table into data frame hpc
hpc <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric","numeric","numeric","numeric","numeric"))

## filter the correct dates, put date and time as one column called "datetime",
## and replace the two columns "Date" and "Time" with the one column "datetime"
hpc <- hpc %>% 
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
        mutate(datetime = dmy_hms(paste(Date, Time))) %>% 
        select(datetime, Global_active_power:Sub_metering_3)

## open a png device called plot4.png with the correct dimensions
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## set the correct parameters before making plot, including mfcol = c(2,2)
## to make a 2 by 2 grid.
par(mfcol = c(2,2), mar = c(4,4,2,1), bg = "transparent", col.lab = "black", col.main = "black")

## create the appropriate plots
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

##close the graphics device
dev.off()