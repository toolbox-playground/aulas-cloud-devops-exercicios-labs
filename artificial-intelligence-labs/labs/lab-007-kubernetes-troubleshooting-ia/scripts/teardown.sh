#!/usr/bin/env bash
# Apaga o cluster tbx-aiops SOMENTE se ele foi criado por este lab, e restaura o manifesto saudável.
source "$(dirname "$0")/lib.sh"
if cluster_exists; then
  [ -f "$MARKER" ] || die "O cluster '$CLUSTER' não foi criado por este lab. Não vou apagá-lo."
  kind delete cluster --name "$CLUSTER"
fi
rm -f "$MARKER"
write_service web
ok "Cluster do lab removido. Outros clusters e contextos não foram tocados."
