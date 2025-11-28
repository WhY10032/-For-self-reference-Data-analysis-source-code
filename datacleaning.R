library("tidyverse")
library("reshape2")
library("readxl")

#---------------process TAX
tax <- read.csv("TAX_rate.csv")
summary(tax)
tax.sub <- subset(tax, select = c("Reference.area", "Transaction", "Level", "TIME_PERIOD", "OBS_VALUE"),
                  subset = (Level != "Not applicable"))
# eliminating redundant columns and rows
colnames(tax.sub)
tax.short <- dcast(tax.sub, Reference.area + TIME_PERIOD ~ Transaction + Level)
# convert to short dataframe
write.csv(tax.short, "C:/Users/wong6/OneDrive/Desktop/quantitative analysis/final_report/tax_short.csv", row.names = FALSE)

seq.inc <- seq(3, 24)
seq.rate <- seq(25, 47)

for(i in 1:nrow(tax.short)) {
  tax.inc.temp <- unlist(tax.short[i, seq.inc])
  tax.rate.temp <- unlist(tax.short[i, seq.rate])
  tax.short$inc.thr.l[i] <- min(tax.inc.temp, na.rm = T)
  tax.short$inc.thr.h[i] <- max(tax.inc.temp, na.rm = T)
  tax.short$mar.rate.l[i] <- min(tax.rate.temp, na.rm = T)
  tax.short$mar.rate.h[i] <- max(tax.rate.temp, na.rm = T)
}
# extract highest and lowest income threshold and marginal rate
tax.final <- subset(tax.short, select = c("Reference.area", "TIME_PERIOD",
                                    "inc.thr.l", "inc.thr.h",
                                    "mar.rate.l", "mar.rate.h"))

write.csv(tax.final, "C:/Users/wong6/OneDrive/Desktop/quantitative analysis/final_report/tax_cleaned.csv", row.names = FALSE)

#---------process GINI
gini <- read.csv("gini.csv")
colnames(gini)
year <- 1960:2024
c <- c("Country.Name","A","B","C", year)
colnames(gini) <- c
year1 <- 2000:2024
c1 <- c("Country.Name", year1)
ctyname <- c("Australia","Austria","Belgium","Canada","Chile","Colombia","Costa Rica",
              "Czechia","Denmark","Estonia","Finland","France","Germany","Greece",
              "Hungary","Iceland","Ireland","Israel","Italy","Japan","Latvia","Lithuania",
              "Luxembourg","Mexico","Netherlands","New Zealand","Norway","Poland","Portugal",
              "Slovak Republic","Slovenia","Korea, Rep.","Spain","Sweden","Switzerland",
              "Turkiye","United Kingdom","United States")
#note that the standard states names used by OECD is different from the ones used by World Bank
gini.sub <- subset(gini, select = c1, subset = (Country.Name %in% ctyname))
gini.sub$Country.Name[24] <- "Korea"
gini.sub$Country.Name[37] <- "Türkiye"
#manually standardize the state names
gini.long <- melt(gini.sub, id = c("Country.Name"), value.name = "gini")
gini.long <- arrange(gini.long, by = Country.Name)
gini.long$variable <- as.integer(gini.long$variable) + 1999

#----------------process SOCIAL BENEFIT, etc.
ppp <- read_excel("PPP.xlsx")
soc <- read_excel("socialbenefit.xlsx")
gdppcap <- read_excel("GDPpercapita_PPP.xlsx")
# note that in soc, Chile's data were lost
soc[38, 1] <- "Chile"
soc <- arrange(soc, by = ctynames)
ppp.long <- melt(ppp, id = c("ctynames"), value.name = "ppp")
ppp.long <- arrange(ppp.long, by = ctynames)
ppp.long$variable <- as.integer(ppp.long$variable) + 1999
soc.long <- melt(soc, id = c("ctynames"), value.name = "soc")
soc.long <- arrange(soc.long, by = ctynames)
soc.long$variable <- as.integer(soc.long$variable) + 1999
gdppcap.long <- melt(gdppcap, id = c("ctynames"), value.name = "gdppcap")
gdppcap.long <- arrange(gdppcap.long, by = ctynames)
gdppcap.long$variable <- as.integer(gdppcap.long$variable) + 1999

#-----------------merge datasets
colnames(gini.long)[1] <- "ctynames"
colnames(tax.final)[c(1, 2)] <- c("ctynames", "variable")

dflist <- list(tax.final, gini.long, soc.long, ppp.long, gdppcap.long)
tax.ffinal <- reduce(dflist, full_join, by = c("ctynames", "variable"))
colnames(tax.ffinal)[2] <- "year"

write.csv(tax.ffinal, "C:/Users/wong6/OneDrive/Desktop/quantitative analysis/final_report/tax_final.csv", row.names = FALSE)


