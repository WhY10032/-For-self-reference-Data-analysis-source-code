## 1. Data Collection, Cleaning and Merging

### 1.1 Data Source

- Organisation for Economic Co-operation and Development. (2025). NAAG Chapter 6: Government – Social benefits other than social transfers in kind (Percentage of GDP) [Data set]. OECD Data Explorer. https://data-explorer.oecd.org/vis

- Organisation for Economic Co-operation and Development. (2025). Annual Purchasing Power Parities and exchange rates - Purchasing Power Parities for GDP [Data set]. OECD Data Explorer. https://data-explorer.oecd.org/vis

- Organisation for Economic Co-operation and Development. (2025). Quarterly GDP per capita - Gross domestic product, per capita, Total economy (Current prices, Annual levels, Calendar and seasonally adjusted, US dollars per person, PPP converted) [Data set]. OECD Data Explorer. https://data-explorer.oecd.org/vis

- Organisation for Economic Co-operation and Development. (2025). Personal income tax (PIT) - central government rates and thresholds (Percentage of taxable income; National currency) [Data set]. OECD Data Explorer. https://data-explorer.oecd.org/vis

- World Bank. (2025). Gini index [Data set]. World Bank. https://data.worldbank.org/indicator/SI.POV.GINI

### 1.2 Data Cleaning and Merging

Data from OECD (Organisation for Economic Co-operation and Development) consist of observations from 38 member countries of OECD while data from World Bank include observations from more countries and regions (266). Similarly, data from World Bank cover a much broader range of time than data from OECD.

The data cleaning and merging procedures are as follows:

1. Eliminate redundant rows and columns which are irrelevant to the study
2. Sort the data by country names, year and other variables
3. Standardize the country names
4. Rearrange data to increase readability
5. Merge all data into one dataframe
6. export data in csv format (including intermediate data)

### 1.3 Variables and Description

| Variable | Description                                                                                                                                 |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| country  | Country name (all OECD members)[^1]                                                                                                         |
| year     | Year, from 2000 to 2024                                                                                                                     |
| incthrl  | The <u>l</u>owest <u>inc</u>ome <u>thr</u>eshold where the lowest marginal personal income tax rate first applies, in national currency.    |
| inctheh  | The <u>h</u>ighest <u>inc</u>ome <u>thr</u>eshold where the highest  marginal personal income tax rate first applies, in national currency. |
| marratel | The <u>l</u>owest <u>mar</u>ginal personal income tax <u>rate</u> in a progressive taxation system, percentage of taxable income            |
| marrateh | The <u>h</u>ighest <u>mar</u>ginal personal income tax <u>rate</u> in a progressive taxation system, percentage of taxable income           |
| gini     | Gini Index, from 1 to 100                                                                                                                   |
| socbene  | <u>Soc</u>ial <u>bene</u>fits other than social transfers in kind, current base,  percentage of GDP                                         |
| ppp      | Purchasing Power Parity relative to US dollars                                                                                              |
| gdppcap  | <u>GDP</u> <u>p</u>er <u>cap</u>ita, current base, calendar and seasonally adjusted, in PPP-adjusted US dollars                             |

[^1]:
    Including Australia, Austria, Belgium, Canada, Chile, Colombia, Costa Rica, Czechia, Denmark, Estonia, Finland, France, Germany, Greece, Hungary, Iceland, Ireland, Israel, Italy, Japan, Latvia, Lithuania, Luxembourg, Mexico, Netherlands, New Zealand, Norway, Poland, Portugal, Slovakia, Slovenia, South Korea, Spain, Sweden, Switzerland, Turkey, United Kingdom, United States
    
    In this dataset, Czechia is spelled as "Czechia" rather than "Czech Republic", South Korea is spelled as "Korea" rather than "South Korea", Turkey is spelled as "Turkiye" rather than "Turkey".
