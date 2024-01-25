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

# Filtering data by row --------------------------------------------------

filter(NHANES_small, phys_active == "No")
NHANES_small %>%
  filter(phys_active != "No")

NHANES_small %>%
  filter(bmi == 25)
NHANES_small %>%
  filter(bmi >= 25)

NHANES_small %>%
  filter(bmi == 25 & phys_active == "No") %>%
  select(bmi, phys_active)

NHANES_small %>%
  filter(bmi == 25 | phys_active == "No") %>%
  select(bmi, phys_active)



# Arranging the rows ------------------------------------------------------

NHANES_samll %>%
    arrange(age)

NHANES_small %>%
    arrange(age)

NHANES_small %>%
    arrange(education) %>%
    select(education)

NHANES_small %>%
    arrange(desc(age)) %>%
    select(age)

NHANES_small %>%
    arrange(age,education)

# Transform or add columns ------------------------------------------------

NHANES_small %>%
    mutate(age = age*12)

NHANES_small %>%
    mutate(age=age*12,
           logged_bmi=log(bmi)) %>%
    select(age, logged_bmi)

NHANES_small %>%
    mutate(
        old=if_else(age>=30,"Yes", "No")
    ) %>%
    select(old)


# Exercise 7.12 -----------------------------------------------------------

# 1. BMI between 20 and 40 with diabetes
NHANES_small %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- NHANES_small %>%
    # Specifying dataset
    mutate(
        # 2. Calculate mean arterial pressure
        mean_arterial_blood_pressure = ((2*bp_dia_ave)+bp_sys_ave)/3,
        # 3. Create young_child variable using a condition
        young_child = if_else(age<6, "Yes", "No")
    )

# Calculating summary stats -----------------------------------------------

NHANES_small %>%
    summarise(max_bmi=max(bmi,na.rm=TRUE))

NHANES_small %>%
    summarise(max_bmi=max (bmi, na.rm=TRUE),
              min_bmi=min(bmi, na.rm=TRUE))

# Summary stats by group  -------------------------------------------------

NHANES_small %>%
    group_by(diabetes) %>%
    summarise(mean_age=mean(age, na.rm=TRUE),
              mean_bmi=mean(bmi, na.rm=TRUE))
NHANES_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age=mean(age, na.rm=TRUE),
              mean_bmi=mean(bmi,na.rm=TRUE))
NHANES_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes,phys_active) %>%
    summarise(mean_age=mean(age, na.rm=TRUE),
              mean_bmi=mean(bmi,na.rm=TRUE))
NHANES_small %>%
    filter(!is.na(diabetes)) %>%
    filter(!is.na(phys_active)) %>%
    group_by(diabetes,phys_active) %>%
    summarise(mean_age=mean(age, na.rm=TRUE),
              mean_bmi=mean(bmi,na.rm=TRUE))
NHANES_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes,phys_active) %>%
    summarise(mean_age=mean(age, na.rm=TRUE),
              mean_bmi=mean(bmi,na.rm=TRUE)) %>%
    ungroup()

# Saving dataset as a file ------------------------------------------------

readr::write_csv(NHANES_small,
                 here::here("data/NHANES_small.csv"))

