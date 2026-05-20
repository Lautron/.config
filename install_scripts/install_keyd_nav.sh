#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KEYD_SOURCE="${SCRIPT_DIR}/../keyd/default.conf"
KEYD_TARGET_DIR="/etc/keyd"
KEYD_TARGET="${KEYD_TARGET_DIR}/default.conf"

if [[ ! -f "${KEYD_SOURCE}" ]]; then
  echo "Missing keyd source config: ${KEYD_SOURCE}" >&2
  exit 1
fi

sudo mkdir -p "${KEYD_TARGET_DIR}"
sudo install -m 644 "${KEYD_SOURCE}" "${KEYD_TARGET}"

sudo keyd check
sudo systemctl enable --now keyd.service
sudo keyd reload

echo "Installed ${KEYD_SOURCE} -> ${KEYD_TARGET}"
