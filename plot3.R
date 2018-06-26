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
  
  #creating the histogram for Global Active power
  with(pc,{
          plot(pc$Sub_metering_1~pc$dateTime,xlab="",ylab="Energy Sub Metering",type="l")
          lines(pc$Sub_metering_2~pc$dateTime,col="red")
          lines(pc$Sub_metering_3~pc$dateTime,col="blue")
          legend("topright",col=c("black","red","blue"),lwd=c(2,2,2),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  }
)

  # Save the plot to png file 
  dev.copy(png,"./data/plot3.png", width=480, height=480) 
  dev.off()
