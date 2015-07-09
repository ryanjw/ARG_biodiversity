library(reshape2)
library(vegan)
######
data<-read.table("~/Google Drive/postdoc_writing/ARG/ARG_products/ARG_data_round2/summary-count.tsv",header=T,sep="\t",check.names=F)
head(data[,1:10])
dim(data)
names(data)[-873]<-names(data)[-1]
data<-data[,-873]
data<-cbind(rownames(data),data)
names(data)[1]<-"ARG"
data_melt<-melt(data, id="ARG")
data_melt<-subset(data_melt, value > 0)
length(unique(data_melt$ARG))

#starting with 2819 different ARGs

# First we are going  to look at database comparisons

refsoil<-read.table("~/Google Drive/postdoc_writing/ARG/old_ARG_stuff/files-for-analysis/RefSoil_ARGs_for_taxonomic_comparison.txt",header=TRUE, strip.white=TRUE)
head(refsoil)

# I want to figure out which ARG genes show up in the most refsoil genomes (e.g. richness) and how phylogenetically diverse those are
refsoil_cast<-dcast(refsoil, id~V2, value.var="value",fun.aggregate=sum, fill=0)

# 1880 ARGs were detected in refsoil

refsoil_div<-data.frame(refsoil_cast$id,specnumber(refsoil_cast[,-1]))
names(refsoil_div)<-c("id","richness")
head(arrange(refsoil_div,-richness))
hist(refsoil_div$richness)
# need to figure out what those id's are
ids<-read.table("~/Google Drive/postdoc_writing/ARG/old_ARG_stuff/files-for-analysis/full_ids.txt",header=TRUE, strip.white=TRUE,sep="\t")
refsoil_div<-merge(refsoil_div, ids,by="id")

