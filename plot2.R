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
 
 # Generate the x coordinates, which require the Date and Time columns from the dataset (day and time in the day respectively). I paste both strings and use strptime to get the accurate abscissa date.cp1
 date.cp1 <- strptime(paste(data.cp1$Date,data.cp1$Time, sep="/"), "%d/%m/%Y/%H:%M:%S")
 summary(date.cp1)
 
 # Code for plot2 generation
 with(data.cp1,plot(date.cp1, Global_active_power, type="l", col="black", main="", xlab="", ylab="Global Active Power (kilowatts)"))
  # IMPORTANT NOTE: MY RStudio CONFIGURATION USE THE FRENCH NAMES FOR WEEK DAYS, SO 
  # "jeu." stands for "Thu"
  # "ven." for "Fri"
  # "sam." for "Sat"
  # I suppressed x labelling with the argument (xaxt = "n") in plot() and tried axis(1, at=  seq(1,3), labels=c("Thu","Fri","Sat")) to put the English labels, but it didn't work, no x-names appeared... 
  # I tried different options with axis.Date(), with no more success 
  # I also tried Sys.setenv(LANG = "en") but it didn't change the language for the weekdays names...
  # so I kept the French ones, hope you won't mind!
 
 ## Copy my plot to a PNG file
 dev.copy(png, file = "plot2.png") #default is an image of 480*480 pixels
 ## close the PNG device
 dev.off()