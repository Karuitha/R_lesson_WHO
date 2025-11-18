# Anything starts with # is a comment ----
# Arithmetic operations
1 + 1
2 * 5
3 / 4
5 %/% 2 # Floor division
7 %% 4 # Modulus
4^2
4**2
15 - 5

# Data structures ----
# Basic (atomic) data structures
# Integer
1L
class(1)

# Characters
"John Karuitha"


# Logicals
TRUE
FALSE

# Doubles - decimal
3.14


# Creating variables ----
my_name <- "John Karuitha"
print(my_name)


age <- 30


is_kenyan <- FALSE


constant <- 3.14


# Dataframes ----
# Vector - one dimnsional array
student_name <- c("John", "Achieng", "Jane", "Chacha", "Saul")
weight_kg <- c(55, 75, 84, 57, 99)
height_meters <- c(1.8, 2, 1.75, 1.5, 1.89)
is_kenyan <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
gender <- c("M", "F", "F", "M", "M")

# Dataframe- 2 dimensional
my_data <- data.frame(student_name, weight_kg, height_meters, is_kenyan, gender)
View(my_data)
summary(my_data)
plot(my_data)

# Packages: Extending the power of R ----
# install.packages("tidyverse")
library(tidyverse)
library(artyfarty)

# The pipe operator (then)
my_data %>% View()
my_data %>% summary()
my_data %>% plot()
my_data %>%
  mutate(BMI = weight_kg / (height_meters**2))

# Reading data from csv files ----
immune <- read.csv("immunization_coverage_2022_MCV1.csv")

immune %>%
  ggplot(aes(x = target, y = doses_administered, size = doses_administered)) +
  geom_point() +
  theme_five38() +
  labs(title = "Targets versus Doses",
       subtitle = "Size indicates a larger dosage") +
  theme(
    legend.position = "none"
  )

immune %>%
  select(county_name, target)

immune %>%
  filter(doses_administered >= 10000)
