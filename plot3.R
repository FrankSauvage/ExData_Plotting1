# Exploratory Data Analysis JHU Course 4

 #For me: setwd("D:/Statsphere/Formation_DataScience/Exploratory_Data_Analysis")
 
 ## Data acquisition
 if(!file.exists("data")) dir.create("data")              # create a folder for data
 
 if(!file.exists("data/data_course_project_1.zip")){
         download.file(
                 "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                 destfile="./data/data_course_project_1.zip")      
 }
 
 #Unzip the file in the data directory
 unzip("./data/data_course_project_1.zip", exdir="./data")
 
 #Create the path to access the unzipped .txt data file
 name.file <- grep("txt",list.files("./data"), value = T)
 file.path <- paste("./data", name.file,sep="/")
 
 #Read the data file, only the relevant data from 01/02/2007 to 02/02/2007. To read according to a condition only, see http://stackoverflow.com/questions/23197243/how-do-i-read-only-lines-that-fulfil-a-condition-from-a-csv-into-r
 #any(grepl("sqldf", installed.packages())) #check if package sqldf is installed on the computer
 library(sqldf)
 data.cp1 <- read.csv.sql(file.path, sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", eol = "\n", sep=";")
 
 # Generate the x coordinates, which require the Date and Time columns from the dataset. I paste both strings and use strptime to get the accurate abscissa date.cp1
 date.cp1 <- strptime(paste(data.cp1$Date,data.cp1$Time, sep="/"), "%d/%m/%Y/%H:%M:%S", tz = "GMT")
 summary(date.cp1)
 
 # Code for plot3 generation
 # IMPORTANT NOTE: MY RStudio CONFIGURATION USE THE FRENCH NAMES FOR WEEK DAYS, I didn't find an easy way to change the French weekdays abbreviations to the English ones...
  with(data.cp1,{
         plot(date.cp1, Sub_metering_1, type="l", col="black", main="", xlab="", ylab="Energy sub metering")
         lines(date.cp1, Sub_metering_2, col="red")
         lines(date.cp1, Sub_metering_3, col="blue")
         legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=rep(1,3), cex=0.8, y.intersp = 0.6)
         })
  
 ## Copy my plot to a PNG file
 dev.copy(png, file = "plot3.png") #default is an image of 480*480 pixels
 ## close the PNG device
 dev.off()