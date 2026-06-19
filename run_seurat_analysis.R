#!/usr/bin/env Rscript
# 1. Capture dynamic inputs passed from Nextflow's sandbox environment
args <- commandArgs(trailingOnly = TRUE)
input_path <- args[1]

cat("Dynamic Input File Received Path:", input_path, "\n")
library(Seurat)
library(utils)

cat("Step 1: Loading a real single-cell demonstration dataset...\n")
data('pbmc_small', package='Seurat')
pbmc <- pbmc_small

cat("Step 2: Calculating Mitochondrial QC percentages...\n")
pbmc[['percent.mito']] <- PercentageFeatureSet(pbmc, pattern = '^MT-')

# Save a real QC Scatter plot image file
png('qc_mitochondrial_plot.png', width=600, height=600)
FeatureScatter(pbmc, feature1 = 'nCount_RNA', feature2 = 'percent.mito')
dev.off()

cat("Step 3: Running Log-Normalization and Scaling...\n")
pbmc <- NormalizeData(pbmc, normalization.method = 'LogNormalize', scale.factor = 10000)
pbmc <- FindVariableFeatures(pbmc, selection.method = 'vst', nfeatures = 20)
pbmc <- ScaleData(pbmc, features = rownames(pbmc))

cat("Step 4: Finding cluster-specific Differentially Expressed Genes (DEGs)...\n")
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc), verbose = FALSE)
pbmc <- FindNeighbors(pbmc, dims = 1:5, verbose = FALSE)
pbmc <- FindClusters(pbmc, resolution = 0.8, verbose = FALSE)

# Calculate real DEGs using standard Wilcoxon Rank Sum test
degs <- FindAllMarkers(pbmc, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25, verbose = FALSE)

# Save the top DEGs list as a clean CSV report file
write.csv(degs, file='cluster_deg_markers.csv', row.names = FALSE)

# Save the complete active analytical environment
saveRDS(pbmc, file='seurat_final_object.rds')
cat("Analysis complete! Generated 1 PNG figure and 1 DEG marker dataset.\n")
