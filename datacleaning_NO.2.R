library(dplyr)

gini <- read.csv("API_SI.POV.GINI_DS2_en_csv_v2_216053.csv")
code <- rep(1960:2024)
code2 <- rep(2000:2024)
c <- c("ctyname", "a", "b", "c", code)
colnames(gini) <- c
c1 <- c("ctyname", code2)
gini_v1 <- gini[c1]
# eliminating redundant columns
ctynames <- c("Australia","Austria","Belgium","Canada","Chile","Colombia","Costa Rica",
              "Czechia","Denmark","Estonia","Finland","France","Germany","Greece",
              "Hungary","Iceland","Ireland","Israel","Italy","Japan","Latvia","Lithuania",
              "Luxembourg","Mexico","Netherlands","New Zealand","Norway","Poland","Portugal",
              "Slovak Republic","Slovenia","Korea, Rep.","Spain","Sweden","Switzerland","Turkiye","United Kingdom","United States")
# members of OECD
tax <- read.csv("cleanedtax.csv")
ctynames1 <- sort(ctynames)
ctynames1
gini_sorted <- arrange(gini_v1, ctyname)
# all sorted by country names
k = 1
j = 1
# 1<k<950, 1<j<38
for(i in 1:266) {
  if(gini_sorted$ctyname[i] == ctynames1[j]) {
    print(gini_sorted$ctyname[i] == ctynames1[j])
    for(l in 2:26) {
      tax$gini[k] <- gini_sorted[i, l]
      k = k + 1
    }
    j = j + 1
  }
}
write.csv(tax, "C:/Users/wong6/OneDrive/Desktop/quantitative analysis/final_report/cleanedtax_withgini.csv", row.names=FALSE)




