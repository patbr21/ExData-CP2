# explorative data analysis, course project2: plot4.R
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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
summary(Source_Classification_Code)
table(Source_Classification_Code$SCC.Level.One)
View(Source_Classification_Code)

# By viewing the data I found, that in the column "EI Sector" the words "coal" and "combustion" ("comb") appear in combination, since Im no expert
# with energy data. I think that's what we are looking for.
# we grep everythig that includes "coal" & "comb" in the cell from out data
coalcomb <- grepl("coal", Source_Classification_Code$EI.Sector, ignore.case=TRUE) & grepl("comb", Source_Classification_Code$EI.Sector, ignore.case=TRUE)
filtered_SCC <- Source_Classification_Code[coalcomb, ]
head(filtered_SCC)

#now we take the SSC codes and match the pm25 data.
head(summarySCC_PM25)
new_pm25 <- summarySCC_PM25[which(summarySCC_PM25$SCC %in% filtered_SCC$SCC),]
toplot<- new_pm25%>%
          group_by(year)%>% #year is integer
          summarize(Emission_sum = sum(Emissions)) #emissions are numeric in tons
# make the plot
png("plot4.png")
plot(toplot, ylab = "US-Emissions from combusion & coal [t]", xlab = "Year")
lines(toplot)
dev.off()

# Answer: The emissions fell from like 55000 t in 1999 to 35000 t in 2008
