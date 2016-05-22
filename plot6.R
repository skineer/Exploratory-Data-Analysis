library(dplyr)
library(ggplot2)
library(sqldf)

setwd("C:\\Users\\Renato\\Desktop\\exdata-data-NEI_data")

## input data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## select vehicle emissions
colnames(SCC)[3] <- 'ShortName'
vehi <- sqldf("select distinct(SCC) from SCC where ShortName like '%vehicle%'")

#filter vehicle, baltimore city, and L.A
vehi_emi <- filter(NEI, SCC %in% as.vector(vehi$SCC))
vehi_balt <- filter(vehi_emi, fips == '24510')
vehi_la   <- filter(vehi_emi, fips == '06037')

#aggregate (group by) year and sum
agg_balt <- aggregate(vehi_balt$Emissions, list(vehi_balt$year), sum)
agg_la   <- aggregate(vehi_la$Emissions, list(vehi_la$year), sum)
agg_balt$City <- "Baltimore"
agg_la$City <- "Los Angeles"
colnames(agg_balt) <- c("year", "sum", "city")
colnames(agg_la) <- c("year","sum", "city")
agg <- rbind(agg_balt, agg_la)

#plot6
png(file = 'plot6.png')
ggplot(agg, aes(x = year, y = sum, colour = city)) + geom_line() +
        labs(title = "PM2.5 Vehicle Emissions by City Over the Years", 
         x = "Year", y = "PM2.5 Emissions (tons)")
dev.off()
