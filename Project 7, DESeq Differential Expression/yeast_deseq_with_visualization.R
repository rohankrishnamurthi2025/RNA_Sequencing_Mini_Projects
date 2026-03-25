library("DESeq2")
setwd("~/yeast_counts")    # change this line and the next one as necessary

yeast_count_table<-read.table("yeast_count_table.txt",header=TRUE,row.names=1)

# extract experimental conditions from sample names and make a data frame
samplename<-colnames(yeast_count_table)
samplematrix<-matrix(unlist(strsplit(samplename,'_')),ncol=2,byrow=TRUE)
sample_condition<-samplematrix[,1]
exp_matrix<-data.frame("sample"=samplename,"condition"=sample_condition)

# make sample conditions factors and make WT the reference condition
exp_matrix$condition<-as.factor(exp_matrix$condition)
exp_matrix$condition<-relevel(exp_matrix$condition,"WT")

# make DESeq data set and run DESeq
DDS <- DESeqDataSetFromMatrix(countData=yeast_count_table, colData=exp_matrix, design=~condition)
DDS<- DESeq(DDS)

# extract normalized counts
DDS_normed <- counts(DDS,normalized=TRUE)

# get results of differential expression analysis
# contrast is between mutant and WT
DDS_results <- results(DDS, lfcThreshold=0.5, alpha=0.05, altHypothesis="greaterAbs", contrast=c("condition","SNF2","WT"))

# merge normalized counts and differential expression results
DDS_merged<-merge(DDS_normed,DDS_results,by="row.names",sort=FALSE)
rownames(DDS_merged)<-DDS_merged$Row.names
DDS_merged$Row.names<-NULL
DDS_combined <- DDS_merged[order(DDS_merged$padj),]

# threshhold results at an adjustted p-value of 0.05 and write to a file
DDS_combined_thresholded <- subset(DDS_combined,DDS_combined$padj<=0.05) 
write.csv(as.data.frame(DDS_combined_thresholded),file="yeast_combined_thresholded.csv")

# extract variance stabilized data using variance stabilizing transform
vsd <- vst(DDS, blind=FALSE)
library("pheatmap")

# extract 20 rows with largest mean expression and make a heatmap
select <- order(rowMeans(counts(DDS,normalized=TRUE)),decreasing=TRUE)[1:20]
df <- as.data.frame(colData(DDS)[,c("condition","sample")])
pheatmap(assay(vsd)[select,], cluster_rows=TRUE, show_rownames=TRUE,cluster_cols=TRUE, annotation_col=df)

# create a PCA plot of the samples using the 500 genes with the largest variance
#
library("ggplot2")
pcaData <- plotPCA(vsd, intgroup=c("condition", "sample"), returnData=TRUE, ntop=500)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, color=sample, shape=condition)) +
  coord_fixed(ratio = sqrt(percentVar[2]/percentVar[1])) +
  geom_point(size=3) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance"))  

