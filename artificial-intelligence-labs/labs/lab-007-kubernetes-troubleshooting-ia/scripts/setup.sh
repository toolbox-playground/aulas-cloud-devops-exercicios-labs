#!/usr/bin/env bash
# Uso: bash scripts/setup.sh --state healthy|broken
source "$(dirname "$0")/lib.sh"
parse_state healthy "$@"
preflight
mkdir -p "$(dirname "$MARKER")"
if cluster_exists; then
  [ -f "$MARKER" ] || die "Já existe um cluster kind '$CLUSTER' que não foi criado por este lab. Não vou reutilizá-lo."
  info "Reutilizando o cluster $CLUSTER criado por este lab"
else
  info "Criando o cluster kind $CLUSTER (pode levar 1-2 minutos)"
  kind create cluster --name "$CLUSTER" --wait 300s
  date > "$MARKER"
fi
info "Carregando as imagens no cluster (baixa no host se faltar)"
for img in nginx:1.27-alpine curlimages/curl:8.11.1; do
  docker image inspect "$img" >/dev/null 2>&1 || docker pull -q "$img" >/dev/null
  kind load docker-image "$img" --name "$CLUSTER" >/dev/null
done
info "Aplicando os manifestos saudáveis"
write_service web
kubectl --context "$CTX" wait --for=condition=Ready node --all --timeout=300s >/dev/null
kubectl --context "$CTX" apply -f "$WS/manifests/00-namespace.yaml" >/dev/null
# o namespace recém-criado demora um instante para ganhar a service account default
i=0; until k get serviceaccount default >/dev/null 2>&1; do i=$((i + 1)); [ "$i" -lt 60 ] || die "Service account default não apareceu no namespace $NS."; sleep 1; done
kubectl --context "$CTX" apply -f "$WS/manifests/" >/dev/null
k rollout status deploy/web --timeout=300s
k wait --for=condition=Ready pod/client --timeout=180s >/dev/null
bash "$LAB_DIR/scripts/verify.sh" --state healthy
if [ "$STATE" = broken ]; then bash "$LAB_DIR/scripts/inject-fault.sh" service-selector; fi
ok "Lab 007 pronto no estado: $STATE"
