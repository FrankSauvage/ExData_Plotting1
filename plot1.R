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
 write.csv(iris, "iris.csv", quote = FALSE, row.names = FALSE)
 data.cp1 <- read.csv.sql(file.path, sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", eol = "\n", sep=";")
 date.cp1 <- strptime(data.cp1$Date, "%d/%m/%Y")
 data.cp1$Date <- date.cp1
 summary(data.cp1)
 
 # Code for plot1 generation
 with(data.cp1,hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
 
 ## Copy my plot to a PNG file
 dev.copy(png, file = "plot1.png") #default is an image of 480*480 pixels
 # or the following function: png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = NA, restoreConsole = TRUE)
 ## Don't forget to close the PNG device!
 dev.off()