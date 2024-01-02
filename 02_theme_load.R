# Purpose:			Creates theme used by ggplot2 package when creating data visualisations
# Created by:   Cox, Graham
# Created on:   2024-01-02

theme_load <- function() {
	# Load Google fonts
	font_add_google(family = "roboto-slab", "Roboto Slab")
	font_add_google(family = "roboto-condensed", "Roboto Condensed")

	# Set text options
	showtext_auto(enable = TRUE)
	showtext_opts(dpi = 144)

	# Set theme
	theme_set(
		#Set default theme
		theme_minimal(base_size = 11,
									base_family = "roboto-condensed") +

			# Set individual theme items
			theme(
				# Main plot items
				plot.margin = margin(rep(.7, 4), unit = "cm"),
				plot.title = element_textbox_simple(
					family = "roboto-slab",
					colour = "tomato",
					margin = margin(b = .5, unit = "cm")
				),
				plot.title.position = "plot",
				plot.subtitle = element_textbox_simple(
					margin = margin(b = .5, unit = "cm"),
					size = 12,
					face = "bold",
					lineheight = unit(1.2, "lines"),
					family = "roboto-slab"
				),
				plot.caption = element_text(
					hjust = 0,
					margin = margin(t = .5, unit = "cm"),
					lineheight = unit(2, "lines")
				),
				plot.caption.position = "plot",

				# Set main panel items
				panel.spacing = unit(1, "cm"),
				panel.grid = element_blank(),

				# Set axis item
				axis.text = element_textbox_simple(
					margin = margin(rep(.2, 4),
													unit = "cm"),
					lineheight = unit(2, "lines")
				)
			)
	)
}
