# Name: Plot4.R
# Author: Joe Logan
# Date 12-March 2017
# Assignment: matrix of 4 charts using Plots 1-3 and create a 4th using reactive power

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

# Set up the grid using a 2x2 matrix 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))


# Create the formatted contents of the plot
# Using base we must create each chart new, can't pull in from file
with(data_date_stripped, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage", xlab="datetime")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global_rective_power",xlab="datetime")
})

# Set the framework of the plot first and create the file
dev.copy(png, file="plot4.png", width=480, height=480)

# Must close the device to view the file
dev.off()
