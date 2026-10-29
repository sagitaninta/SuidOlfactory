import pandas as pd

# Best BLAST hits
blast = pd.read_csv(
    "odor_matches.best.tsv",
    sep="\t"
)

# Extract UniProt accession
blast["UniProt"] = (
    blast["Subject"]
    .str.split("|")
    .str[1]
)

# Extract receptor name from BLAST hit
blast["Matched_Receptor"] = (
    blast["Subject"]
    .str.split("|")
    .str[2]
)

# OlfactionBase file
odor = pd.read_excel("or-odorant.xlsx")

# Clean UniProt IDs
odor["UniProt"] = odor["UniProt"].astype(str).str.strip()
blast["UniProt"] = blast["UniProt"].astype(str).str.strip()

# Merge
merged = blast.merge(
    odor,
    on="UniProt",
    how="left"
)

# Save
merged.to_csv(
    "gene_odor_annotations.tsv",
    sep="\t",
    index=False
)

print(f"Genes: {blast['Gene'].nunique()}")
print(f"Rows after merge: {len(merged)}")
print(f"Genes with odor associations: {merged['Odorant'].notna().sum()}")
