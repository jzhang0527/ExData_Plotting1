#set working directory
setwd("C:\\Users\\C018313\\Desktop\\Rweekly\\Coursera\\EDA\\Week1")

#load data to have column names saved
colname<- unlist(strsplit(
  readLines("exdata_household_power_consumption\\household_power_consumption.txt", n=1),
  split = ';'))

#load in the actual data, subsetting the data for only two days from 2/1 to 2/1 in 2007
df <- read.table("exdata_household_power_consumption\\household_power_consumption.txt",
                 skip=grep("1/2/2007", readLines("exdata_household_power_consumption\\household_power_consumption.txt"))[1]-1,
                 nrows=2880, header = F, sep = ';',
                 col.names = colname)

#check the structure of the loaded data
str(df) #Date and Time column data types are not properly set
#Re-set data types for Date and Time column
df$Date_Time <- paste(df$Date, df$Time, sep = " ")
Time <- as.POSIXct(df$Date_Time, format = "%d/%m/%Y %H:%M:%OS")
df$Date_Time <- Time

#install.packages("ggplot2")
#plot using ggplot
library(ggplot2)
g<-ggplot(df,aes(Date_Time, Global_active_power))+
  geom_line()+ylab("Global Active Power (kilowatts)")+
  xlab("")+
  scale_x_datetime(breaks = as.POSIXct(c("2007-02-01 00:00:00",
                                         "2007-02-02 00:00:00",
                                         "2007-02-02 23:59:00"), 
                            format = "%Y-%m-%d %H:%M:%OS"), 
                            labels = c("Thu","Fri","Sat"))

#plot using base package
windows()
plot(df$Date_Time,df$Global_active_power, xlab="",
     ylab="Global Active Power (kilowatts)",typ="l")
dev.copy(png, "plot2.png")
dev.off()
