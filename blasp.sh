blastp \
  -query all_ORs.prot.fa \
  -db odor_db \
  -out odor_matches.tsv \
  -outfmt '6 qseqid sseqid pident length qcovs evalue bitscore'
