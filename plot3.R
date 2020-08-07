#read in emission data and classification code 
emissions_data <- readRDS("summarySCC_PM25.rds")
class_code <- readRDS("Source_Classification_Code.rds")

#subset to just data from Baltimore and then add up emission for each year
baltimore_data <- subset(emissions_data, emissions_data$fips == "24510")
baltimore_type_year <- aggregate(baltimore_data$Emissions, by=list(baltimore_data$type, baltimore_data$year), FUN=sum)
colnames(baltimore_type_year) <- c("Type", "Year", "Emissions")

#Create plot with ggplot2
library(ggplot2)
png(filename = "plot3.png")
qplot(Year, Emissions, data = baltimore_type_year, color = Type, geom = "line") +
  ggtitle("Total Emission of PM2.5 in Baltmore City by pollutant type") +
  ylab("Total Emission (tons)")+
  xlab("Year")
dev.off()
