#!/usr/bin/env bash
# Uso: bash scripts/setup.sh --case healthy|broken|unavailable
# Reaproveita o ambiente do lab 006 (não copia configuração).
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
L006="$HERE/../lab-006-linux-troubleshooting-ia"
CASE="healthy"; if [ "${1:-}" = "--case" ]; then CASE="${2:-}"; elif [ -n "${1:-}" ]; then CASE="${1#--case=}"; fi
case "$CASE" in
  healthy)     bash "$L006/scripts/setup.sh" --state healthy ;;
  broken)      bash "$L006/scripts/setup.sh" --state broken ;;
  unavailable) bash "$L006/scripts/setup.sh" --state healthy
               docker compose -p tbx-aiops-linux stop
               printf '\033[1;32m OK\033[0m ambiente indisponível: containers do projeto tbx-aiops-linux parados (só eles)\n' ;;
  *) echo "Uso: bash scripts/setup.sh --case healthy|broken|unavailable" >&2; exit 1 ;;
esac
