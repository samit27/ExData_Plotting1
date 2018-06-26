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
  hist(pc$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")


# Save the plot to png file 
dev.copy(png,"./data/plot1.png", width=480, height=480) 
dev.off()
