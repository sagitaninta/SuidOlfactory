awk -F',' '
NR > 1 {
    # Remove quotes everywhere
    gsub(/"/, "", $0)

    chr  = $1      # CHR..
    name = $3      # OR.name
    seq  = $9      # DNA.seq

    print ">chr_" chr "_" name
    print seq
}
' non_duplicated_genes.csv > olfactory_genes.fasta
