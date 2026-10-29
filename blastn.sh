#!/bin/bash

# ERR173176 – Sumatran Asian Wild Boar
blastn -query olfactory_genes.fasta \
       -db blast_db/ERR173176_Sumatran_Asian_Wild_Boar/ERR173176_Sumatran_Asian_Wild_Boar \
       -out out/ERR173176_Sumatran_Asian_Wild_Boar.tsv \
       -evalue 1e-5 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp sseq"


# GCA_001700255.1 – Pietrain European Domesticate
blastn -query olfactory_genes.fasta \
       -db blast_db/GCA_001700255.1_Pietrain_European_Domesticate/GCA_001700255.1_Pietrain_European_Domesticate \
       -out out/GCA_001700255.1_Pietrain_European_Domesticate.tsv \
       -evalue 1e-5 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp sseq"


# GCA_000003025.6 – Duroc European Domesticate
blastn -query olfactory_genes.fasta \
       -db blast_db/GCA_000003025.6_Duroc_European_Domesticate/GCA_000003025.6_Duroc_European_Domesticate \
       -out out/GCA_000003025.6_Duroc_European_Domesticate.tsv \
       -evalue 1e-5 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp sseq"


# GCA_017957985.1 – Meishan Asian Domesticate
blastn -query olfactory_genes.fasta \
       -db blast_db/GCA_017957985.1_Meishan_Asian_Domesticate/GCA_017957985.1_Meishan_Asian_Domesticate \
       -out out/GCA_017957985.1_Meishan_Asian_Domesticate.tsv \
       -evalue 1e-5 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp sseq"


# GCA_000472085.2 – Tibetan Asian Domesticate
blastn -query olfactory_genes.fasta \
       -db blast_db/GCA_000472085.2_Tibetan_Asian_Domesticate/GCA_000472085.2_Tibetan_Asian_Domesticate \
       -out out/GCA_000472085.2_Tibetan_Asian_Domesticate.tsv \
       -evalue 1e-5 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp sseq"


# GCA_020567905.1 – Ningxiang Asian Domesticate
blastn -query olfactory_genes.fasta \
       -db blast_db/GCA_020567905.1_Ningxiang_Asian_Domesticate/GCA_020567905.1_Ningxiang_Asian_Domesticate \
       -out out/GCA_020567905.1_Ningxiang_Asian_Domesticate.tsv \
       -evalue 1e-5 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp sseq"


# GCA_001700135.1 – Large White European Domesticate
blastn -query olfactory_genes.fasta \
       -db blast_db/GCA_001700135.1_Large_White_European_Domesticat/GCA_001700135.1_Large_White_European_Domesticat \
       -out out/GCA_001700135.1_Large_White_European_Domesticat.tsv \
       -evalue 1e-5 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp sseq"


# GCA_021656055.1 – European Wild Boar
blastn -query olfactory_genes.fasta \
       -db blast_db/GCA_021656055.1_European_Wild_Boar/GCA_021656055.1_European_Wild_Boar \
       -out out/GCA_021656055.1_European_Wild_Boar.tsv \
       -evalue 1e-5 \
       -max_target_seqs 5 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp sseq"
