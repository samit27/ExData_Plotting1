  #downloading the file
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./course4project/household_power_consumption.zip")
  
  #unzipping the file
  unzip("./course4project/household_power_consumption.zip", exdir = "./course4project")
  
  #read into data table pc (for power consumption)
  pc <-read.table("./course4project/household_power_consumption.txt", header = TRUE, stringsAsFactors=FALSE, dec=".", sep = ";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
  
  #converting the date column from character to date and filtering the data set for given date
  pc$Date <- as.Date(pc$Date,"%d/%m/%Y")
  pc <- pc[pc$Date == as.Date('2007-2-1') | pc$Date == as.Date('2007-2-2'),]
  
  #getting the date time column and adding it to the data set
  dateTime <- paste(pc$Date, pc$Time) 
  dateTime <- strptime(dateTime, "%Y-%m-%d %H:%M:%S") 
  pc <- cbind(dateTime,pc) 
  
  
  
  # Create 4 plots on the graphic device for plot 4 
  par(mfrow=c(2,2)) 
  with(pc,{ 
           plot(pc$Global_active_power~pc$dateTime, type="l", xlab="", ylab="Global Active Power") 
           plot(pc$Voltage~pc$dateTime, type="l", xlab="datetime", ylab="Voltage") 
           plot(Sub_metering_1~dateTime, type="l", xlab="", ylab="Energy sub metering") 
           lines(Sub_metering_2~dateTime, col="red") 
           lines(Sub_metering_3~dateTime, col="blue") 
           legend("topright",col=c("black","red","blue"),lwd=c(2,2,2),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
           plot(pc$Global_reactive_power~pc$dateTime, type="l", xlab="datetime", ylab="Global_reactive_power") 
  }
) 
  

  # Save the plot to png file 
  dev.copy(png,"./data/plot4.png", width=480, height=480) 
  dev.off()
