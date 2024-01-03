

```r
# Purpose:			Imports data from Covid-19 API on gov.uk
# Created by:   Cox, Graham
# Created on:   2024-01-02

# Load functions from external file
source("00_library_load.R")

# Load libraries via function
library_load()

# Load Data ----

# Create URL
url <-
	"https://api.coronavirus.data.gov.uk/v2/data?areaType=utla&metric=newOnsDeathsByRegistrationDate&metric=newCasesBySpecimenDate&format=csv"

# Download data from gov.uk API
df <-
	read_csv(url, show_col_types = FALSE) %>% janitor::clean_names()

head(df, 10)
```

```
## # A tibble: 10 × 6
##    area_code area_name                area_type date       new_cases_by_specime…¹
##    <chr>     <chr>                    <chr>     <date>                      <dbl>
##  1 W06000023 Powys                    utla      2023-12-13                      0
##  2 E06000003 Redcar and Cleveland     utla      2023-12-12                      1
##  3 E06000014 York                     utla      2023-12-12                      3
##  4 E06000050 Cheshire West and Chest… utla      2023-12-12                      4
##  5 E08000001 Bolton                   utla      2023-12-12                      3
##  6 E08000016 Barnsley                 utla      2023-12-12                      0
##  7 E08000031 Wolverhampton            utla      2023-12-12                      2
##  8 E08000032 Bradford                 utla      2023-12-12                      9
##  9 E09000018 Hounslow                 utla      2023-12-12                      1
## 10 E09000032 Wandsworth               utla      2023-12-12                      1
## # ℹ abbreviated name: ¹​new_cases_by_specimen_date
## # ℹ 1 more variable: new_ons_deaths_by_registration_date <dbl>
```

```r
# Load area names to mark areas as in North East England from the main gov.uk dataset
areas <- area_load()

str(areas)
```

```
##  chr [1:12] "Hartlepool" "Middlesbrough" "Redcar and Cleveland" ...
```

```r
areas
```

```
##  [1] "Hartlepool"           "Middlesbrough"        "Redcar and Cleveland"
##  [4] "Stockton-on-Tees"     "Darlington"           "County Durham"       
##  [7] "Northumberland"       "Newcastle upon Tyne"  "North Tyneside"      
## [10] "South Tyneside"       "Sunderland"           "Gateshead"
```

```r
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

head(df, 10)
```

```
## # A tibble: 10 × 8
##    area_code area_name   date       new_cases_by_specime…¹ new_ons_deaths_by_re…²
##    <chr>     <chr>       <date>                      <dbl>                  <dbl>
##  1 W06000023 Powys       2023-12-13                      0                     NA
##  2 E06000003 Redcar and… 2023-12-12                      1                     NA
##  3 E06000014 York        2023-12-12                      3                     NA
##  4 E06000050 Cheshire W… 2023-12-12                      4                     NA
##  5 E08000001 Bolton      2023-12-12                      3                     NA
##  6 E08000016 Barnsley    2023-12-12                      0                     NA
##  7 E08000031 Wolverhamp… 2023-12-12                      2                     NA
##  8 E08000032 Bradford    2023-12-12                      9                     NA
##  9 E09000018 Hounslow    2023-12-12                      1                     NA
## 10 E09000032 Wandsworth  2023-12-12                      1                     NA
## # ℹ abbreviated names: ¹​new_cases_by_specimen_date,
## #   ²​new_ons_deaths_by_registration_date
## # ℹ 3 more variables: country <chr>, north_east <lgl>, week_start <date>
```

```r
str(df)
```

```
## tibble [286,467 × 8] (S3: tbl_df/tbl/data.frame)
##  $ area_code                          : chr [1:286467] "W06000023" "E06000003" "E06000014" "E06000050" ...
##  $ area_name                          : chr [1:286467] "Powys" "Redcar and Cleveland" "York" "Cheshire West and Chester" ...
##  $ date                               : Date[1:286467], format: "2023-12-13" "2023-12-12" ...
##  $ new_cases_by_specimen_date         : num [1:286467] 0 1 3 4 3 0 2 9 1 1 ...
##  $ new_ons_deaths_by_registration_date: num [1:286467] NA NA NA NA NA NA NA NA NA NA ...
##  $ country                            : chr [1:286467] "Wales" "England" "England" "England" ...
##  $ north_east                         : logi [1:286467] FALSE TRUE FALSE FALSE FALSE FALSE ...
##  $ week_start                         : Date[1:286467], format: "2023-12-10" "2023-12-10" ...
```

```r
# Save to csv file
write_csv(df, file = "data.csv")
```

