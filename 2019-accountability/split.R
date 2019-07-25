# Accountability File Splits

options(java.parameters = "-Xmx16G")
library(tidyverse)
library(lubridate)
library(haven)
library(acct)
setwd("N:/ORP_accountability")

# District and school accountability files
for(f in c("school", "district")) {
  file = read_csv(str_c("data/", year(now()), "_final_accountability_files/", f, ".csv"))
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
          "_",
          str_to_title(f),
          "AccountabilityFile_",
          day(now()),
          month(now(), label = T, abbr = T),
          year(now()),
          ".csv"
        )
      )
    )
}

# District designations file?
# School accountability file
# School designations file
# School heat maps
# ACT substitution files

# TVAAS files 
# for(f in c("teacher", "school", "district")) {
#   # Subject-level
#   file = readxl::read_excel(str_c("data/", year(now()), "_tvaas/SAS-TDOE-", str_to_title(f), "-VA-by-subject.xlsx"))
#   file %>% 
#     split(., .$`District Number`) %>% 
#     walk2(
#       .x = .,
#       .y = sort(unique(file$`District Number`)),
#       .f = ~ write_csv(
#         .x,
#         path = str_c(
#           "data/",
#           year(now()),
#           "_final_accountability_files/split/",
#           .y,
#           "_",
#           str_to_title(f),
#           "AccountabilityFile_",
#           day(now()),
#           month(now(), label = T, abbr = T),
#           year(now()),
#           ".csv"
#         )
#       )
#     )
#   
#   # Composite
#   
#   
#   
# }