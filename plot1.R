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

## open a png device called plot1.png with the correct dimensions
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## set the correct parameters before making plot
par(bg = "transparent", col.lab = "black", col.main = "black")

## create the appropriate histogram
hist(hpc$Global_active_power, col = "red",  main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## close the graphics device
dev.off()