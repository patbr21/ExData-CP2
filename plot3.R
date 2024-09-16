# explorative data analysis, course project2: plot3.R
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

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for 
# Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

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
emissions_baltimore <-
          summarySCC_PM25%>%
          filter(fips == 24510)%>%
          group_by(type, year)%>% #year is integer
          summarize(Emission_sum = sum(Emissions)) #emissions are numeric in tons
# ggplot
library(ggplot2)

png("plot3.png")
ggplot(emissions_baltimore, aes(x = year, y = Emission_sum, color = type))+geom_point(size =2)+geom_line()+theme_bw()+
          ylab(label = "Pm2.5 emissions in Baltimore City")
dev.off()
# Answer: The emission fell through time and type. POINT-Emissions were rising from 1999 to 2005 and is falling since.

