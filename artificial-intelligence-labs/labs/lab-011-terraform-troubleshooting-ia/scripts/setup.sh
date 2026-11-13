#!/usr/bin/env bash
# Uso: bash scripts/setup.sh --state healthy|broken
source "$(dirname "$0")/lib.sh"
parse_state healthy "$@"
preflight
restore_template
info "terraform init (baixa o provider hashicorp/local na primeira vez)"
tf init -input=false -no-color >/dev/null
info "Aplicando o estado inicial (só arquivos locais em workspace/saida/)"
tf apply -input=false -no-color -auto-approve >/dev/null
bash "$LAB_DIR/scripts/verify.sh" --state healthy
if [ "$STATE" = broken ]; then bash "$LAB_DIR/scripts/inject-fault.sh" template-renomeado; fi
ok "Lab 011 pronto no estado: $STATE"
