# 5A: Visualizing Single-Cell Count Data in R
# Rohan Krishnamurthi, 12/4/2024

# Install and load packages
#install.packages("Seurat")
#install.packages("clustree")
#install.packages('BiocManager')
#BiocManager::install('glmGamPoi')
library("glmGamPoi")
library(tidyverse)
library(tidymodels)
library(here)
library(Seurat)
library(cowplot)
library(clustree)

# Handle Conflicts
tidymodels_prefer()

# Set working directory
setwd("/Users/rohankrishnamurthi/Downloads/ESAM 372-0/hw 5 files/filtered")
#getwd()

# Load the data
dirfilt <- "/Users/rohankrishnamurthi/Downloads/ESAM 372-0/hw 5 files/filtered/"
sc.counts <- Read10X(data.dir=dirfilt, gene.column=2, unique.features=TRUE)

setwd("/Users/rohankrishnamurthi/Downloads/ESAM 372-0/hw 5 files")
# Create a SeuratObject
sc <- CreateSeuratObject(counts = sc.counts, project = "mouse_brain",
                         min.cells = 3, min.features = 100)
sc

# What percent of reads in cells are associated with mitochondrial and ribosomal reads
sc[["percent.mt"]] <- PercentageFeatureSet(sc, pattern="^mt-") 
sc[["percent.ribo"]] <- PercentageFeatureSet(sc,pattern="^Rp[sl][[:digit:]]")

VlnPlot(sc,features = c("nFeature_RNA","nCount_RNA","percent.mt","percent.ribo"), ncol = 4, log=TRUE)

dev.copy2pdf(file="plot1.pdf",width=10,height=8) # save plot as pdf

sc[["percent.mt"]]
sc[["percent.ribo"]]

# Next step: threshold (remove) cells that are outliers
# Trial thresholding parameters --> may need to adjust later
# Initial parameters: 100, 10000, 100, 10000
min_genes <- 300
max_genes <- 9000
min_reads <- 480
max_reads <- 65000

# Make plot showing number of counts and genes along with lines for the thresholds
FeatureScatter(sc, feature1 = "nCount_RNA", feature2 = "nFeature_RNA") + 
  scale_y_log10() + 
  scale_x_log10() +
  geom_hline(yintercept=min_genes) +
  geom_hline(yintercept=max_genes) +
  geom_vline(xintercept=min_reads) + geom_vline(xintercept=max_reads)

dev.copy2pdf(file="plot2.pdf",width=10,height=8)

# Set mt.thresh value for outlier removal
mt.thresh <- 25 # this is a good choice!
sc <- subset(x=sc, subset = nFeature_RNA > min_genes & nFeature_RNA < max_genes
             & nCount_RNA > min_reads & nCount_RNA < max_reads & percent.mt < mt.thresh)

sc
VlnPlot(sc,features = c("nFeature_RNA","nCount_RNA","percent.mt","percent.ribo"), ncol = 4, log=TRUE)
dev.copy2pdf(file="plot3.pdf",width=10,height=8)

# Normalize the remaining single-cell data, regress variation w.r.t. mitochondrial counts
options(future.globals.maxSize = 1024 * 1024 * 1024) # Increase future.Globals.MaxSize
sc <- SCTransform(sc, method="glmGamPoi", vars.to.regress=c("percent.mt","percent.ribo"), verbose=T)

# Run PCA
sc <- RunPCA(sc, verbose = T, npcs=50)

# Build a nearest neighbor graph as a first step toward clustering the data:
sc <- FindNeighbors(sc, graph.name="mgraph", dims = 1:50, verbose = T, k.param=20) # can change 20 to 30

sc <- FindClusters(object = sc, graph.name="mgraph", verbose = T, 
                   resolution = c(0.1,0.15,0.2,0.25,0.3,0.4,0.5), algorithm=2)
# can vary the k.param and resolution parameters

# Use clusters package to help assess the clusters
clustree(sc, prefix = "mgraph_res.")
dev.copy2pdf(file="plot4.pdf",width=10,height=8)

# Select the resolution
Idents(object = sc) <- "mgraph_res.0.25" # Can change 0.25 to 30

# Make PCA plots
DimPlot(sc,reduction="pca",label=TRUE,pt.size=0.75) 
dev.copy2pdf(file="plot5.pdf",width=10,height=8)

DimPlot(sc,reduction="pca",dims=c(2,3),label=TRUE,pt.size=0.75) 
dev.copy2pdf(file="plot6.pdf",width=10,height=8)

DimPlot(sc,reduction="pca",dims=c(3,4),label=TRUE,pt.size=0.75)
dev.copy2pdf(file="plot7.pdf",width=10,height=8)

# Examine data with t-SNE 
# perplexity of 30 is default value, can change

# generate several t-SNE dimension reductions w/ different perplexities
sc<-RunTSNE(sc,reduction="pca",dims=1:100, perplexity = 30, method="FIt-SNE", max_iter=1000,verbose=TRUE,reduction.name="tsne30",reduction.key="tSNE30_")
sc<-RunTSNE(sc,reduction="pca",dims=1:100, perplexity = 60,method="FIt-SNE", max_iter=1000,verbose=TRUE,reduction.name="tsne60",reduction.key="tSNE60_")
sc<-RunTSNE(sc,reduction="pca",dims=1:100, perplexity = 125,method="FIt-SNE", max_iter=1000,verbose=TRUE,reduction.name="tsne125",reduction.key="tSNE125_")
sc<-RunTSNE(sc,reduction="pca",dims=1:100, perplexity = 250,method="FIt-SNE", max_iter=1000,verbose=TRUE,reduction.name="tsne250",reduction.key="tSNE250_")

plot1<-DimPlot(sc,reduction="tsne30",label=TRUE,pt.size=0.75) 
plot2<-DimPlot(sc,reduction="tsne60",label=TRUE,pt.size=0.75) 
plot3<-DimPlot(sc,reduction="tsne125",label=TRUE,pt.size=0.75) 
plot4<-DimPlot(sc,reduction="tsne250",label=TRUE,pt.size=0.75) 
plot_grid(plot1 , plot2 , plot3 , plot4, 
          labels = c("30", "60", "125", "250"), label_size = 12, ncol=2)

DimPlot(sc,reduction="umap",label=TRUE,pt.size=0.75)
dev.off()
dev.copy2pdf(file="plot8.pdf",width=10,height=8)

# Overall, select values for parameters k.param, resolution, perplexity
#best perplexity: 250
# Final t-SNE plot
sc<-RunTSNE(sc,reduction="pca",dims=1:100, perplexity = 125,method="FIt-SNE", max_iter=1000,verbose=TRUE,reduction.name="tsne125",reduction.key="tSNE125_")              
DimPlot(sc,reduction="tsne250",label=TRUE,pt.size=0.75) 
dev.copy2pdf(file="plot9.2_final.pdf",width=10,height=8)


# SECOND PART
# Use ROC method to evaluate extent to which each gene can be used to
# to classify that specific cluster separately from others

sc.markers.roc <- FindAllMarkers(sc, only.pos = TRUE, min.pct = 0.25, 
                                 logfc.threshold = 0.25, test.use="roc")

sc.markers.roc.thresholded <- filter(sc.markers.roc,myAUC >=0.7) 

sc.markers.roc.thresholded.grouped <-
  sc.markers.roc.thresholded %>% group_by(cluster) 

sc.markers.roc.thresholded.grouped.sorted <-
  sc.markers.roc.thresholded.grouped %>% arrange(desc(myAUC),.by_group=TRUE) 

sc.markers.roc.df <- as.data.frame(sc.markers.roc.thresholded.grouped.sorted) 

write.csv(sc.markers.roc.thresholded.grouped.sorted,file="marrow_cluster_markers_1.csv")

# Pick two genes each for a few clusters

# Cluster 0:
FeaturePlot(sc, reduction="tsne250", features = c("Zbtb20","Igfbpl1"), 
            pt.size = 0.75, ncol = 2, order=TRUE)
dev.copy2pdf(file="plot_cluster0.pdf",width=10,height=8)
#VlnPlot(sc, features = c("Zbtb20","Igfbpl1"), ncol=2, log=TRUE)

# Cluster 5: Gjc2, Lpar1
FeaturePlot(sc, reduction="tsne250", features = c("Lpar1","Gjc2"), 
            pt.size = 0.75, ncol = 2, order=TRUE)
dev.copy2pdf(file="plot_cluster5.pdf",width=10,height=8)

# Cluster 10: Lrrc32, Gm13861
FeaturePlot(sc, reduction="tsne250", features = c("Lrrc32","Gm13861"), 
            pt.size = 0.75, ncol = 2, order=TRUE)
dev.copy2pdf(file="plot_cluster10.pdf",width=10,height=8)


