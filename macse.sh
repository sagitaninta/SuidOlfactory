#!/bin/bash

# Directory containing your ~1000 .fasta files
INPUT_DIR="/home/people/emegbr/projects/sus/paper/macse/input"

# Directory where MACSE outputs should be placed
OUTPUT_DIR="/home/people/emegbr/projects/sus/paper/macse/output"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "Running MACSE on all fasta files in: $INPUT_DIR"
echo "Output will be saved in: $OUTPUT_DIR"
echo ""

# Loop through all FASTA files
for fasta in "${INPUT_DIR}"/*.fasta; do
    filename=$(basename "$fasta" .fasta)

    echo "Aligning: $filename"

    macse \
      -prog alignSequences \
      -seq "$fasta" \
      -out_NT "${OUTPUT_DIR}/${filename}_NT.aln" \
      -out_AA "${OUTPUT_DIR}/${filename}_AA.aln"

    echo "  → Completed $filename"
    echo ""
done

echo "All MACSE alignments finished!"
