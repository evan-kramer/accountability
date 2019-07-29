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
school = T
if(district) {
  # District accountability file
  file = read_csv(str_c("data/", year(now()), "_final_accountability_files/district_accountability_file.csv"))
  file %>% 
    split(., .$system) %>% 
    walk2(
      .x = .,
      .y = sort(unique(file$system)),
      .f = ~ write_csv(
        .x,
        path = str_c(
          "data/",
          year(now()),
          "_final_accountability_files/split/",
          .y,
          "_DistrictAccountabilityFile_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".csv"
        ),
        na = ""
      )
    )
  
} else {
  rm(district)
}

# School accountability file
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
      append = F
    )
  )
## Targeted support metrics
file = read_csv(str_c("projects/", year(now()), "_school_accountability/targeted_support_ranks.csv")) 
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
file = read_csv(str_c("data/", year(now()), "_final_accountability_files/atsi_metrics.csv")) 
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
