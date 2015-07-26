#Reading data, loading the used librarys.
library(dplyr)
library(ggplot2)
library(data.table)
data  <- readRDS("./summarySCC_PM25.rds")
dataSCC  <- readRDS("./Source_Classification_Code.rds")

#The subsetting data and plotting scrypt.
data$Pollutant  <- as.factor(data$Pollutant)
data$year  <-  as.factor(data$year)
dataVehiclesSCC  <- filter(dataSCC, EI.Sector %like% "Vehicles")
dataVehicles  <- data[data$SCC %in% dataVehiclesSCC$SCC,]
summary  <- dataVehicles[dataVehicles$fips %in% c("24510", "06037"),] %>%
    group_by(year, fips) %>%
    summarise(emissions = sum(Emissions))
summary  <- mutate(summary, Location = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))
png(filename = "plot6.png", width = 480, height = 480, units = "px", bg = "transparent")
ggplot(data = summary, aes(x = year, y = emissions, col = Location, group = Location))+
    geom_line() +
    geom_point() +
    xlab("Year") + 
    ylab("Emissions (tons)") + 
    ggtitle("PM2.5 emissions from motor vehicle sources in USA")
dev.off()