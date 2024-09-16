# explorative data analysis, course project2: plot6.R
# Copyright (C) [2015] [patbr21]
# All rights reserved.

# 1. Permission is granted to use, copy, modify, and distribute this code for any purpose, 
#    provided that the original author is clearly credited.
#
# 2. Commercial use of this code is strictly prohibited without prior written permission 
#    from the author.
#
# 3. This code is provided "as is", without warranty of any kind, express or implied. The author 
#    is not liable for any damages or losses that may arise from the use of this code.
#
# 4. By using this code, you agree to these terms.

#--------
# read the data
summarySCC_PM25 <- readRDS("~/Rstudio/Coursera/Explorative Datenanalyse CP2/summarySCC_PM25.rds")
Source_Classification_Code <- readRDS("~/Rstudio/Coursera/Explorative Datenanalyse CP2/Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037)
# Which city has seen greater changes over time in motor vehicle emissions?# summarize the total emmissions by year
library(dplyr)
# get only data from baltimore city and california
sum(summarySCC_PM25$fips == "06037") # 9320 data from california
sum(summarySCC_PM25$fips == "24510") # 9320 data from baltimore
emissions_baltimore_california <-
          summarySCC_PM25%>%
          filter(fips %in% c("24510","06037"))

#now we take the SSC codes and match the pm25 data.
toplot <- emissions_baltimore_california%>%
          group_by(year, fips)%>% #year is integer
          summarize(Emission_sum = sum(Emissions)) #emissions are numeric in tons
# make the plot
png("plot6.png")
plot(toplot$year,y=toplot$Emission_sum, pch = 19, col = factor(toplot$fips), ylab = "US-Emissions in Florida and Baltimore City [t]", xlab = "Year")
legend("topright",
       legend = c("PM25 Los Angeles County", "PM25 Baltimore"),
       pch = 19,
       col = factor(factor(toplot$fips)))
lapply(split(toplot, toplot$fips), function(sub_data) {
          lines(sub_data$year, sub_data$Emission_sum, col = factor(sub_data$fips))
})
dev.off()

# Answer: Florida clearly has the greater changes over time.


