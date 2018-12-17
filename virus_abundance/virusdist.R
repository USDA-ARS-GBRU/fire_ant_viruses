library(ggplot2)
library(RColorBrewer)
setwd("~/Documents/collaboratorProjects/fire_ant_viruses/virus_abundance/")
dat<- read.table("all.scaf.txt", sep="\t")
dat$name<- gsub("_"," ",dat$name)
dat$sample <-substr(dat$V1, 1,1) 
dat$sample <- gsub("1","1 Worker", dat$sample)
dat$sample <- gsub("2","2 Worker", dat$sample)
dat$sample <- gsub("3","3 Worker", dat$sample)
dat$sample <- gsub("4","4 Worker", dat$sample)
dat$sample <- gsub("5","5 Brood", dat$sample)
dat$sample <- gsub("6","6 Brood", dat$sample)
dat$sample <- gsub("7","7 Dead", dat$sample)
dat$sample <- gsub("8","8 Dead", dat$sample)
names(dat) <-c('sample_long','name',' PctunambiguousReads','unambiguousMB','PctambiguousReads','ambiguousMB', 'unambiguousReads',	'ambiguousReads',"sample")

ggplot(dat, aes(fill=name, y=unambiguousReads, x=sample)) + 
  geom_bar( stat="identity", position="fill") + ylab("Proportion of virus reads") +
  xlab("Sample") + scale_fill_brewer(palette="Set3")

write.csv(dat, "counts.csv")
