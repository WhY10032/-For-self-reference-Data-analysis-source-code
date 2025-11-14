install.packages("dplyr")
library(dplyr)

tax <- read.csv("TAX_rate.csv")
summary(tax)
tax_v1 <- tax[ , c("Reference.area", "Transaction", "Unit.of.measure", "Level", "TIME_PERIOD", "OBS_VALUE")]
# eliminating redundant columns
summary(tax_v1)
tax_v2 <- tax_v1[tax_v1$Level != "Not applicable", ]
# eliminating redundant rows
temp1 = "Australia"
temp2 = "Australia"
j = 1
# initializing variables used for labeling
tax_sorted <- tax_v2[order(tax_v2$Reference.area), ]
rownames(tax_sorted) <- 1:nrow(tax_sorted)
# sorting tax_v2 by country names and rewriting the indexes
for(i in 1:length(tax_v2$OBS_VALUE)) {
  temp1 = tax_sorted$Reference.area[i]
  if(temp1 == temp2) {
    tax_sorted$ctyindex[i] = j
  }
  else {
    j = j + 1
    tax_sorted$ctyindex[i] = j
  }
  temp2 = tax_sorted$Reference.area[i]
}
# giving every country unique numeric label
tax_sorted$msindex <- ifelse(tax_sorted$Transaction == "Income threshold", 1, 0)
tax_v3 <- tax_sorted[order(tax_sorted$ctyindex, tax_sorted$TIME_PERIOD, tax_sorted$msindex, tax_sorted$Level), ]
rownames(tax_v3) <- 1:nrow(tax_v3)
# sorting tax_v2 and rewriting the indexes
tax_f <- as.data.frame(matrix(nrow = 950 , ncol = 6))
colnames(tax_f) <- c("country", "year", "incthrl", "incthrh", "marratel", "marrateh")
# creating dataframe where "incthrl" = income threshold low, "marrateh" = marginal tax rate high
temp_1 = 1
temp_2 = 2000
k = 1
i = 1

for(i in 1:nrow(tax_v3)) {
  if(tax_v3$ctyindex[i] == temp_1 & tax_v3$TIME_PERIOD[i] == temp_2) {
    if(tax_v3$msindex[i] == 1) {
      tax_f$incthrh[k] = tax_v3$OBS_VALUE[i]
    }
    else {
      tax_f$marrateh[k] = tax_v3$OBS_VALUE[i]
    }
  }
  else if(tax_v3$ctyindex[i] == temp_1 & tax_v3$TIME_PERIOD[i] != temp_2) {
    temp_2 = tax_v3$TIME_PERIOD[i]
    k = k + 1
    if(tax_v3$msindex[i] == 1) {
      tax_f$incthrh[k] = tax_v3$OBS_VALUE[i]
    }
    else {
      tax_f$marrateh[k] = tax_v3$OBS_VALUE[i]
    }
  }
  else if(tax_v3$ctyindex[i] != temp_1 & tax_v3$TIME_PERIOD[i] == temp_2) {
    temp_1 = tax_v3$ctyindex[i]
    k = k + 1
    if(tax_v3$msindex[i] == 1) {
      tax_f$incthrh[k] = tax_v3$OBS_VALUE[i]
    }
    else {
      tax_f$marrateh[k] = tax_v3$OBS_VALUE[i]
    }
  }
  else {
    temp_1 = tax_v3$ctyindex[i]
    temp_2 = tax_v3$TIME_PERIOD[i]
    k = k + 1
    if(tax_v3$msindex[i] == 1) {
      tax_f$incthrh[k] = tax_v3$OBS_VALUE[i]
    }
    else {
      tax_f$marrateh[k] = tax_v3$OBS_VALUE[i]
    }
  }
}
# iterating the value of temp, traversing every observation in tax_v3, and using rewrite
tax_v4 <- arrange(tax_sorted, ctyindex, TIME_PERIOD, msindex, desc(Level))
# reverse sorting
temp_1 = 1
temp_2 = 2000
k = 1
j = 1

for(j in 1:nrow(tax_v3)) {
  if(tax_v4$ctyindex[j] == temp_1 & tax_v4$TIME_PERIOD[j] == temp_2) {
    if(tax_v4$msindex[j] == 1) {
      tax_f$incthrl[k] = tax_v4$OBS_VALUE[j]
    }
    else {
      tax_f$marratel[k] = tax_v4$OBS_VALUE[j]
    }
  }
  else if(tax_v4$ctyindex[j] == temp_1 & tax_v4$TIME_PERIOD[j] != temp_2) {
    temp_2 = tax_v4$TIME_PERIOD[j]
    k = k + 1
    if(tax_v4$msindex[j] == 1) {
      tax_f$incthrl[k] = tax_v4$OBS_VALUE[j]
    }
    else {
      tax_f$marratel[k] = tax_v4$OBS_VALUE[j]
    }
  }
  else if(tax_v4$ctyindex[j] != temp_1 & tax_v4$TIME_PERIOD[j] == temp_2) {
    temp_1 = tax_v4$ctyindex[j]
    k = k + 1
    if(tax_v4$msindex[j] == 1) {
      tax_f$incthrl[k] = tax_v4$OBS_VALUE[j]
    }
    else {
      tax_f$marratel[k] = tax_v4$OBS_VALUE[j]
    }
  }
  else {
    temp_1 = tax_v4$ctyindex[j]
    temp_2 = tax_v4$TIME_PERIOD[j]
    k = k + 1
    if(tax_v4$msindex[j] == 1) {
      tax_f$incthrl[k] = tax_v4$OBS_VALUE[j]
    }
    else {
      tax_f$marratel[k] = tax_v4$OBS_VALUE[j]
    }
  }
}
k = 1
for(y in 1:38) {
  for(x in 2000:2024) {
    tax_f$year[k] = x
    tax_f$country[k] = head(tax_v3$Reference.area[tax_v3$ctyindex == y], n = 1)
    k = k + 1
  }
}
# writing year and country names
write.csv(tax_f, "C:/Users/wong6/OneDrive/Desktop/quantitative analysis/final_report/cleanedtax.csv", row.names=FALSE)

