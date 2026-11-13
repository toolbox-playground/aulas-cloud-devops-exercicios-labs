#!/usr/bin/env bash
# Uso: bash scripts/setup.sh --state healthy|broken
source "$(dirname "$0")/lib.sh"
parse_state healthy "$@"
preflight
info "Gravando a configuração saudável do Nginx"
write_healthy_conf
info "Subindo o projeto $PROJECT (backend + proxy)"
compose up -d --wait --wait-timeout 90
reload_proxy   # se o proxy já estava no ar, aplica a configuração regravada
bash "$LAB_DIR/scripts/verify.sh" --state healthy
if [ "$STATE" = broken ]; then bash "$LAB_DIR/scripts/inject-fault.sh" upstream-port; fi
ok "Lab 006 pronto no estado: $STATE"
