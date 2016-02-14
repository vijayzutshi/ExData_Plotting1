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
png("plot2.png", width=480, height=480) 
plot(datetimerecord, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)") 
dev.off() 
