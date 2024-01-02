# COVID-19 Analysis

## Introduction

This repoistory will explore the publicly available data from the UK government via the API at the link below.

🌐 [Download data | Coronavirus in the UK](https://coronavirus.data.gov.uk/details/download)

Data will analysed at both the levels shown below

- United Kingdom
- England, Scotland, Wales
- The north east of England, namely the areas of "Hartlepool", "Middlesbrough", "Redcar and Cleveland", "Stockton-on-Tees", "Darlington", "County Durham", "Northumberland", "Newcastle upon Tyne", "North Tyneside", "South Tyneside", "Sunderland" and "Gateshead"

## Files included

- 00_library_load.R - Loads functions used by other script files
- 01_data_prep.R - Downloads data from UK government API and performs initial data cleaning steps
- 02_theme_load.R - Creates theme used by `ggplot2` package when creating data visualisations in scripts
