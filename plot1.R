# explorative data analysis, course project2: plot1.R
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
summarySCC_PM25 <- readRDS("~/Rstudio/Coursera/Explorative Datenanalyse CP2/summarySCC_PM25.rds")
Source_Classification_Code <- readRDS("~/Rstudio/Coursera/Explorative Datenanalyse CP2/Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008. 
# Upload a PNG file containing your plot addressing this question.

# first, have a look at the data
head(summarySCC_PM25)
str(summarySCC_PM25)
table(summarySCC_PM25$year) # we have the years 1999,2002,2005 and 2008
names(summarySCC_PM25)
# do we have NAs at the data?
any(is.na(summarySCC_PM25$Emissions)) # no NAs at emissions
any(is.na(summarySCC_PM25)) # and no NAs overall, perfect!
# summarize the total emmissions by year
library(dplyr)
emissions_total <-
          summarySCC_PM25%>%group_by(year)%>% #year is integer
          summarize(Emission_sum = sum(Emissions)) #emissions are numeric in tons
#plot device
png("plot1.png")
#plot w/o axis
plot(emissions_total$year, emissions_total$Emission_sum, type="b", xaxt="n", yaxt="n", 
     xlab="Year", ylab="Pm 2.5 emission in [t]")

# x-axis
axis(1, at = emissions_total$year, labels = emissions_total$year)

# y-axis
axis(2, at = pretty(emissions_total$Emission_sum), 
     labels = format(pretty(emissions_total$Emission_sum), big.mark = ","))
dev.off()

