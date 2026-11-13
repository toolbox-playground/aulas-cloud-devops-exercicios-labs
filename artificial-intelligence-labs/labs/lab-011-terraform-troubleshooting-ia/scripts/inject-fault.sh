#!/usr/bin/env bash
# Uso: bash scripts/inject-fault.sh template-renomeado
# Simula um refactor incompleto: o template foi renomeado e o main.tf continua apontando para o nome antigo.
source "$(dirname "$0")/lib.sh"
[ "${1:-}" = "template-renomeado" ] || die "Uso: bash scripts/inject-fault.sh template-renomeado"
bash "$LAB_DIR/scripts/verify.sh" --state healthy
mv "$TPL_OK" "$TPL_RENOMEADO"
bash "$LAB_DIR/scripts/verify.sh" --state broken
ok "Falha injetada. Agora abra o agente dentro de workspace/."
