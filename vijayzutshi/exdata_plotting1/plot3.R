## R script for reading data from the text file 
## provindig household power consumption
## the dataset has 2,075,259 rows and 9 columns
## but for this assignment we will only use data 
## for 2 days i.e 2007/02/01 to 2007/02/02
## setup the working directory to the path mentioned  
## below and copy or extract the household_power_consumtion.txt file
maindataFile <- "./data/household_power_consumption.txt" 
dataconsump <- read.table(maindataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".") 
subSetData <- dataconsump[dataconsump$Date %in% c("1/2/2007","2/2/2007") ,] 

#str(subSetData) 
datetimerecord <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")  
globalActivePower <- as.numeric(subSetData$Global_active_power) 
subMeter1 <- as.numeric(subSetData$Sub_metering_1) 
subMeter2 <- as.numeric(subSetData$Sub_metering_2) 
subMeter3 <- as.numeric(subSetData$Sub_metering_3) 
# plot line graph with legends
png("plot3.png", width=480, height=480) 
plot(datetimerecord, subMeter1, type="l", ylab="Energy Submetering", xlab="") 
lines(datetimerecord, subMeter2, type="l", col="red") 
lines(datetimerecord, subMeter3, type="l", col="blue") 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue")) 
dev.off() 
