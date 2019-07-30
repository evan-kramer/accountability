# Accountability File Splits
# Evan Kramer

options(java.parameters = "-Xmx16G")
library(tidyverse)
library(lubridate)
library(haven)
library(acct)
library(xlsx)
setwd("N:/ORP_accountability")

district = F
school = F
check = F

# District accountability file
if(district) {
  ## Metrics
  file = read_csv(str_c("data/", year(now()), "_final_accountability_files/district_accountability_file.csv"))
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_DistrictAccountabilityFile_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "Metrics",
        row.names = F,
        showNA = F,
        append = F
      )
    )
  ## Designations
  file = read_csv(str_c("data/", year(now()), "_final_accountability_files/district_designations.csv"))
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_DistrictAccountabilityFile_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "Designations",
        row.names = F,
        showNA = F,
        append = T
      )
    )
} 

# School accountability file
if(school) {
  ## Metrics
  file = read_csv(str_c("data/", year(now()), "_final_accountability_files/school_accountability_file.csv"))
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_SchoolAccountabilityFile_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "Metrics",
        row.names = F,
        showNA = F,
        append = F
      )
    )
  ## Indicator scores
  file = read_csv(str_c("projects/", year(now()), "_school_accountability/school_grading_metrics.csv"))
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_SchoolAccountabilityFile_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "Indicator Scores",
        row.names = F,
        showNA = F,
        append = T
      )
    )
  ## Overall performance
  file = read_csv(str_c("projects/", year(now()), "_school_accountability/school_grading_grades.csv"))
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_SchoolAccountabilityFile_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "Overall Performance",
        row.names = F,
        showNA = F,
        append = T
      )
    )
  
  # School accountability status list
  ## Designations
  file = readxl::read_excel(str_c("data/", year(now()), "_final_accountability_files/school_designations_file.xlsx")) 
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_SchoolAccountabilityStatusList_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "Designations", 
        row.names = F,
        showNA = F,
        append = F
      )
    )
  ## Priority exit
  file = read_csv(str_c("projects/", year(now()), "_school_accountability/priority_exit.csv")) %>% 
    filter(priority_csi == 1)
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_SchoolAccountabilityStatusList_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "Priority Exit", 
        row.names = F,
        showNA = F,
        append = T
      )
    )
  ## Targeted support metrics
  file = read_csv(str_c("projects/", year(now()), "_school_accountability/targeted_support_ranks.csv")) %>% 
    left_join(
      read_csv(str_c("data/", year(now()), "_final_accountability_files/names.csv")),
      by = c("system", "school")
    ) %>% 
    select(system, system_name, school, school_name, everything())
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_SchoolAccountabilityStatusList_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "TSI Metrics", 
        row.names = F,
        showNA = F,
        append = T
      )
    )
  ## Additional targeted support metrics
  file = read_csv(str_c("projects/", year(now()), "_school_accountability/atsi_metrics.csv")) %>%
    left_join(
      read_csv(str_c("data/", year(now()), "_final_accountability_files/names.csv")),
      by = c("system", "school")
    ) %>% 
    select(system, system_name, school, school_name, everything())
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write.xlsx(
        x = as.data.frame(.x),
        file = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_SchoolAccountabilityStatusList_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".xlsx"
        ),
        sheetName = "ATSI Metrics", 
        row.names = F,
        showNA = F,
        append = T
      )
    )
}

# Checks
if(check) {
  list = tibble(filename = list.files("projects/NCLBAppeals/Accountability Web Files"))
  
  # By file type and district
  mutate(
    list,
    system = str_sub(filename, 1, 3) %>% 
      str_replace_all("_", "") %>% 
      as.numeric(),
    filename = str_replace_all(filename, ".xlsx", "") %>% 
      str_replace_all(".csv", "") %>%
      str_replace_all(as.character(year(now())), "") %>% 
      str_replace_all("[0-9]", "") %>% 
      str_replace_all("_", "") %>% 
      str_replace_all("Jul", "") %>% 
      str_replace_all("Jun", "")
  ) %>% 
    # group_by(system, filename) %>% 
    group_by(filename) %>% 
    summarize(n = n()) %>% 
    ungroup()
  
  # By district
}