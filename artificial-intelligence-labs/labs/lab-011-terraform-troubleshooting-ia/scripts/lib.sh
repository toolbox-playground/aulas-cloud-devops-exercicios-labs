#!/usr/bin/env bash
# Funções comuns do lab 011. Compatível com bash 3.2 (macOS), Linux e WSL.
set -euo pipefail
LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WS="$LAB_DIR/workspace"
TPL_OK="$WS/templates/nginx.conf.tftpl"
TPL_RENOMEADO="$WS/templates/proxy.conf.tftpl"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m OK\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31mERRO\033[0m %s\n' "$*" >&2; exit 1; }
tf()   { terraform -chdir="$WS" "$@"; }

parse_state() {
  local default="$1"; shift
  STATE="$default"
  if [ "${1:-}" = "--state" ]; then STATE="${2:-}"; elif [ -n "${1:-}" ]; then STATE="${1#--state=}"; fi
  case "$STATE" in healthy|broken) ;; *) die "Use --state healthy ou --state broken" ;; esac
}

preflight() {
  command -v terraform >/dev/null || die "Terraform não encontrado. Veja https://developer.hashicorp.com/terraform/install"
}

# desfaz a falha: o template volta ao nome que o main.tf usa
restore_template() { if [ -f "$TPL_RENOMEADO" ] && [ ! -f "$TPL_OK" ]; then mv "$TPL_RENOMEADO" "$TPL_OK"; fi; }
