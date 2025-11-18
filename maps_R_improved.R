# =========================================================
# WORLD BANK INCOME CLASSIFICATION MAP
# =========================================================
# John Karuitha
# =========================================================

# NB: Internet connection needed
# ---- Load Required Packages ----
if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  plotly,
  ggthemes,
  skimr,
  janitor,
  countrycode,
  sf,
  remotes
)

# ---- Load Artyfarty Themes (optional, GitHub) ----
pacman::p_load_gh("datarootsio/artyfarty")

# Load latest rnaturalearth and data package (terra is problematic) ----
p_load_gh("rspatial/terra")
p_load_gh("ropensci/rnaturalearth")
p_load_gh("ropensci/rnaturalearthdata")


# ---- Load World Bank Income Classification Data ----
world_bank <- read.csv("https://raw.githubusercontent.com/Karuitha/R_lesson_WHO/refs/heads/master/world-bank-income-groups.csv") %>%
  clean_names() %>%
  filter(year == 2024) %>%
  transmute(
    iso3c = code,
    income_class = world_bank_s_income_classification
  )

# ---- Load High-Quality World Map Geometry (sf) ----
world_sf <- rnaturalearth::ne_countries(
  scale = "medium",
  returnclass = "sf"
) %>%
  st_transform(crs = 4326) %>%
  select(iso3c = iso_a3, name, geometry)

# ---- Merge Map and World Bank Data ----
world_joined <- world_sf %>%
  left_join(world_bank, by = "iso3c") %>%
  mutate(
    income_class = str_remove_all(income_class, " countries") |>
      str_squish()
  )

# ---- Plot Professional Map ----
p <- ggplot(world_joined) +
  geom_sf(aes(fill = income_class), color = "grey35", linewidth = 0.15) +
  labs(
    title = "World Bank Income Classifications (2024)",
    subtitle = "Mapped using R and high-resolution Natural Earth data",
    caption = "Source: World Bank | Visualization: John Karuitha, 2025"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.background = element_rect(fill = "aliceblue", color = NA),
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(face = "bold", size = 20),
    plot.subtitle = element_text(size = 12)
  ) +
  coord_sf(expand = FALSE)

p
