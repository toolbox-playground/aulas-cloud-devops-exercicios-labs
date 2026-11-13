#!/usr/bin/env bash
# Uso: bash scripts/verify.sh --state healthy|broken
source "$(dirname "$0")/lib.sh"
parse_state healthy "$@"
set +e; out="$(tf plan -input=false -no-color -detailed-exitcode 2>&1)"; rc=$?; set -e
if [ "$STATE" = healthy ]; then
  [ "$rc" -eq 0 ] || { printf '%s\n' "$out" | tail -n 15; die "Esperava 'No changes' no plan (exit 0) e recebi exit $rc."; }
  ok "terraform plan: No changes (código, template e state coerentes)"
else
  [ "$rc" -eq 1 ] || die "Esperava o plan falhando (exit 1) e recebi exit $rc."
  printf '%s' "$out" | grep -q 'no file exists' || die "O plan falhou por outro motivo:\n$out"
  ok "terraform plan falha: o template referenciado no main.tf não existe"
fi
