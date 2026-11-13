#!/usr/bin/env bash
# Remove a cópia de trabalho app/. Não encerra processos: pare o 'npm run dev' com Ctrl+C.
set -euo pipefail
LAB_DIR="$(cd "$(dirname "$0")/.." && pwd)"
rm -rf "$LAB_DIR/app"
echo " OK app/ removida"
