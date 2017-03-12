# Name: Plot1.R
# Author: Joe Logan
# Date 12-March 2017
# Assignment: Create Histogram showing the frequency for every .5 KW Global Active Power

# Read all of the data into a data frame if haven't already loaded
if(!exists("data_all")) {
        data_all <- read.csv("./data/household_power_consumption.txt", header=TRUE,sep=";", 
                   na.strings = "?", nrows=2075259)
}


# Get a subset to only include 2 days (1/2/2007 - 2/2/2007) 
# (No need to convert, just use strings) (Uses European date format)
data_date_stripped <- subset(data_all, Date %in% c("1/2/2007", "2/2/2007"))

# (European Date Format does not need to be converted to US since it is not shown)
# data_date_stripped$Date <- as.Date(data_date_stripped$Date, format="%d/%m/%Y")

# Set the framework of the plot first and create the file
png("plot1.png", width=480, height=480)

# Create the histogram
hist(data_date_stripped$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Must close the device to view the file
dev.off()