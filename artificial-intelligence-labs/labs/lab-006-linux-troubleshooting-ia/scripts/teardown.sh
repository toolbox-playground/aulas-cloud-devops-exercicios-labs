#!/usr/bin/env bash
# Remove só os containers e a rede do projeto tbx-aiops-linux e restaura a configuração saudável.
source "$(dirname "$0")/lib.sh"
compose down --remove-orphans
write_healthy_conf
ok "Projeto $PROJECT removido. Nenhum outro container foi tocado."
