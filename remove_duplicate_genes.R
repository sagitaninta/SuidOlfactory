library(dplyr)
library(stringr)

GeneList <- read.csv(file="GeneList.csv",header = TRUE)
ngenes <- nrow(GeneList)
length(unique(GeneList$PTN.seq))
length(unique(GeneList$DNA.seq))

duplicate_PTN <- GeneList %>% 
  group_by(PTN.seq) %>% 
  filter(n() > 1) %>% 
  mutate(ptn_group_id = cur_group_id()) %>% 
  ungroup() %>% 
  arrange(ptn_group_id) %>% 
  select(CHR..,OR.name,Start,Stop,Strand,DNA.seq,PTN.seq,ptn_group_id)

pseduogene_candidates <- duplicate_PTN %>% 
  group_by(DNA.seq) %>% 
  filter(n() == 1) 

write.table(pseduogene_candidates, file="pseudogene_candidates.csv", sep=",")

non_duplicated_genes <- GeneList %>% 
  group_by(PTN.seq) %>% 
  filter(n() == 1) %>% 
  ungroup() %>% 
  group_by(DNA.seq) %>% 
  filter(n() == 1) %>% 
  ungroup() %>% group_by(OR.name) %>% 
  filter(n() == 1) %>% filter(CHR.. %in% c(1:18))

write.csv(non_duplicated_genes, file="non_duplicated_genes.csv", row.names = FALSE)

nrow(GeneList)
nrow(non_duplicated_genes)