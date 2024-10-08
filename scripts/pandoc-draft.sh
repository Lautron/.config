#!/bin/bash
for file in "$@"; do
  pandoc -M documentclass=scrartcl -M numbersections=true \
      -f markdown -t latex "$file" -o "${file%.md}.pdf" --lua-filter ~/.config/scripts/remove-images.lua
done
