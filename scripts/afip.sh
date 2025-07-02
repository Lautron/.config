#!/bin/bash

read -p "Enter amount in USD: " usd
read -p "Enter exchange rate: " rate

# Eliminar comas (por separador de miles) y reemplazar comas decimales por punto si hiciera falta
usd_clean=$(echo "$usd" | tr -d ',' | tr ',' '.')
rate_clean=$(echo "$rate" | tr -d ',' | tr ',' '.')

# Calcular total en ARS con 3 decimales de precisión
total_ars=$(awk "BEGIN { printf \"%.3f\", $usd_clean * $rate_clean }")

declare -A values=(
  ["cuit pais"]="55000004382"
  ["razon social"]="Morphais HSTL Technologies GmbH"
  ["domicilio"]="Berlin, Germany"
  ["forma de pago"]="Contado"
  ["Descripcion"]="Honorarios por servicio de desarrollo web"
  ["Precio unitario"]="$total_ars"
  ["Otros datos"]="Son $usd USD a tipo de cambio $rate pesos por USD"
)

ordered_keys=(
  "cuit pais"
  "razon social"
  "domicilio"
  "forma de pago"
  "Descripcion"
  "Precio unitario"
  "Otros datos"
)

for key in "${ordered_keys[@]}"; do
  echo -n "${values[$key]}" | wl-copy
  notify-send "Copiado '$key'" "${values[$key]}"
  echo "Presiona Enter para continuar con el siguiente valor (o Ctrl+C para cancelar)..."
  read -r
done
