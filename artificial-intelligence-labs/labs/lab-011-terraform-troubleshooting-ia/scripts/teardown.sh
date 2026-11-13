#!/usr/bin/env bash
# Remove só o que este lab criou: arquivos em saida/, state e .terraform do workspace.
source "$(dirname "$0")/lib.sh"
restore_template
if [ -d "$WS/.terraform" ]; then tf destroy -input=false -no-color -auto-approve >/dev/null || true; fi
rm -rf "$WS/.terraform" "$WS/.terraform.lock.hcl" "$WS"/terraform.tfstate* "$WS/saida"
ok "Lab 011 limpo."
