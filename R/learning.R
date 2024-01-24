# Loading packages --------------------------------------------------------

library(tidyverse)

# This is used to test out Git

# Learning dplyr
library(tidyverse)
library(NHANES)

glimpse(NHANES)
str(NHANES)

# Specific columns selection ----------------------------------------------

select(NHANES, Age, Weight, BMI)
select(NHANES, -HeadCirc)
select(NHANES, starts_with("BP"))
select(NHANES, ends_with("Day"))
select(NHANES, contains("Age"))


# Renaming columns --------------------------------------------------------

rename_with(NHANES, snakecase::to_snake_case)

NHANES_small <- rename_with(NHANES, snakecase::to_snake_case)

# Rename a specific column ------------------------------------------------

NHANES_samll <- rename(NHANES_small, sex = gender)
NHANES_samll <- NHANES_small
view(NHANES_small)


# Chaining the functions with the pipe ------------------------------------

colnames(NHANES_small)

NHANES_small %>%
  colnames()

NHANES_phys_active <- NHANES_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

NHANES_small %>%
  select(bp_sys_ave, education)

NHANES_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

NHANES_small %>%
  select(bmi, contains("age"))

NHANES_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)
