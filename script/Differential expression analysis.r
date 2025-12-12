#Differential expression analysis


if (! require(edgeR)) {
  source("https://bioconductor.org/biocLite.R")
  biocLite("edgeR")
  library(edgeR)
}

if (! require(DESeq2)) {
  source("https://bioconductor.org/biocLite.R")
  biocLite("DESeq2")
  library(DESeq2)
}

data = read.csv("flag-wt.csv", header=T, row.names=1, com='')
col_ordering = c(1,2,3,4) ##
rnaseqMatrix = data[,col_ordering]
rnaseqMatrix = round(rnaseqMatrix)
rnaseqMatrix = rnaseqMatrix[rowSums(cpm(rnaseqMatrix) > 1) >= 2,] #
conditions = data.frame(conditions=factor(c(rep("s", 2), rep("c", 2)))) #
rownames(conditions) = colnames(rnaseqMatrix)
ddsFullCountTable <- DESeqDataSetFromMatrix(
  countData = rnaseqMatrix,
  colData = conditions,
  design = ~ conditions)
#
#ddsFullCountTable <- estimateSizeFactors(ddsFullCountTable)
#contigThreshold <- 0.3 * nrow(counts(ddsFullCountTable))
#ddsFullCountTable <- ddsFullCountTable[rowSums(counts(ddsFullCountTable) >= 1) >= contigThreshold,]
#
dds = DESeq(ddsFullCountTable)
normalized_counts <- counts(dds, normalized = TRUE)
write.table(normalized_counts, file = "normalized_counts.txt", sep = "\t", quote = FALSE)
contrast=c("conditions","s","c")
res = results(dds, contrast)
baseMeanA <- rowMeans(counts(dds, normalized=TRUE)[,colData(dds)$conditions == "s"])
baseMeanB <- rowMeans(counts(dds, normalized=TRUE)[,colData(dds)$conditions == "c"])
res = cbind(baseMeanA, baseMeanB, as.data.frame(res))
res = cbind(sampleA="s", sampleB="c", as.data.frame(res))
res$padj[is.na(res$padj)]  <- 1
res = as.data.frame(res[order(res$pvalue),])
write.table(res, file='S_vs_NC.txt', sep='\t', quote=FALSE)

