install.packages("readxl")
library("dplyr")
library("readxl")

ppp <- read_excel("PPP.xlsx")
soc <- read_excel("socialbenefit.xlsx")
gdppcap <- read_excel("GDPpercapita_PPP.xlsx")
tax <- read.csv("cleanedtax_withgini.csv")
comple <- rep(1:25)
for(x in 1:25) {
  comple[x] = NA
}
comple1 <- c(37, comple)
soc <- rbind(comple1, soc)
soc$ctynames[1] <- "Chile"
summary(soc)
# Chile is not in the dataframe
# create a new row where values are all NAs
soc_s <- arrange(soc, ctynames)
ppp_s <- arrange(ppp, ctynames)
gdppcap_s <- arrange(gdppcap, ctynames)
# sort
summary(gdppcap_s)
k = 1
for(i in 1:38) {
  for(j in 2:26) {
    if(tax$country[k] == "T??rkiye") {
      tax$country[k] = "Turkiye"
    }
    tax$socbene[k] <- soc_s[i, j]
    tax$ppp[k] <- ppp_s[i, j]
    tax$gdppcap[k] <- gdppcap_s[i, j]
    k = k + 1
  }
}
# adjust the name of Türkiye to "Turkiye"
typeof(tax$socbene)
tax$socbene <- unlist(tax$socbene)
tax$ppp <- unlist(tax$ppp)
tax$gdppcap <- unlist(tax$gdppcap)
# for mysterious reasons the type of socbene, ppp & gdppcap became list, so we have to undo that using unlist()
summary(tax)
write.csv(tax, "C:/Users/wong6/OneDrive/Desktop/quantitative analysis/final_report/finaltax.csv", row.names=FALSE)



