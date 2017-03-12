# Name: Plot2.R
# Author: Joe Logan
# Date 12-March 2017
# Assignment: Create plot showing hour by hour KW usage

# Read all of the data into a data frame if haven't already loaded
if(!exists("data_all")) {
        data_all <- read.csv("./data/household_power_consumption.txt", header=TRUE,sep=";", 
                             na.strings = "?", nrows=2075259)
}

# Get a subset to only include 2 days (1/2/2007 - 2/2/2007) 
# (No need to convert, just use strings) (Uses European date format)
data_date_stripped <- subset(data_all, Date %in% c("1/2/2007", "2/2/2007"))

# Now we need to convert to US format
data_date_stripped$Date <- as.Date(data_date_stripped$Date, format="%d/%m/%Y")

# Create a new date/time field so we can plot in order of the day then the hour 
date_with_time <- paste(as.Date(data_date_stripped$Date), data_date_stripped$Time)

# Add the new column to the data frame
data_date_stripped$Datetime <- as.POSIXct(date_with_time)

# Set the framework of the plot first and create the file
png("plot2.png", width=480, height=480)

# Create the formatted contents of the plot
with(data_date_stripped, {
        plot(Global_active_power~Datetime, type="l", ylab="Global Active Power (kilowatts)", 
             xlab="")
})

# Must close the device to view the file
dev.off()
