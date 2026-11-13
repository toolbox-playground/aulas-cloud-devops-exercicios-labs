#!/usr/bin/env bash
# Uso: bash scripts/inject-fault.sh upstream-port
# Injeta UMA falha: o proxy passa a encaminhar para backend:8001 (o backend escuta na 8000).
source "$(dirname "$0")/lib.sh"
[ "${1:-}" = "upstream-port" ] || die "Uso: bash scripts/inject-fault.sh upstream-port"
info "Conferindo o estado saudável antes de injetar a falha"
bash "$LAB_DIR/scripts/verify.sh" --state healthy
info "Injetando a falha"
tmp="$(mktemp)"; sed 's#proxy_pass http://backend:8000;#proxy_pass http://backend:8001;#' "$CONF" > "$tmp" && cat "$tmp" > "$CONF" && rm -f "$tmp"
grep -q 'backend:8001' "$CONF" || die "Não consegui alterar $CONF."
reload_proxy
bash "$LAB_DIR/scripts/verify.sh" --state broken
ok "Falha injetada. Agora abra o agente dentro de workspace/."
