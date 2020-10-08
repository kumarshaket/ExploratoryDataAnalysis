#load libraries 
library(ggplot2)
library(dplyr)

# unzip zip file to specified folder
unzip(zipfile = "/Users/kumarshaket/Downloads/exdata_data_NEI_data.zip",exdir = "/Users/kumarshaket/Desktop/Coursera/datafiles")

#Read Source Classification Code Table
NEI <- readRDS("/Users/kumarshaket/Desktop/Coursera/datafiles/summarySCC_PM25.rds")
SCC <- readRDS("/Users/kumarshaket/Desktop/Coursera/datafiles/Source_Classification_Code.rds")

#Subset NEI table to get Baltimore City Data (fip == "24510")

NEIBalCity <- subset(NEI,NEI$fips=="24510")

#Generating plot for 2.5 total emission year on year for Baltimore City
TotalBalCityEmission <- aggregate(Emissions ~ year,NEIBalCity,sum)
png(filename = "plot2.png",width=480,height = 480,units = "px",pointsize = 12,bg="white")
x2 <- barplot(height = TotalBalCityEmission$Emissions,names.arg = TotalBalCityEmission$year,xlab = "Years",ylab = "Total PM 2.5 Emission in tons",ylim = c(0,4000),col=c("#B2182B", "#F4A582","#D1E5F0","#4393C3"))
text(x=x2, y=1000, labels=round(TotalBalCityEmission$Emission,2) , xpd=TRUE, srt=90)
dev.off()
