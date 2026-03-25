# Homework 4, script B
# Rohan Krishnamurthi
# 11/24/2024
# 10 good samples, WT_21, SNF2_06

# Install packages
if (!require("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")  
}

BiocManager::install(version = "3.20")
BiocManager::install("DESeq2", force = TRUE)
BiocManager::install("GenomeInfoDbData", type = "source", force = TRUE)

# Load relevant packages
library(tidyverse)
library(tidymodels)
library(here)
library(BiocManager)
library(DESeq2)
library(pheatmap)

#library(BiocVersion)
# handle conflicts
tidymodels_prefer()

# Set working directory
setwd("/Users/rohankrishnamurthi/Downloads/ESAM 372-0/hw 4 files")
#setwd("~/yeast_counts")

# Read in count tables
yeast_count_table_replacements <- read.table("count_table_replacements_2.txt", 
                                         header = TRUE, row.names=1)

# first get vector of column names
samplename_2 <- colnames(yeast_count_table_replacements)

# the next spline splits column names on "_" and makes a matrix
samplematrix_2 <- matrix(unlist(strsplit(samplename_2,'_')),ncol=2,byrow=TRUE)

# the condition is the second column
sample_condition_2 <- samplematrix_2[,1]

# make a data frame with sample names and condtions
exp_matrix_2 <-data.frame("sample"=samplename_2,"condition"=sample_condition_2)

# convert to factors
exp_matrix_2$condition<-as.factor(exp_matrix_2$condition)

# relevel so that "WT" is the reference condition
exp_matrix_2$condition<-relevel(exp_matrix_2$condition,"WT")
#head(exp_matrix_1)

# Make DESeq data table
DDS_yeast_2 <- DESeqDataSetFromMatrix(countData = yeast_count_table_replacements,
                                      colData=exp_matrix_2, design=~condition)

# Do the differential expression, extract normalized counts
DDS_yeast_2 <- DESeq(DDS_yeast_2)
yeast_normed_2 <- counts(DDS_yeast_2, normalized=TRUE)
#write.csv(as.data.frame(yeast_normed_2),file="yeast_normed_2.csv")

# Compare SNF2 mutant and WT samples w/ log2 fold changes
# extract the differential expression results, order by adjusted p-value and write to a file
yeast_results_2 <- results(DDS_yeast_2, lfcThreshold=0.5, alpha=0.05,
                           altHypothesis="greaterAbs", contrast=c("condition","SNF2","WT"))
yeast_ordered_2 <- yeast_results_2[order(yeast_results_2$padj),]
#write.csv(as.data.frame(yeast_ordered_2),file="yeast_ordered_2.csv")

# Merge normalized counts and fold changes
yeast_merged_2 <- merge(yeast_normed_2,yeast_ordered_2,by="row.names",sort=FALSE)
rownames(yeast_merged_2)<-yeast_merged_2$Row.names
yeast_merged_2$Row.names<-NULL
yeast_combined_2 <- yeast_merged_2[order(yeast_merged_2$padj),]
yeast_combined_threshold_2 <- subset(yeast_combined_2, yeast_combined_2$padj <= 0.05)
#write.csv(as.data.frame(yeast_combined_threshold_2),file="yeast_combined_threshold_2.csv")

# Heatmap
vsd_2 <- vst(DDS_yeast_2, blind=FALSE)
select_2 <- order(rowMeans(counts(DDS_yeast_2, normalized=TRUE)),
                  decreasing=TRUE)[1:20]
df_2 <- as.data.frame(colData(DDS_yeast_2)[,c("condition","sample")])
pheatmap(assay(vsd_2)[select_2,], cluster_rows=TRUE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col = df_2)

# PCA 
pca_data_2 <- plotPCA(vsd_2, intgroup=c("condition", "sample"),
                      returnData=TRUE, ntop=500)
percent_var_2 <- round(100* attr(pca_data_2, "percentVar"))
ggplot(pca_data_2, aes(PC1, PC2, color=sample, shape = condition)) +
  coord_fixed(ratio = sqrt(percent_var_2[2]/percent_var_2[1])) +
  geom_point(size = 3) +
  xlab(paste0("PC1: ", percent_var_2[1], "% variance")) +
  ylab(paste0("PC2: ", percent_var_2[2], "% variance"))
