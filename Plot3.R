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

#Generating plot Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City
TotalBalCityEmissionByType <- aggregate(Emissions ~ year + type,NEIBalCity,sum)
png(filename = "plot3.png",width=480,height = 480,units = "px",pointsize = 12,bg="white")
x3 <- ggplot(TotalBalCityEmissionByType, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
        geom_bar(stat="identity") +
        facet_grid(. ~ type) +
        xlab("Year") +
        ylab(expression("total PM"[2.5]*" emission in tons")) +
        ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                           "City by various source types", sep="")))+
        geom_label(aes(fill = type), colour = "white", fontface = "bold")
print(x3)
dev.off()


