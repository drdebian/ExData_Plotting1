###
# Exploratory Data Analysis Course Project 1 / Plot 4
###

# Data for the project: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Copy of unzipped data assumed to be stored in local working directory
###

#load library
library(sqldf)

#read input data
df1 <- read.csv2.sql(file = "household_power_consumption.txt",
                     sql  = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
                     )


#add proper datetime field
df1$DateTime <- as.POSIXct(strptime(paste(df1$Date, df1$Time),"%d/%m/%Y %H:%M:%S"))

#set locale for correct international labelling
Sys.setlocale("LC_TIME",
              "C")

#create png file device
png("plot4.png",
    height=480,
    width=480)

#create canvas for plot 4
par(mfcol=c(2,2))

#subplot 1
plot(df1$Global_active_power~df1$DateTime,
     type="l",
     ylab="Global Active Power", 
     xlab="")

#subplot 2
plot(df1$Sub_metering_1~df1$DateTime,
     type="l",
     ylab="Energy sub metering",
     xlab="")
lines(df1$Sub_metering_2~df1$DateTime,
      type="l",
      col="red")
lines(df1$Sub_metering_3~df1$DateTime,
      type="l",
      col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n",
       col = c("black","red","blue"),
       lty="solid")

#subplot 3
plot(df1$Voltage~df1$DateTime,
     type="l",
     ylab="Voltage",
     xlab="datetime")

#subplot 4
plot(df1$Global_reactive_power~df1$DateTime,
     type="l",
     ylab="Global_reactive_power",xlab="datetime")


#close device
dev.off()
