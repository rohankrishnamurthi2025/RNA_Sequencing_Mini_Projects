# Optional Homework 3
# R script #1
# Rohan Krishnamurthi, ESAM 372-0

# STEP 5
# Load packages
library(tidyverse)
library(tidymodels)
library(here)
library(ggplot2)
library(ggcorrplot)
library(GGally)
library(pheatmap)

# handle common conflicts
tidymodels_prefer()

# Set working directory
setwd ("/Users/rohankrishnamurthi/Downloads/ESAM 372-0/optional 3")

# Read in STAR count table
gene_counts_STAR <- read.table(file="count_table_STAR.txt",sep="",header=TRUE)
gene_counts_STAR <- gene_counts_STAR[order(row.names(gene_counts_STAR)), ]
head(gene_counts_STAR)

# Read in RSEM count table
gene_counts_RSEM <- read.table(file="count_table_RSEM.txt",sep="",header=TRUE)
gene_counts_RSEM <- gene_counts_RSEM[order(row.names(gene_counts_RSEM)), ]
head(gene_counts_RSEM)

# Merge the two count tables
gene_counts <- merge(gene_counts_STAR, gene_counts_RSEM, by = "row.names", all = FALSE)
rownames(gene_counts) <- gene_counts$Row.names
gene_counts$Row.names <- NULL

# Remove rows with only 0
gene_counts <- gene_counts[rowSums(gene_counts != 0) > 0, ]

head(gene_counts)

# STEP 6
# Log transform each count: log2(X + 1)
gene_counts_log_transformed <- log2(gene_counts + 1)

# Generate correlation plot
scatter_1 <- ggpairs(gene_counts_log_transformed)
scatter_1

C1 <- cor(gene_counts_log_transformed)
cor_1 <- ggcorrplot(C1,tl.cex=5) + scale_fill_gradient2(limit=c(0.8,1),low="blue",high="red",mid="white",midpoint=0.9)
cor_1

ggsave("scatter_1.png", plot = scatter_1, width = 6, height = 4, dpi = 300)
ggsave("cor_1.png", plot = cor_1, width = 6, height = 4, dpi = 300)

# the STAR count files are highly correlated, at least 0.994 (r is the correlation coefficient)
# the RSEM expected count files are highly correlated, at least 0.994
# the RSEM and STAR files are slightly less correlated with each other, values of 0.87-0.88



# STEP 7: calculate averages
gene_counts_averages <- gene_counts |> 
  mutate(STAR_average = (SRR6357070_ReadsPerGene.out.tab + SRR6357071_ReadsPerGene.out.tab + SRR6357072_ReadsPerGene.out.tab)/3,
         RSEM_average = (SRA6357070_rsem.genes.results + SRA6357071_rsem.genes.results + SRA6357072_rsem.genes.results)/3,
         STAR_average_log = log2(STAR_average + 1),
         RSEM_average_log = log2(RSEM_average + 1)
         ) |> 
  select(STAR_average, STAR_average_log, RSEM_average, RSEM_average_log)

# STEP 8: Compute 25 most positive and 25 most negative differences 
gene_counts_differences <- gene_counts_averages |> 
  mutate(difference = STAR_average_log - RSEM_average_log) |> 
  select(difference) |> 
  arrange(desc(difference))

top_25 <- gene_counts_differences |> 
  slice_head(n = 25)   
top_25_genes <- rownames(top_25)

bottom_25 <- gene_counts_differences |> 
  slice_tail(n = 25)   
bottom_25_genes <- rownames(bottom_25)

STAR_dominant <- gene_counts[rownames(gene_counts) %in% top_25_genes, ]
write.csv(STAR_dominant, "STAR_dominant.csv", row.names = TRUE)

RSEM_dominant <- gene_counts[rownames(gene_counts) %in% bottom_25_genes, ]
write.csv(RSEM_dominant, "RSEM_dominant.csv", row.names = TRUE)


