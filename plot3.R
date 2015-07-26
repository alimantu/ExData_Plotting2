#Reading data, loading the used librarys.
library(dplyr)
library(ggplot2)
data  <- readRDS("./summarySCC_PM25.rds")
dataSCC  <- readRDS("./Source_Classification_Code.rds")

#The subsetting data and plotting scrypt.
data$type  <- as.factor(data$type)
summary  <- data[data$fips == "24510",] %>%
    group_by(year, type) %>%
    summarise(emissions = sum(Emissions))
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
ggplot(data = summary, aes(x = year, y = emissions, col = type, fill = type))+
    geom_line()+
    geom_point()+
    xlab("Year")+
    ylab("Emissions (tons)")+
    ggtitle("PM2.5 emissions in Baltimore City by the source type")
dev.off()