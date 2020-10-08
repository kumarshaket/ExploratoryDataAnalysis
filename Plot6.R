#load libraries 
library(ggplot2)
library(dplyr)

# unzip zip file to specified folder
unzip(zipfile = "/Users/kumarshaket/Downloads/exdata_data_NEI_data.zip",exdir = "/Users/kumarshaket/Desktop/Coursera/datafiles")

#Read Source Classification Code Table
NEI <- readRDS("/Users/kumarshaket/Desktop/Coursera/datafiles/summarySCC_PM25.rds")
SCC <- readRDS("/Users/kumarshaket/Desktop/Coursera/datafiles/Source_Classification_Code.rds")

#Subset NEI table to get Baltimore and Los Angeles City Data (fip == "24510" & Type= Road)
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
#Generating plot to compare Baltimore and Los Angeles PM2.5 Emission On Road
aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"
png(filename = "plot6.png",width=480,height = 480,units = "px",pointsize = 12,bg="white")
g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()


