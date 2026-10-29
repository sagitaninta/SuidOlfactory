import pandas as pd

blast = pd.read_csv(
    "odor_matches.filtered.tsv",
    sep="\t",
    header=None,
    names=[
        "Gene",
        "Subject",
        "pident",
        "length",
        "qcovs",
        "evalue",
        "bitscore"
    ]
)

best = (
    blast.sort_values("bitscore", ascending=False)
         .drop_duplicates("Gene")
)

best.to_csv(
    "odor_matches.best.tsv",
    sep="\t",
    index=False
)
