#!/usr/bin/env bash
# Uso: bash scripts/inject-fault.sh service-selector
# Injeta UMA falha: o Service passa a selecionar app=web-v2 (os Pods têm app=web).
# Muda o recurso vivo E o manifesto do workspace, para o agente corrigir a fonte declarativa.
source "$(dirname "$0")/lib.sh"
[ "${1:-}" = "service-selector" ] || die "Uso: bash scripts/inject-fault.sh service-selector"
info "Conferindo o estado saudável antes de injetar a falha"
bash "$LAB_DIR/scripts/verify.sh" --state healthy
info "Injetando a falha"
k patch service web --type merge -p '{"spec":{"selector":{"app":"web-v2"}}}' >/dev/null
write_service web-v2
bash "$LAB_DIR/scripts/verify.sh" --state broken
ok "Falha injetada. Agora abra o agente dentro de workspace/."
