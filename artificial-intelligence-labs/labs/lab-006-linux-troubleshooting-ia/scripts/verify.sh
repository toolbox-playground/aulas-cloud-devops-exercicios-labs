#!/usr/bin/env bash
# Uso: bash scripts/verify.sh --state healthy|broken
source "$(dirname "$0")/lib.sh"
parse_state healthy "$@"

backend_healthy || die "O backend não respondeu /health dentro do container."
ok "backend saudável na porta 8000 (dentro da rede do Compose)"
if [ "$STATE" = healthy ]; then
  wait_code "$URL" 200 15
  body="$(curl -s -m 3 "$URL")"
  [ "$body" = "ok" ] || die "O proxy devolveu 200, mas o corpo foi '$body' (esperado: ok)."
  ok "proxy: $URL → HTTP 200, corpo 'ok'"
else
  wait_code "$URL" 502 15
  ok "proxy: $URL → HTTP 502 (Bad Gateway), com o backend saudável"
fi
