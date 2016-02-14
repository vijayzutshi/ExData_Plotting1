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
gblActivePower <- as.numeric(subSetData$Global_active_power) 
gblReactivePower <- as.numeric(subSetData$Global_reactive_power) 
voltagerec <- as.numeric(subSetData$Voltage) 
subMeter1 <- as.numeric(subSetData$Sub_metering_1) 
subMeter2 <- as.numeric(subSetData$Sub_metering_2) 
subMeter3 <- as.numeric(subSetData$Sub_metering_3) 
## plots 4 graps 
png("plot4.png", width=480, height=480) 
par(mfrow = c(2, 2))  
## plots graph for Global Active Power
plot(datetimerecord, gblActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2) 
## plots graph for Voltage consumption
plot(datetimerecord, voltagerec, type="l", xlab="datetime", ylab="Voltage") 
## plots graph for Energy Sub Metering
plot(datetimerecord, subMeter1, type="l", ylab="Energy Submetering", xlab="") 
lines(datetimerecord, subMeter2, type="l", col="red") 
lines(datetimerecord, subMeter3, type="l", col="blue") 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o") 
## plots graph for Global Reactive Power
plot(datetime, gblReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power") 
dev.off() 







