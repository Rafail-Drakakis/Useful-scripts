#!/bin/bash

# Find all .tex files recursively
find . -type f -name '*.tex' | while read -r texfile; do
    # Navigate to the directory containing the .tex file
    cd "$(dirname "$texfile")" || exit

    # Compile the .tex file to PDF
    pdflatex -interaction=batchmode "$(basename "$texfile")"

    # Remove auxiliary files
    rm -f *.aux *.log *.out

    # Delete the .tex file
    rm -f "$(basename "$texfile")"

    # Return to the original directory
    cd - >/dev/null || exit
done
