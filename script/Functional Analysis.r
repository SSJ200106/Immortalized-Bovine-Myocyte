#Functional Analysis



library(clusterProfiler)
library("org.Bt.eg.db")


g_list <- read.table("geneid.txt")

kegg <- enrichKEGG(gene = g_list, 
                 organism = "bta",  
                 pvalueCutoff =1, 
                 qvalueCutoff = 1) 

write.table(kegg,file="kegg.txt",sep="\t",quote=F,row.names = F)  


g_list <- read.table("geneid.txt")

BP <- enrichGO(gene = g_list,
               OrgDb = org.Bt.eg.db,
               pvalueCutoff =1,
               qvalueCutoff = 1,
               ont="BP", #BP、MF、CC
               readable =T)
CC <- enrichGO(gene = g_list,
               OrgDb = org.Bt.eg.db,
               pvalueCutoff =0.5,
               qvalueCutoff = 0.5,
               ont="CC", #BP、MF、CC
               readable =T)
MF <- enrichGO(gene = g_list,
               OrgDb = org.Bt.eg.db,
               pvalueCutoff =0.5,
               qvalueCutoff = 0.5,
               ont="MF", #BP、MF、CC
               readable =T)
