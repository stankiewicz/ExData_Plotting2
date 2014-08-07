# check files
if(!file.exists("Source_Classification_Code.rds") || !file.exists("summarySCC_PM25.rds")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata-data-NEI_data.zip")
  unzip("exdata-data-NEI_data.zip")
}
#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question..
generatePlot2<- function(NEI,SCC){
  baltimore <- NEI[NEI$fips== "24510",]
  aggr <- aggregate(baltimore$Emissions, by=list(baltimore$year), FUN=sum)
  barplot(aggr$x,beside=FALSE, names = aggr$Group.1, xlab = "Year", ylab= "Total emission")
  abline(lm(aggr$Group.1~aggr$x), col="red")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot2.png")
generatePlot2(NEI,SCC)
dev.off()