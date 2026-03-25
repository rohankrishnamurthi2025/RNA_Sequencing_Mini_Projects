# Optional HW 1
# Rohan Krishnamurthi
# 12/12/2024

# Load packages and handle conflicts
library(tidyverse)
library(tidymodels)
library(readr)
library(here)
tidymodels_prefer()

setwd("/Users/rohankrishnamurthi/Downloads/ESAM 372-0/optional 1")

samples = c("WT_2", "WT_18", "WT_20", "WT_39", "WT_42", "WT_45", 
           "SNF2_14", "SNF2_15", "SNF2_31", "SNF2_33", "SNF2_42", "SNF2_44")
# Read in files
file_report <- read.table("filereport_read_run_PRJEB5348_tsv.txt", 
                          header = TRUE, sep = "\t", stringsAsFactors = FALSE)

sample_mapping <- read.table("ERP004763_sample_mapping.tsv", header = TRUE)

combined_data <- right_join(x = file_report, y = sample_mapping, by = "run_accession")

combined_data$label <- paste(combined_data$Sample, combined_data$BiolRep, sep = "_")

filtered_data <- combined_data |> 
  filter(label %in% samples) |> 
  arrange(label)

write.table(x = filtered_data, file = "file_report_filtered_tsv.txt", 
            sep = "\t", row.names = FALSE, quote = FALSE)
