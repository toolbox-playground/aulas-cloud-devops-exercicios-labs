#!/usr/bin/env bash
# Uso: bash scripts/verify.sh --state healthy|broken
source "$(dirname "$0")/lib.sh"
parse_state healthy "$@"

avail="$(k get deploy web -o jsonpath='{.status.availableReplicas}' 2>/dev/null || true)"
[ "${avail:-0}" -ge 1 ] || die "O Deployment web não está disponível."
ok "Deployment web: ${avail} réplica(s) Ready"

i=0; eps=0; out=""; code=""
while [ "$i" -lt 30 ]; do
  eps="$(ready_endpoints)"; out="$(http_from_client)"; code="$(printf '%s' "$out" | tail -n1)"
  if [ "$STATE" = healthy ] && [ "$eps" -ge 1 ] && [ "$code" = 200 ]; then break; fi
  if [ "$STATE" = broken ] && [ "$eps" -eq 0 ] && [ "$code" != 200 ]; then break; fi
  sleep 1; i=$((i + 1))
done
if [ "$STATE" = healthy ]; then
  [ "$eps" -ge 1 ] || die "O EndpointSlice do Service web não tem destino Ready."
  [ "$code" = 200 ] || die "Requisição pelo Service falhou (código: ${code:-sem resposta})."
  printf '%s' "$out" | grep -q 'TBX AI lab' || die "O Service respondeu, mas não com a página do lab."
  ok "EndpointSlice com $eps destino(s) Ready"
  ok "http://web/ (de dentro do cluster) → 200 com a página do lab"
else
  [ "$eps" -eq 0 ] || die "Esperava o Service sem destinos, mas há $eps."
  [ "$code" != 200 ] || die "Esperava falha pelo Service, mas recebi 200."
  ok "Service web sem destinos Ready, com o Deployment saudável"
  ok "http://web/ (de dentro do cluster) → falha (código: ${code:-sem resposta})"
fi
