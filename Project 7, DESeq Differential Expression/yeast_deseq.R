library("DESeq2")

# read in the count table
yeast_count_table<-read.table("yeast_count_table.txt",header=TRUE,row.names=1)
head(yeast_count_table)

# make a table of of samples and conditions
#
# first get vector of column names
samplename<-colnames(yeast_count_table)
#
# the next spline splits column names on "_" and makes a matrix
samplematrix<-matrix(unlist(strsplit(samplename,'_')),ncol=2,byrow=TRUE)
#
# the condition is the second column
sample_condition<-samplematrix[,1]

# make a data frame with sample names and condtions
exp_matrix<-data.frame("sample"=samplename,"condition"=sample_condition)
#
# convert to factors
exp_matrix$condition<-as.factor(exp_matrix$condition)
#
# relevel so that "WT" is the reference condition
exp_matrix$condition<-relevel(exp_matrix$condition,"WT")
head(exp_table)

# create the DDSeq object
# 
DDS_yeast <- DESeqDataSetFromMatrix(countData=yeast_count_table, colData=exp_matrix,design=~condition)

# Do the differential expression
DDS_yeast <- DESeq(DDS_yeast)

# extract the normallized counts and write to a file
yeast_normed <- counts(DDS_yeast,normalized=TRUE)
write.csv(as.data.frame(yeast_normed),file="yeast_normed.csv")

# extract the differential expression results, order by adjusted p-value and write to a file
yeast_results <- results(DDS_yeast, lfcThreshold=0.5, alpha=0.05, altHypothesis="greaterAbs", contrast=c("condition","SNF2","WT"))
yeast_ordered <- yeast_results[order(yeast_results$padj),]
write.csv(as.data.frame(yeast_ordered),file="yeast_ordered.csv")

# merge normalized counts and differential expression results and write to a file
yeast_merged<-merge(yeast_normed,yeast_ordered,by="row.names",sort=FALSE)
rownames(yeast_merged)<-yeast_merged$Row.names
yeast_merged$Row.names<-NULL
yeast_combined <- yeast_merged[order(yeast_merged$padj),]
write.csv(as.data.frame(yeast_combined),file="yeast_combined.csv")

