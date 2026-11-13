#!/usr/bin/env bash
# Uso: bash scripts/reset.sh --state healthy|broken
source "$(dirname "$0")/lib.sh"
parse_state broken "$@"
cluster_exists && [ -f "$MARKER" ] || die "Cluster do lab não encontrado. Rode: bash scripts/setup.sh --state $STATE"
write_service web
kubectl --context "$CTX" apply -f "$WS/manifests/" >/dev/null
bash "$LAB_DIR/scripts/verify.sh" --state healthy
if [ "$STATE" = broken ]; then bash "$LAB_DIR/scripts/inject-fault.sh" service-selector; fi
ok "Reset concluído no estado: $STATE"
