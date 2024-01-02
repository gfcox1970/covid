# Purpose:			Functions used by other scripts to load libraries and area names
# Created by:   Cox, Graham
# Created on:   2024-01-02

# Functions ----

# Load libraries used by other scripts
library_load <-
	function () {
		if (!require(pacman)) {
			install.packages("pacman")
		}

		pacman::p_load(
			"dplyr", "tidyr", "stringr", "lubridate",
			"readr", "ggplot2", "tibble", "forcats",
			"scales", "ggtext", "showtext", "ggpubr",
			"zoo", "tictoc"
		)
	}


# Create a vector of area names
area_load <- function() {
	c(
		"Hartlepool", "Middlesbrough", "Redcar and Cleveland", "Stockton-on-Tees",
		"Darlington", "County Durham", "Northumberland", "Newcastle upon Tyne",
		"North Tyneside", "South Tyneside", "Sunderland", "Gateshead"
	)
}