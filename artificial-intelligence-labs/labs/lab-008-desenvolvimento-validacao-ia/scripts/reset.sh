#!/usr/bin/env bash
# Descarta a cópia de trabalho app/ (só ela) e cria uma nova a partir do starter.
set -euo pipefail
LAB_DIR="$(cd "$(dirname "$0")/.." && pwd)"
rm -rf "$LAB_DIR/app"
bash "$LAB_DIR/scripts/setup.sh"
