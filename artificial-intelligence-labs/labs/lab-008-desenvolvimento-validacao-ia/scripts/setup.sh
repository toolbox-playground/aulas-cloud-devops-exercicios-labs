#!/usr/bin/env bash
# Cria uma cópia de trabalho do starter em app/ com um commit de baseline (git local).
set -euo pipefail
LAB_DIR="$(cd "$(dirname "$0")/.." && pwd)"
APP="$LAB_DIR/app"
command -v node >/dev/null || { echo "Node.js 20+ não encontrado: https://nodejs.org" >&2; exit 1; }
command -v python3 >/dev/null || { echo "python3 não encontrado (usado pelo servidor local)" >&2; exit 1; }
command -v git >/dev/null || { echo "git não encontrado" >&2; exit 1; }
[ ! -e "$APP" ] || { echo "Já existe $APP. Para recomeçar: bash scripts/reset.sh" >&2; exit 1; }
cp -R "$LAB_DIR/starter" "$APP"
git -C "$APP" init -q -b main
git -C "$APP" add -A
git -C "$APP" -c user.name="lab-008" -c user.email="lab-008@example.invalid" commit -q -m "baseline: starter do painel de serviços"
(cd "$APP" && npm test --silent >/dev/null) && echo " OK testes do starter passando"
echo " OK app/ pronta. Rode: cd app && npm run dev   (http://127.0.0.1:5173)"
