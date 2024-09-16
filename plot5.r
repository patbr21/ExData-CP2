# explorative data analysis, course project2: plot5.R
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

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# summarize the total emmissions by year
library(dplyr)
# get only data from baltimore city
emissions_baltimore <-
          summarySCC_PM25%>%
          filter(fips == 24510)

head(summarySCC_PM25)
head(Source_Classification_Code)
View(Source_Classification_Code)

# By viewing the data I found, that in the column "EI-Sector" the words "vehicle" appears in combination with e.g. Gasoline or Diesel, since I'm no expert
# with energy data. I think that's what we are looking for.
motorvehicle <- grepl("vehicle", Source_Classification_Code$EI.Sector, ignore.case=TRUE)
filtered_SCC <- Source_Classification_Code[motorvehicle, ]

head(filtered_SCC)

#now we take the SSC codes and match the pm25 data.
head(summarySCC_PM25)
new_pm25 <- summarySCC_PM25[which(summarySCC_PM25$SCC %in% filtered_SCC$SCC),]
toplot<- new_pm25%>%
          group_by(year)%>% #year is integer
          summarize(Emission_sum = sum(Emissions)) #emissions are numeric in tons
# make the plot
png("plot5.png")
plot(toplot, ylab = "US-Emissions from vehicles in Baltimore City [t]", xlab = "Year")
lines(toplot)
dev.off()

# Answer: The emissions fell from like 18k tons to under 12k.


