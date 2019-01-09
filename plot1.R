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
g<-ggplot(df,aes(Global_active_power))+
  geom_histogram( color= "black",fill="red",bins = 19)+
  ylab("Frequency")+xlab("Global Active Power (kilowatts)")+
  scale_x_continuous(breaks=seq(0, 6, 2))+
  scale_y_continuous(breaks=seq(0, 1200, 200))

#plot using base package
windows()
hist(df$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col = "red", border = "Black", ylim = c(0,1200))
dev.copy(png, "plot1.png")
dev.off()
