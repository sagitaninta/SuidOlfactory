import pandas as pd
import requests
import time

# Read Excel file
df = pd.read_excel("or-odorant.xlsx")

# Get unique UniProt accessions
ids = sorted(df["UniProt"].dropna().unique())

print(f"Found {len(ids)} unique UniProt IDs")

with open("OR_reference.fa", "w") as out:
    for acc in ids:
        url = f"https://rest.uniprot.org/uniprotkb/{acc}.fasta"
        r = requests.get(url)

        if r.status_code == 200:
            out.write(r.text)
            print(f"Downloaded {acc}")
        else:
            print(f"Failed: {acc}")

        time.sleep(0.1)  # be gentle to UniProt

print("Done.")
