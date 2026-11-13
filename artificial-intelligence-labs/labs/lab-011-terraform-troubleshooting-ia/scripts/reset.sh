#!/usr/bin/env bash
# Uso: bash scripts/reset.sh --state healthy|broken
source "$(dirname "$0")/lib.sh"
parse_state broken "$@"
git -C "$WS" checkout -- main.tf variables.tf 2>/dev/null || true   # desfaz edições do agente nos .tf
restore_template
tf apply -input=false -no-color -auto-approve >/dev/null
bash "$LAB_DIR/scripts/verify.sh" --state healthy
if [ "$STATE" = broken ]; then bash "$LAB_DIR/scripts/inject-fault.sh" template-renomeado; fi
ok "Reset concluído no estado: $STATE"
