#!/usr/bin/env bash
# Funções comuns do lab 006. Compatível com bash 3.2 (macOS), Linux e WSL.
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WS="$LAB_DIR/workspace"
PROJECT="tbx-aiops-linux"
URL="http://127.0.0.1:18080/health"
CONF="$WS/nginx/default.conf"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m OK\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31mERRO\033[0m %s\n' "$*" >&2; exit 1; }

compose() { docker compose --project-directory "$WS" -f "$WS/compose.yaml" "$@"; }

preflight() {
  command -v docker >/dev/null || die "Docker não encontrado. Instale o Docker Desktop (macOS/Windows) ou o Docker Engine (Linux)."
  docker info >/dev/null 2>&1 || die "O Docker não está rodando. Abra o Docker Desktop ou inicie o serviço docker."
  docker compose version >/dev/null 2>&1 || die "Docker Compose v2 não encontrado (comando 'docker compose')."
  command -v curl >/dev/null || die "curl não encontrado."
  local owner
  owner="$(docker ps --filter publish=18080 --format '{{.Label "com.docker.compose.project"}}' | head -n1)"
  if [ -n "$owner" ] && [ "$owner" != "$PROJECT" ]; then
    die "A porta 18080 já está em uso pelo projeto '$owner'. Pare esse container antes de continuar."
  fi
}

# código HTTP da URL (000 quando não conecta)
http_code() { curl -s -o /dev/null -m 3 -w '%{http_code}' "$1" || true; }

# espera até a URL devolver o código esperado, com limite de tempo
wait_code() {
  local url="$1" want="$2" limit="${3:-30}" i=0 got=""
  while [ "$i" -lt "$limit" ]; do
    got="$(http_code "$url")"
    [ "$got" = "$want" ] && return 0
    sleep 1; i=$((i + 1))
  done
  die "Esperava HTTP $want em $url e recebi $got depois de ${limit}s."
}

backend_healthy() {
  compose exec -T backend python3 -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://127.0.0.1:8000/health', timeout=2).read().strip()==b'ok' else 1)" >/dev/null 2>&1
}

write_healthy_conf() {
  cat > "$CONF" <<'CONF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://backend:8000;
        proxy_set_header Host $host;
    }
}
CONF
}

reload_proxy() { compose exec -T proxy nginx -s reload >/dev/null 2>&1 || compose restart proxy >/dev/null; }

# lê --state X (ou --state=X); usa o padrão quando não informado
parse_state() {
  local default="$1"; shift
  STATE="$default"
  if [ "${1:-}" = "--state" ]; then STATE="${2:-}"; elif [ -n "${1:-}" ]; then STATE="${1#--state=}"; fi
  case "$STATE" in healthy|broken) ;; *) die "Use --state healthy ou --state broken" ;; esac
}
