# School Designations File
# Evan Kramer

options(java.parameters = "-Xmx16G")
library(tidyverse)
library(lubridate)
library(haven)
library(acct)
library(xlsx)
setwd(str_c("N:/ORP_accountability/projects/", year(now()), "_school_accountability"))

# Data
read_csv("priority_exit.csv") %>% 
  select(system:school_name, priority_csi, priority_exit) %>% 
  full_join(
    read_csv("school_grading_grades.csv") %>% 
      select(system:school, reward, ends_with("targeted_support")),
    by = c("system", "school")
  ) %>% 
  left_join(
    readxl::read_excel(str_c("N:/ORP_accountability/data/", year(now()) - 1, "_final_accountability_files/school_designations_file.xlsx")) %>% 
      transmute(system, school, designation_prior = designation),
    by = c("system", "school")
  ) %>% 
  mutate_at(vars(priority_csi:targeted_support), funs(ifelse(is.na(.), 0, .))) %>% 
  transmute(
    system,
    system_name,
    school,
    school_name,
    designation = case_when(
      reward == 1 ~ "Reward",
      priority_exit == 1 ~ "Priority Exit",
      priority_csi == 1 & priority_exit == 0 ~ designation_prior,
      additional_targeted_support == 1 ~ "Additional Targeted Support and Improvement",
      targeted_support == 1 ~ "Targeted Support and Improvement"
    )
  ) %>% 
  as.data.frame() %>%
  write.xlsx(
    str_c("N:/ORP_accountability/data/", year(now()), "_final_accountability_files/school_designations_file.xlsx"),
    showNA = F,
    row.names = F,
    sheetName = "Designations"
  )
