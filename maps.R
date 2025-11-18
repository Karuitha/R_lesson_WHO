# Load required packages ----
if (!require(pacman)) {
  install.packages("pacman")
}

library(pacman)

p_load(
  tidyverse,
  plotly,
  ggthemes,
  skimr,
  janitor,
  countrycode
)

p_load_gh(
  "datarootsio/artyfarty"
)

# Get WB Classifications data ----
world_bank <- read.csv(
  "world-bank-income-groups.csv"
) |>
  dplyr::filter(
    Year == 2024
  ) |>
  janitor::clean_names() |>
  dplyr::select(
    code,
    world_bank_s_income_classification
  ) |>
  rename(
    income_class = world_bank_s_income_classification
  )

# Get maps data ----
map_data("world") |>
  mutate(
    code = countrycode(
      sourcevar = region,
      origin = "country.name",
      destination = "iso3c"
    )
  ) |>
  left_join(
    world_bank
  ) |>
  ggplot(
    aes(x = long, y = lat, group = group, fill = income_class)
  ) +
  geom_polygon(show.legend = FALSE, color = "black") +
  labs(
    x = "",
    y = "",
    title = "World Map World Bank Income Classifications in R",
    caption = "John Karuitha; 2025"
  ) +
  theme_scientific() +
  theme(
    axis.text = element_blank()
  ) +
  scale_fill_viridis_d()
