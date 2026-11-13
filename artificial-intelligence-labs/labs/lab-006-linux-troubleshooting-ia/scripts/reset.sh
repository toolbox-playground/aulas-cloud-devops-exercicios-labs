#!/usr/bin/env bash
# Uso: bash scripts/reset.sh --state healthy|broken  (volta o lab ao estado pedido, sem recriar tudo)
source "$(dirname "$0")/lib.sh"
parse_state broken "$@"
write_healthy_conf
compose up -d --wait --wait-timeout 90 >/dev/null
reload_proxy
bash "$LAB_DIR/scripts/verify.sh" --state healthy
if [ "$STATE" = broken ]; then bash "$LAB_DIR/scripts/inject-fault.sh" upstream-port; fi
ok "Reset concluído no estado: $STATE"
