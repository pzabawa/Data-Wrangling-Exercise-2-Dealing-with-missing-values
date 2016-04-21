getwd()
setwd('Downloads')
getwd()
titanicdata = read.csv('titanic_original.csv')
titanicdata
colnames(titanicdata)
titanicdata$embarked
library(dplyr)
titanicdata$embarked = as.character(titanicdata$embarked)
titanicdataFilledEmbarkedEmptyWithS <- titanicdata %>%
  mutate(embarked = ifelse(embarked == '', 'S', embarked))
titanicdataFilledEmbarkedEmptyWithS$embarked
titanicdataAgeRowsOnly <- filter(titanicdataFilledEmbarkedEmptyWithS, age != '')
titanicdataAgeMean <- mean(titanicdataAgeRowsOnly$age)
titanicdataFilledAgeWithMeanAge <- titanicdataFilledEmbarkedEmptyWithS %>%
  mutate(age = ifelse(is.na(age), titanicdataAgeMean, age))
titanicdataFilledAgeWithMeanAge$age
titanicdataFilledEmptyBoatWithNA <- titanicdataFilledAgeWithMeanAge %>%
  mutate(boat = ifelse(boat == '', NA, boat))
titanicdataFilledEmptyBoatWithNA$boat
titanicdataAddedHasCabinNumber <-  titanicdataFilledEmptyBoatWithNA %>%
  mutate(has_cabin_number = ifelse(cabin == '', 0, 1))
titanicdataAddedHasCabinNumber$has_cabin_number
write.csv(titanicdataAddedHasCabinNumber, file = "titanic_clean.csv")