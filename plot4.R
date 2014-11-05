#plot 4:
##step 4.1:allocating data into mData vector, setting header to True, sep to ';', setting colClasses (1st and 2nd Col is character and next 7 col are "numeric")
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
## setting gobal graphical parameters to plot4:
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

##step 4.2: creating plot4
with(tData, {
        ## Top-left plot graphics
        plot (DateTime, Global_active_power, type = "l", xlab="", ylab = "Global Active Power")
        ## Top-right plot graphics
        plot (DateTime, Voltage, type = "l", xlab="datetime", ylab = "Voltage")
        ## Bottom -left plot graphics
        plot (DateTime, Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering", col = "black")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
        ## no to border of legend
        legend("topright", bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), cex=0.7, lwd = 1)
        ## Bottom-right plot graphics
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab="Global Reactive Power", col = "black")
})

##step 4.3: set the height/width (480 pixels) print to "plot4.png"
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

print ("plot4.png is now available")
