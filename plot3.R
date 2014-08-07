require("ggplot2")
# check files
if(!file.exists("Source_Classification_Code.rds") || !file.exists("summarySCC_PM25.rds")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata-data-NEI_data.zip")
  unzip("exdata-data-NEI_data.zip")
}
#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases 
#in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
generatePlot3<- function(NEI,SCC){
  baltimore <- NEI[NEI$fips== "24510",]
  aggr <- aggregate(baltimore$Emissions, by=list(baltimore$year,baltimore$type), FUN=sum)
  colnames(aggr) <- c("Year", "Type", "Emission")
  p <- ggplot(aggr, aes(Year, Emission))
  p + aes(shape = factor(Type)) + geom_point(aes(colour=factor(Type)),size=5) + stat_smooth(method="lm",se=FALSE,aes(colour=factor(Type)))
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot3.png")
generatePlot3(NEI,SCC)
dev.off()