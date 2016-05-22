library(dplyr)
library(ggplot2)

setwd("C:\\Users\\Renato\\Desktop\\exdata-data-NEI_data")

## input data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter only Baltimore city
NEI_Balt <- filter(NEI, fips == "24510")

#aggregate (group by) year and sum
agg <- aggregate(NEI_Balt$Emissions, list(NEI_Balt$year, NEI_Balt$type), sum)
colnames(agg) <- c("year", "type", "sum")

#plot3
png(file = 'plot3.png')
ggplot(agg, aes(x = year, y = sum, colour = type)) + geom_line() + 
    labs(title = "PM2.5 Emissions by Type Over the Years in Baltimore City", 
         x = "Year", y = "PM2.5 Emissions (tons)")
dev.off()
