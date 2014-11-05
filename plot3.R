#plot 3:
##step 3.1:allocating data into mData vector, setting header to True, sep to ';', setting colClasses (1st and 2nd Col is character and next 7 col are "numeric")
##"?" to be converted into n.a and set the number of rows we need to stay as numeric while the rest is char 
mData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character","character", rep("numeric",7)), na = "?")

##Setting dates and subsetting the data
##set the format of the date to Year-Month-Date
mData$Date <- as.Date(mData$Date, format = "%d/%m/%Y")
##subsetting the data into the required date frame of dates 2007-02-01 and 2007-02-02 and setting it into tData
tData <- subset(mData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

##Set the DateTime col back to tData
##as tData was already been set to %d/%m/%Y - %H:%M:%S,, we do not need to use strptime.
##reassign the values of dateTime (which has now DateTime combine, back to tData, as a column
DateTime <- paste(as.Date(tData$Date), tData$Time)
tData$DateTime <- as.POSIXct(DateTime)

print ("Plotting commences")
##step 3.2: create plot3
with(tData, { plot(Sub_metering_1~DateTime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
              lines(DateTime, Sub_metering_2, col = "red")
              lines(DateTime, Sub_metering_3, col = "blue")
})
##step 3.3, create legend,
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
##step 3.4: set the height/width (480 pixels) print to "plot3.png"
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
print ("plot3.png is now available")
