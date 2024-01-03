

```r
# Purpose:			Imports data from Covid-19 API on gov.uk
# Created by:   Cox, Graham
# Created on:   2024-01-02

# Load functions from external file
source("00_library_load.R")

# Load libraries via function
library_load()
```

```
## Loading required package: pacman
```

```
## Warning: package 'pacman' was built under R version 4.2.2
```

```r
# Load Data ----

# Create URL
url <-
	"https://api.coronavirus.data.gov.uk/v2/data?areaType=utla&metric=newOnsDeathsByRegistrationDate&metric=newCasesBySpecimenDate&format=csv"

# Download data from gov.uk API
df <-
	read_csv(url) %>% janitor::clean_names()
```

```
## Rows: 286467 Columns: 6
```

```
## ── Column specification ─────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (3): areaCode, areaName, areaType
## dbl  (2): newCasesBySpecimenDate, newOnsDeathsByRegistrationDate
## date (1): date
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
# Load area names to mark areas as in North East England from the main gov.uk dataset
areas <- area_load()

# Transform Data ----

# Transform data into the required format

df <- df %>%

	# drop third variable in dataset
	select(-3) %>%

	mutate(

		# Add variable to identify country based on first letter of area_code variable.
		country = case_when(
			substr(area_code, 1, 1) == "S" ~ "Scotland",
			substr(area_code, 1, 1) == "W" ~ "Wales",
			TRUE ~ "England"
		),

		# Add variable to identify those areas in the North East of England
		north_east = ifelse(area_name %in% areas, TRUE, FALSE),

		# Add week start variable
		week_start = floor_date(date, unit = "week")
	)

# Save to csv file
write_csv(df, file = "data.csv")
```

