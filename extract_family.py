#!/usr/bin/env python3

import re
import pandas as pd

fasta_file = "olfactory_genes.fasta"
output_file = "or_gene_annotations.txt"

results = []

with open(fasta_file) as f:
    for line in f:
        if not line.startswith(">"):
            continue

        header = line.strip()[1:]  # remove '>'

        # Extract OR gene name from FASTA header
        m_or = re.search(r"(sOR\d+[A-Z]\d+[A-Z]?P?)", header)

        if not m_or:
            continue

        gene_name = m_or.group(1)

        # Parse OR nomenclature
        m = re.match(r"sOR(\d+)([A-Z])(\d+)([A-Z]?)(P?)$", gene_name)

        if not m:
            continue

        family = m.group(1)
        subfamily = m.group(2)
        member = m.group(3)

        # Append duplicate identifier (A/B/C) to member if present
        duplicate = m.group(4)
        if duplicate:
            member = f"{member}{duplicate}"

        results.append({
            "GeneName": gene_name,
            "Family": family,
            "Subfamily": subfamily,
            "Member": member
        })

df = pd.DataFrame(results)

# Save as tab-separated text file
df.to_csv(output_file, sep="\t", index=False)

print(f"Parsed {len(df)} genes")
print(f"Saved to {output_file}")
