#!/usr/bin/env bash
# Funções comuns do lab 007. Compatível com bash 3.2 (macOS), Linux e WSL.
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WS="$LAB_DIR/workspace"
CLUSTER="tbx-aiops"
CTX="kind-$CLUSTER"
NS="tbx-ai-lab"
MARKER="$LAB_DIR/.state/cluster-criado-pelo-lab"
SVC="$WS/manifests/30-service.yaml"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m OK\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31mERRO\033[0m %s\n' "$*" >&2; exit 1; }

# todo kubectl do lab usa o contexto e o namespace explícitos (não muda o contexto atual)
k() { kubectl --context "$CTX" --namespace "$NS" "$@"; }

parse_state() {
  local default="$1"; shift
  STATE="$default"
  if [ "${1:-}" = "--state" ]; then STATE="${2:-}"; elif [ -n "${1:-}" ]; then STATE="${1#--state=}"; fi
  case "$STATE" in healthy|broken) ;; *) die "Use --state healthy ou --state broken" ;; esac
}

preflight() {
  command -v docker >/dev/null || die "Docker não encontrado."
  docker info >/dev/null 2>&1 || die "O Docker não está rodando."
  command -v kind >/dev/null || die "kind não encontrado. Veja https://kind.sigs.k8s.io/docs/user/quick-start/#installation"
  command -v kubectl >/dev/null || die "kubectl não encontrado. Veja https://kubernetes.io/docs/tasks/tools/"
}

cluster_exists() { kind get clusters 2>/dev/null | grep -qx "$CLUSTER"; }

write_service() {
  local app="$1"
  cat > "$SVC" <<YAML
apiVersion: v1
kind: Service
metadata:
  name: web
  namespace: tbx-ai-lab
spec:
  selector:
    app: $app
  ports:
    - port: 80
      targetPort: 80
YAML
}

# número de endereços prontos no EndpointSlice do Service web
ready_endpoints() {
  k get endpointslices -l kubernetes.io/service-name=web \
    -o jsonpath='{range .items[*].endpoints[?(@.conditions.ready==true)]}{.addresses[0]}{"\n"}{end}' 2>/dev/null | grep -c . || true
}

# requisição nova pelo Service, de dentro do cluster
http_from_client() { k exec client -- curl -s -m 5 -w '\n%{http_code}' http://web/ 2>/dev/null || true; }
