library(dplyr)
library(ggplot2)
library(seqinr)
library(ape)
library(phangorn)
library(purrr)
library(stringr)

#valid topology patterns 
patterns <- list (
  
  #from earlier, the wrong groups
  
  #dom_sister_Asia = c(
  #"AD1_AD2_AWB_EWB" = "((AD1,AD2),AWB,EWB);",
  #"AD1_AD2_AWB_ED1" = "((AD1,AD2),AWB,ED1);",
  #"AD1_AD2_AWB_ED2" = "((AD1,AD2),AWB,ED2);",
  #"AD1_AD2_AWB_ED3" = "((AD1,AD2),AWB,ED3);",
  #"AD1_AD3_AWB_EWB" = "((AD1,AD3),AWB,EWB);",
  #"AD1_AD3_AWB_ED1" = "((AD1,AD3),AWB,ED1);",
  #"AD1_AD3_AWB_ED2" = "((AD1,AD3),AWB,ED2);",
  #"AD1_AD3_AWB_ED3" = "((AD1,AD3),AWB,ED3);",
  #"AD2_AD3_AWB_EWB" = "((AD2,AD3),AWB,EWB);",
  #"AD2_AD3_AWB_ED1" = "((AD2,AD3),AWB,ED1);",
  #"AD2_AD3_AWB_ED2" = "((AD2,AD3),AWB,ED2);",
  #"AD2_AD3_AWB_ED3" = "((AD2,AD3),AWB,ED3);"
  #),
  
  #dom_sister_Europe = c(
    #"ED1_ED2_EWB_AWB" = "((ED1,ED2),EWB,AWB);",
    #"ED1_ED2_EWB_AD1" = "((ED1,ED2),EWB,AD1);",
    #"ED1_ED2_EWB_AD2" = "((ED1,ED2),EWB,AD2);",
    #"ED1_ED2_EWB_AD3" = "((ED1,ED2),EWB,AD3);",
    #"ED1_ED3_EWB_AWB" = "((ED1,ED3),EWB,AWB);",
    #"ED1_ED3_EWB_AD1" = "((ED1,ED3),EWB,AD1);",
    #"ED1_ED3_EWB_AD2" = "((ED1,ED3),EWB,AD2);",
    #"ED1_ED3_EWB_AD3" = "((ED1,ED3),EWB,AD3);",
    #"ED2_ED3_EWB_AWB" = "((ED2,ED3),EWB,AWB);",
    #"ED2_ED3_EWB_AD1" = "((ED2,ED3),EWB,AD1);",
    #"ED2_ED3_EWB_AD2" = "((ED2,ED3),EWB,AD2);",
    #"ED2_ED3_EWB_AD3" = "((ED2,ED3),EWB,AD3);"
  #),
  
  region_sister_Asia = c(
    "AD1_AWB_ED1_ED2" = "((AD1,AWB),(ED1,ED2));",
    "AD1_AWB_ED1_ED3" = "((AD1,AWB),(ED1,ED3));",
    "AD1_AWB_ED2_ED3" = "((AD1,AWB),(ED2,ED3));",
    "AD1_AWB_ED1_EWB" = "((AD1,AWB),(ED1,EWB));",
    "AD1_AWB_ED2_EWB" = "((AD1,AWB),(ED2,EWB));",
    "AD1_AWB_ED3_EWB" = "((AD1,AWB),(ED3,EWB));",
    "AD2_AWB_ED1_ED2" = "((AD2,AWB),(ED1,ED2));",
    "AD2_AWB_ED1_ED3" = "((AD2,AWB),(ED1,ED3));",
    "AD2_AWB_ED2_ED3" = "((AD2,AWB),(ED2,ED3));",
    "AD2_AWB_ED1_EWB" = "((AD2,AWB),(ED1,EWB));",
    "AD2_AWB_ED2_EWB" = "((AD2,AWB),(ED2,EWB));",
    "AD2_AWB_ED3_EWB" = "((AD2,AWB),(ED3,EWB));",
    "AD3_AWB_ED1_ED2" = "((AD3,AWB),(ED1,ED2));",
    "AD3_AWB_ED1_ED3" = "((AD3,AWB),(ED1,ED3));",
    "AD3_AWB_ED2_ED3" = "((AD3,AWB),(ED2,ED3));",
    "AD3_AWB_ED1_EWB" = "((AD3,AWB),(ED1,EWB));",
    "AD3_AWB_ED2_EWB" = "((AD3,AWB),(ED2,EWB));",
    "AD3_AWB_ED3_EWB" = "((AD3,AWB),(ED3,EWB));"
    ),
  
  region_sister_Europe = c(
    "ED1_EWB_AD1_AD2" = "((ED1,EWB),(AD1,AD2));",
    "ED1_EWB_AD1_AD3" = "((ED1,EWB),(AD1,AD3));",
    "ED1_EWB_AD2_AD3" = "((ED1,EWB),(AD2,AD3));",
    "ED1_EWB_AD1_AWB" = "((ED1,EWB),(AD1,AWB));",
    "ED1_EWB_AD2_AWB" = "((ED1,EWB),(AD2,AWB));",
    "ED1_EWB_AD3_AWB" = "((ED1,EWB),(AD3,AWB));",
    "ED2_EWB_AD1_AD2" = "((ED2,EWB),(AD1,AD2));",
    "ED2_EWB_AD1_AD3" = "((ED2,EWB),(AD1,AD3));",
    "ED2_EWB_AD2_AD3" = "((ED2,EWB),(AD2,AD3));",
    "ED2_EWB_AD1_AWB" = "((ED2,EWB),(AD1,AWB));",
    "ED2_EWB_AD2_AWB" = "((ED2,EWB),(AD2,AWB));",
    "ED2_EWB_AD3_AWB" = "((ED2,EWB),(AD3,AWB));",
    "ED3_EWB_AD1_AD2" = "((ED3,EWB),(AD1,AD2));",
    "ED3_EWB_AD1_AD3" = "((ED3,EWB),(AD1,AD3));",
    "ED3_EWB_AD2_AD3" = "((ED3,EWB),(AD2,AD3));",
    "ED3_EWB_AD1_AWB" = "((ED3,EWB),(AD1,AWB));",
    "ED3_EWB_AD2_AWB" = "((ED3,EWB),(AD2,AWB));",
    "ED3_EWB_AD3_AWB" = "((ED3,EWB),(AD3,AWB));"
  )
)

#read in taxids and define shorthand lookup
taxa_info <- data.frame(
  id =     c("ERR173176_Sumatran_Asian_Wild_Boar",
             "GCA_000472085.2_Tibetan_Asian_Domesticate",
             "GCA_017957985.1_Meishan_Asian_Domesticate",
             "GCA_020567905.1_Ningxiang_Asian_Domesticate",  
             "GCA_021656055.1_European_Wild_Boar", 
             "GCA_000003025.6_Duroc_European_Domesticate",
             "GCA_001700255.1_Pietrain_European_Domesticate",
             "GCA_001700135.1_Large_White_European_Domesticat"),  
  region = c(rep("Asian", 4), rep("European", 4)),
  type = c("wild", rep("dom", 3), "wild", rep("dom", 3))
)

short_labels <- c(
  "AWB", "AD1", "AD2", "AD3",  
  "EWB", "ED1", "ED2", "ED3"   
)

lookup <- set_names(short_labels, taxa_info$id)

#read in MSAs

rename_fasta_headers <- function(phyDat_obj, lookup) {
  old_names <- names(phyDat_obj)
  matched <- lookup[sapply(old_names, function(n) {
    hit <- which(sapply(names(lookup), function(k) startsWith(n, k)))
    if (length(hit) == 1) names(lookup)[hit] else NA
  })]
  names(phyDat_obj) <- matched
  phyDat_obj
}

to_phyDat <- function(seqinr_list) {
  char_list <- lapply(seqinr_list, function(s) strsplit(s, "")[[1]])
  phydat_obj <- phangorn::phyDat(char_list, type = "DNA")
  phydat_obj
}

files <- list.files(path = "macse_dna_alignments_2026", 
                    pattern = "_NT\\.aln$",
                    full.names = TRUE)

alignments <- files %>%
  lapply(read.fasta, as.string = TRUE, forceDNAtolower = FALSE) %>%
  lapply(rename_fasta_headers, lookup = lookup) %>%
  lapply(to_phyDat)

# finding internal branch length
cherry_from_name <- function(pattern_name) {
  strsplit(pattern_name, "_")[[1]][1:2]
}

#old function, where the branch length was to the cherry. Now, it's the branch length from the mrca to the tip, for each pair. so two branch lengths are now recorded. new function is written

#get_cherry_branch <- function(tree, cherry_tips) {
  #Ntip <- length(tree$tip.label)
  #all_tips <- tree$tip.label
  #other_tips <- setdiff(all_tips, cherry_tips)
  
  #internal_rows <- which(tree$edge[, 1] > Ntip & tree$edge[, 2] > Ntip)
  #for (row in internal_rows) {
    #desc_tips <- tree$tip.label[phangorn::Descendants(tree, tree$edge[row, 2], type = "tips")[[1]]]
    #if (setequal(desc_tips, cherry_tips) || setequal(desc_tips, other_tips)) {
      #return(tree$edge.length[row])
    #}
  #}
  #root_node <- Ntip + 1
  #child_rows <- which(tree$edge[, 1] == root_node)
  #for (row in child_rows) {
    #child <- tree$edge[row, 2]
    #if (child > Ntip) {
      #desc_tips <- tree$tip.label[phangorn::Descendants(tree, child, type = "tips")[[1]]]
      #if (setequal(desc_tips, cherry_tips) || setequal(desc_tips, other_tips)) {
        #return(tree$edge.length[row])
      #}
    #}
  #}
  
  #stop("No internal edge found separating cherry from rest: ", paste(cherry_tips, collapse = ","))
#}


#calc internal branch length for all genes and all topologies 
run_all_fits <- function(patterns, alignments, files) {
  results <- list()
  skipped <- list()
  
  for (group_name in names(patterns)) {
    group <- patterns[[group_name]]
    
    for (pattern_name in names(group)) {
      newick <- group[[pattern_name]]
      cherry_tips <- cherry_from_name(pattern_name)
      
      tree <- ape::read.tree(text = newick)
      tree$edge.length <- rep(0.1, nrow(tree$edge))
      
      for (i in seq_along(alignments)) {
        gene <- sub("_NT\\.aln$", "", basename(files[i]))  
        chrom <- sub(".*_(chr_\\d+)_.*", "\\1", basename(files[i]))  
        
        missing_taxa <- setdiff(tree$tip.label, names(alignments[[i]]))

        if (length(missing_taxa) > 0) {
          skipped[[length(skipped) + 1]] <- data.frame(
          gene = gene, chromosome = chrom,
          topology_group = group_name, pattern = pattern_name,
          missing_taxa = paste(missing_taxa, collapse = ","),
          reason = "missing taxa"
          )
          next 
        }

      aln_subset <- alignments[[i]][tree$tip.label]
      aln_subset_bn <- as.DNAbin(aln_subset)
              
        #change from original script to add the distance matrix calculation
        dm <- ape::dist.dna(aln_subset_bn, model = "TN93", pairwise.deletion = TRUE)
        print(round(as.matrix(dm), 6))
        #change from the original script to use phangorn::nnls instead of  #phangorn::pml
        nlls_tree <- tryCatch(
          phangorn::nnls.tree(dm, tree, method = "unrooted"),
          error = function(e) {
            skipped[[length(skipped) + 1]] <<- data.frame(
            gene = gene, chromosome = chrom,
            topology_group = group_name, pattern = pattern_name,
            missing_taxa = NA_character_,
            reason = paste("nnls.tree failed:", conditionMessage(e))
            )
            NULL
          }
        )
        if (is.null(nlls_tree)) next

        #no longer use the function, because we now record two distances  
        #branch_len <- get_cherry_branch(nlls_tree, cherry_tips)

        domesticate_node <- keep(cherry_tips, ~ str_detect(.x, "D"))
        wild_node        <- keep(cherry_tips, ~ str_detect(.x, "W"))

        if (length(domesticate_node) != 1 | length(wild_node) != 1) {
          cat("ERROR: more than one domesticate or wild detected")
          break
        }

        mrca_node <- getMRCA(nlls_tree, c(domesticate_node, wild_node))
        tip_index_dom  <- which(nlls_tree$tip.label == domesticate_node)
        tip_index_wild <- which(nlls_tree$tip.label == wild_node)

        path_nodes_dom  <- nodepath(nlls_tree, from = tip_index_dom,  to = mrca_node)
        path_nodes_wild <- nodepath(nlls_tree, from = tip_index_wild, to = mrca_node)

        branch_len_dom  <- sum(nlls_tree$edge.length[nlls_tree$edge[, 2] %in% path_nodes_dom])
        branch_len_wild <- sum(nlls_tree$edge.length[nlls_tree$edge[, 2] %in% path_nodes_wild])

        if (branch_len_wild < 0.0001 | branch_len_dom <= 0.0001 ) {
          skipped[[length(skipped) + 1]] <- data.frame(
          gene = gene, chromosome = chrom,
          topology_group = group_name, pattern = pattern_name,
          missing_taxa = paste(missing_taxa, collapse = ","),
          reason = "branch length near zero"
          )
          next
        }

        if (length(branch_len_wild) != 1 | length(branch_len_dom) != 1) {
          cat("MISMATCH:", pattern_name, "|", gene, "\n")
          cat("cherry_tips:", cherry_tips, "\n")
          cat("tree tip labels:", fit_opt$tree$tip.label, "\n")
          cat("getMRCA result:", ape::getMRCA(fit_opt$tree, cherry_tips), "\n")
          next
        }
        
        results[[length(results) + 1]] <- data.frame(
          gene = gene, 
          chromosome = chrom,
          topology_group = group_name, 
          pattern = pattern_name,
          branch_len_wild = branch_len_wild,
          branch_len_dom = branch_len_dom
        )
      }
    }
  }
  
  list(results = do.call(rbind, results),
       skipped = do.call(rbind, skipped))
}

results <- run_all_fits(patterns, alignments, files)
to_plot <- results$results %>% mutate (
  chromosome = gsub("^(chr_\\d+)_.*$", "\\1", chromosome),
  comparison = gsub("_.*", "", topology_group),
  region = gsub(".*_", "", topology_group)
)

#save data frame 

write.table(to_plot,         file = "data_frame_results.txt")
write.table(results$skipped, file = "skipped_results.txt")
#plot

#plot <- ggplot(to_plot, aes(x=topology_group, y=cherry_branch_length, color = region))+
  #geom_violin()+
  #facet_wrap(~chromosome)+
  #theme_bw()+ 
  #labs(y="branch length")

#plot_no_wrap <- ggplot(to_plot, aes(x=topology_group, y=cherry_branch_length, color = region))+
  #geom_violin()+
  #theme_bw()+
  #labs(y="branch length")

#ggsave("tree_mean_branch_by_chrom.pdf", plot = plot, width = 7, height = 4)
#ggsave("tree_mean_branch_mean.pdf", plot = plot_no_wrap, width = 7, height = 4)
