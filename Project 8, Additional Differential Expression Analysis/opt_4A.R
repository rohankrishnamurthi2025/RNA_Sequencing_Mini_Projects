# Optional 4, File A
# Rohan Krishnamurthi
# 12/13/2024
# 12 good samples, 6 WT, 6 SNF2

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
library(dplyr)
library(here)
library(BiocManager)
library(DESeq2)
library(pheatmap)

#library(BiocVersion)
# handle conflicts
tidymodels_prefer()

# Set working directory
setwd("/Users/rohankrishnamurthi/Downloads/ESAM 372-0/optional 4")

# Read in count tables
count_table <- read.table("count_table_4.1.txt", header = TRUE, row.names=1)

# first get vector of column names
samplename_1 <- colnames(count_table)

# the next spline splits column names on "_" and makes a matrix
samplematrix_1 <- matrix(unlist(strsplit(samplename_1,'_')),ncol=2,byrow=TRUE)

# the condition is the second column
sample_condition_1 <- samplematrix_1[,1]

# make a data frame with sample names and condtions
exp_matrix_1 <-data.frame("sample"=samplename_1,"condition"=sample_condition_1)

# convert to factors
exp_matrix_1$condition<-as.factor(exp_matrix_1$condition)

# relevel so that "WT" is the reference condition
exp_matrix_1$condition<-relevel(exp_matrix_1$condition,"WT")
#head(exp_matrix_1)

# Make DESeq data table
DDS_yeast_1 <- DESeqDataSetFromMatrix(countData = count_table,
                                      colData=exp_matrix_1, design=~condition)

# Do the differential expression, extract normalized counts
DDS_yeast_1 <- DESeq(DDS_yeast_1)
yeast_normed_1 <- counts(DDS_yeast_1, normalized=TRUE)
#write.csv(as.data.frame(yeast_normed_1),file="yeast_normed_1.csv")

# Compare SNF2 mutant and WT samples w/ log2 fold changes
# extract the differential expression results, order by adjusted p-value and write to a file
yeast_results_1 <- results(DDS_yeast_1, lfcThreshold=0.5, alpha=0.05,
                           altHypothesis="greaterAbs", contrast=c("condition","SNF2","WT")) #add log2 change threshold
yeast_ordered_1 <- yeast_results_1[order(yeast_results_1$padj),]
#write.csv(as.data.frame(yeast_ordered_1),file="yeast_ordered_1.csv")

# Merge normalized counts and fold changes
yeast_merged_1 <- merge(yeast_normed_1,yeast_ordered_1,by="row.names",sort=FALSE)
rownames(yeast_merged_1)<-yeast_merged_1$Row.names
yeast_merged_1$Row.names<-NULL
yeast_combined_1 <- yeast_merged_1[order(yeast_merged_1$padj),]
yeast_combined_threshold_1 <- subset(yeast_combined_1, yeast_combined_1$padj <= 0.05)
write.csv(as.data.frame(yeast_combined_threshold_1), file="yeast_combined_threshold_1.csv")

#yeast_ERCC_threshold_1 <- subset(yeast_combined_threshold_1, grepl("ERCC", Row.names))
yeast_ERCC_threshold_1 <- yeast_combined_threshold_1[grepl("ERCC", row.names(yeast_combined_threshold_1)), ]
write.csv(as.data.frame(yeast_ERCC_threshold_1), file="yeast_ERCC_threshold_1.csv")

# Heatmap and PCA
vsd <- vst(DDS_yeast_1 , blind = FALSE )
vsd_ercc <- vsd[grepl("ERCC",rownames(vsd)),]

#select_1 <- order(rowMeans(counts(DDS_yeast_1, normalized=TRUE)), decreasing=TRUE)[1:20]
#df_1 <- as.data.frame(colData(DDS_yeast_1)[,c("condition","sample")])
#pheatmap(assay(vsd_ercc)[select_1,], cluster_rows=TRUE, show_rownames=TRUE, cluster_cols=TRUE, annotation_col = df_1)

# PCA 1
pca_data_1 <- plotPCA(vsd_ercc, intgroup=c("condition", "sample"),
                      returnData=TRUE, ntop=500)
percent_var_1 <- round(100* attr(pca_data_1, "percentVar"))
ggplot(pca_data_1, aes(PC1, PC2, color=sample, shape = condition)) +
  coord_fixed(ratio = sqrt(percent_var_1[2]/percent_var_1[1])) +
  geom_point(size = 3) +
  xlab(paste0("PC1: ", percent_var_1[1], "% variance")) +
  ylab(paste0("PC2: ", percent_var_1[2], "% variance"))


