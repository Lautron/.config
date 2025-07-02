#!/bin/bash
for file in "$@"; do
  pandoc -M documentclass=scrartcl -M numbersections=true --toc --toc-depth=4 --highlight-style tango -f markdown -t latex "$file" -o "${file%.md}.pdf"
done
