library(readr)
data <- read_csv("country_vaccination_stats.csv")
View(data)

str(data)

data <- as.data.frame(data)
str(data)

#
library(readr)
library(dplyr)


#4
# Read the CSV file
data <- read_csv("country_vaccination_stats.csv")

# View the structure of the data
str(data)

# Convert data to a data frame
data <- as.data.frame(data)

# Calculate the minimum daily vaccination number per country
min_vaccinations <- data %>%
  filter(!is.na(daily_vaccinations)) %>%
  group_by(country) %>%
  summarise(min_daily_vaccinations = min(daily_vaccinations, na.rm = TRUE))

# Merge the minimum daily vaccination numbers back to the original data frame
data <- left_join(data, min_vaccinations, by = "country")

# Fill missing daily_vaccinations with the minimum daily vaccination number of relevant countries
data <- data %>%
  mutate(daily_vaccinations = if_else(is.na(daily_vaccinations), min_daily_vaccinations, daily_vaccinations),
         daily_vaccinations = replace_na(daily_vaccinations, 0)) %>%
  select(-min_daily_vaccinations)  # Remove the temporary column

# View the updated data frame
head(data)
















#5
median_vaccinations <- data %>%
  group_by(country) %>%
  summarise(median_daily_vaccinations = median(daily_vaccinations, na.rm = TRUE)) %>%
  arrange(desc(median_daily_vaccinations))

# List the top-3 countries with the highest median daily vaccination numbers
top_countries <- head(median_vaccinations, 3)

# Print the top-3 countries
print(top_countries)




#8
# Filter data for the specific date "1/6/2021" and calculate the sum
spec_date <- data %>%
  filter(date == "1/6/2021") %>%
  summarise(total_vaccinations = sum(daily_vaccinations, na.rm = TRUE))

# Display the total vaccinations for the specific date
spec_date






